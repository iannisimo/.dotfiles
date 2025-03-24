{
pkgs,
inputs,
...
}:
let
  hyprland = inputs.hyprland.packages.${pkgs.system}.default;
  # hyprpanel = inputs.hyprpanel.packages.${pkgs.system}.default;
  xdg-desktop-portal-hyprland = inputs.hyprland.packages.${pkgs.system}.xdg-desktop-portal-hyprland;
  alacritty_cwd = pkgs.writeShellScriptBin "alacritty_cwd"
    ''
      #!/usr/bin/env bash

      parent_pid=$(hyprctl activewindow -j | ${pkgs.jq}/bin/jq '.pid' -r)
      if [[ -z "$parent_pid" ]]; then
      ${pkgs.alacritty}/bin/alacritty
      fi
      child_pid=$(pgrep -P "$parent_pid")
      if [[ -z "$child_pid" ]]; then
      ${pkgs.alacritty}/bin/alacritty
      fi
      pushd /proc/"$child_pid"/cwd
      CWD=$(pwd -P)
      popd

      alacritty --working-directory "$CWD"
    '';
in {
  wayland.windowManager.hyprland = {
    enable = true;
    package = hyprland;
    xwayland.enable = true;
    systemd.enable = true;

    plugins = [
      inputs.Hyprspace.packages.${pkgs.system}.Hyprspace
    ];

    settings = {

      plugin = {
        overview = {
          affectStrut = false;
        };
      };

      "$TOUCHPAD" = "cust0001:00-06cb:cdaa-touchpad";

      general = {
        layout = "master";
        gaps_in = 1;
        gaps_out = 1;
      };

      decoration = {
        rounding = 5;
        active_opacity=0.95;
        inactive_opacity=0.8;
      };

      master = {
        mfact = 0.75;
      };

      monitor = [
        # Internal
        "eDP-1,1920x1080@60,0x0,1"
        # AUTO
        ",preferred,auto,1"
      ];

      env = [
        "XCURSOR_SIZE=24"
      ];

      input = {
        kb_layout = "us";
        kb_variant = "basic";
        kb_model = "";
        kb_options = "shift:both_capslock_cancel,caps:numlock,grp:alts_toggle";
        kb_rules = "";

        follow_mouse = true;

        touchpad.natural_scroll = true;

        sensitivity = 0;
      };

      device = [
        {
          name = "$TOUCHPAD";
          enabled = "true";
        }
      ];

      gestures = {
        workspace_swipe = true;
      };

      misc = {
        disable_hyprland_logo = true;
        key_press_enables_dpms = true;
      };

      cursor = {
        inactive_timeout = 1;
      };

      windowrulev2 = [
        # No Gaps When Only 
        "bordersize 0, floating:0, onworkspace:w[tv1]"
        "rounding 0, floating:0, onworkspace:w[tv1]"
        "bordersize 0, floating:0, onworkspace:f[1]"
        "rounding 0, floating:0, onworkspace:f[1]"
      ];
      
      workspace = [
        "w[tv1], gapsout:0, gapsin:0"
        "f[1], gapsout:0, gapsin:0"
      ];

      "$mod" = "SUPER";
      "$hypr" = "MOD2";

      bind = [
        "$mod, Return, exec, alacritty"
        "$mod shift, Return, exec, ${alacritty_cwd}/bin/alacritty_cwd"
        "$hypr, Z, exec, zen"
        "$hypr, T, exec, telegram-desktop"
        "$mod, Space, exec, rofi -show drun"

        "$mod, w, killactive"
        "$mod, M, layoutmsg, swapwithmaster"

        "$mod, left, movefocus, l"
        "$mod, right, movefocus, r"
        "$mod, up, movefocus, u"
        "$mod, down, movefocus, d"

        "$mod, P, pin"

        "$hypr, M, fullscreen"
        "$mod, T, togglefloating"
        "$hypr, right, layoutmsg, rollnext"
        "$hypr, left, layoutmsg, rollprev"
        "$hypr shift, left, layoutmsg, orientationleft"        
        "$hypr shift, right, layoutmsg, orientationright"
        "$hypr shift, up, layoutmsg, orientationtop"
        "$hypr shift, down, layoutmsg, orientationbottom"
        "$hypr shift, C, layoutmsg, orientationcenter"

        # Fn keys
        ", Print, exec, ${pkgs.grimblast}/bin/grimblast copy area"
        "shift, Print, exec, g${pkgs.grimblast}/bin/rimblast save area - | ${pkgs.feh}/bin/feh -Zx. -"
      ]
        ++ map (n: "$mod SHIFT, ${toString n}, movetoworkspace, ${toString (
          if n == 0
            then 10
          else n
        )}") [1 2 3 4 5 6 7 8 9 0]
        ++ map (n: "$mod, ${toString n}, workspace, ${toString (
          if n == 0
            then 10
          else n
        )}") [1 2 3 4 5 6 7 8 9 0];

      binde = [
        ", XF86AudioRaiseVolume, exec, ${pkgs.pamixer}/bin/pamixer -i 5"
        ", XF86AudioLowerVolume, exec, ${pkgs.pamixer}/bin/pamixer -d 5"
        ", XF86AudioMute, exec, ${pkgs.pamixer}/bin/pamixer -t"
        "SHIFT, XF86AudioRaiseVolume, exec, ${pkgs.pamixer}/bin/pamixer --default-source -i 5"
        "SHIFT, XF86AudioLowerVolume, exec, ${pkgs.pamixer}/bin/pamixer --default-source -d 5"
        ", XF86AudioMicMute, exec, ${pkgs.pamixer}/bin/pamixer --default-source -t"
        ", XF86MonBrightnessUp, exec, ${pkgs.brightnessctl}/bin/brightnessctl set 5%+ -e 2"
        ", XF86MonBrightnessDown, exec, ${pkgs.brightnessctl}/bin/brightnessctl set 5%- -e 2"
        "SHIFT, XF86MonBrightnessUp, exec, ${pkgs.brightnessctl}/bin/brightnessctl set 100%"
        "SHIFT, XF86MonBrightnessDown, exec, ${pkgs.brightnessctl}/bin/brightnessctl set 0%"
      ];

      bindm = [
        "$mod, mouse:272, movewindow"
        "$hypr, mouse:272, resizewindow"
      ];
    };
  };

  home = {
    packages = with pkgs; [
      xdg-desktop-portal
      xdg-desktop-portal-hyprland
      dbus
      xdg-utils
    ];
  };

  myHM.rofi.enable = true;

  # HyprPanel

  imports = [ inputs.hyprpanel.homeManagerModules.hyprpanel ];

  programs.hyprpanel = {
    enable = true;
    hyprland.enable = true;
    overlay.enable = true;
    overwrite.enable = true;
    layout = {
      "bar.layouts" = {
        "0" = {
          left = [ "power" "hyprsunset" "media" ];
          middle = [ "workspaces" ];
          right = [ "volume" "netstat" "bluetooth" "battery" "systray" "clock" "notifications" ];
        };
      };
    };
    settings = {
      wallpaper = {
        enable = true;
        pywal = true;
        image = (builtins.path {path = ./wallpapers/wp_idiots.png;});
      };
      theme = {
        font.size = "1rem";
        bar = {
          floating = true;
          transparent = true;
          outer_spacing = "0.4rem";
        };
      };
    
      bar = {
        customModules = {
          netstat = {
            dynamicIcon = true;
            rateUnit = "MiB";
            labelType = "full";
            label = true;
            leftClick = "menu:network";
          };
          hyprsunset = {
            label = false;
            temperature = "5000K";
          };
        };
        clock.format = "%a %b %d  %H:%M:%S";
        media.show_active_only = true;
      };
      menus = {
        power.powerProfileService = "tlp";
        power.lowBatteryNotification = true;
        power.confirmation = false;
        clock.weather.enabled = false;
        clock.time.military = true;
      };
    };
  };
}

