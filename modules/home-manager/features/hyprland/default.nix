{
  pkgs,
  config,
  lib,
  inputs,
  ...
}: {

  services.swayosd.enable = true;
  myHM.eww.enable = true;
  myHM.rofi.enable = true;
  myHM.hyprlock.enable = true;
  myHM.hypridle.enable = true;
  myHM.swww.enable = true;

  wayland.windowManager.hyprland = {
    enable = true;
    package = inputs.hyprland.packages."${pkgs.system}".hyprland;
    xwayland.enable = true;

    systemd.enable = true;

    settings = {

      exec-once = [
        "swww init && swww img ${config.myHM.swww.imgPath}/${config.myHM.swww.img}"
        "nm-applet"
        "blueman-applet"
        "hypridle"
        "EWW_CONFIG=~/.config/eww EWW_SCRIPTS=~/.config/eww/scripts eww open bar"
      ];

      monitor = [
        # Internal
        "eDP-1,1920x1080@60,10000x10000,1"
        # Desktop
        "desc:Samsung Electric Company U28E590 HTPJ304532,2560x1440,10000x8560,1"
        # Dummy
        "desc:AOC 28E850,1280x800@30,11920x10280,1"
        # AUTO
        ",highrr,auto,1"
      ];

      env = [
        "XCURSOR_SIZE=24"
        "EWW_CONFIG=~/.config/eww"
        "EWW_SCRIPTS=~/.config/eww/scripts"
      ];

      xwayland = {
        force_zero_scaling = true;
      };

      input = {
        kb_layout = "us,us";
        kb_variant = "basic,colemak";
        kb_model = "";
        kb_options = "shift:both_capslock_cancel,caps:numlock,grp:alts_toggle";
        kb_rules = "";

        follow_mouse = true;

        touchpad.natural_scroll = true;

        sensitivity = 0;
      };

      animations = {
        enabled = true;

        bezier = "myBezier, 0.05, 0.9, 0.1, 1.05";

        animation = [
          "windows, 1, 7, myBezier"
          "windowsOut, 1, 7, default, popin 80%"
          "border, 1, 10, default"
          "borderangle, 1, 8, default"
          "fade, 1, 7, default"
          "workspaces, 1, 6, default"
        ];
      };

      gestures = {
        workspace_swipe = true;
        workspace_swipe_forever = true;
      };

      misc = {
        disable_hyprland_logo = true;
        mouse_move_enables_dpms = true;
        key_press_enables_dpms = true;
      };

      # keybindings      
      "$mod" = "SUPER";
      "$hypr" = "MOD2";

      bind = [
        # open apps
        "$mod, Return, exec, alacritty"
        "$hypr, F, exec, firefox"
        "$mod, Space, exec, rofi -show drun"

        # Window management
        "$mod, w, killactive"
        "$mod $hypr, q, exit"

        "$mod, left, movefocus, l"
        "$mod, right, movefocus, r"
        "$mod, up, movefocus, u"
        "$mod, down, movefocus, d"

        "$hypr, M, fullscreen"

        # Fn keys
        ", XF86AudioMute, exec, swayosd-client --output-volume mute-toggle"
        ", XF86AudioMicMute, exec, swayosd-client --input-volume mute-toggle"
        "CTRL SUPER, XF86TouchpadToggle,             exec, hyprctl keyword device:cust0001:00-06cb:cdaa-touchpad:enabled false"
        "CTRL SUPER SHIFT, XF86TouchpadToggle,             exec, hyprctl keyword device:cust0001:00-06cb:cdaa-touchpad:enabled true"
        ", XF86Launch2, exec, rotate-screen"
        "$mod, XF86Launch2, exec, swww-cycle"
        "$hypr, XF86Launch2, exec, swww clear 181818"
        ", Print, exec, grimblast copy area"
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

      # mouse bindings
      bindm = [
        "$mod, mouse:272, movewindow"
        "$hypr, mouse:272, resizewindow"
      ];

      # repeating binds
      binde = [
        ", XF86AudioRaiseVolume, exec, swayosd-client --output-volume raise"
        ", XF86AudioLowerVolume, exec, swayosd-client --output-volume lower"
        "SHIFT, XF86AudioRaiseVolume, exec, swayosd-client --input-volume raise"
        "SHIFT, XF86AudioLowerVolume, exec, swayosd-client --input-volume lower"
        ", XF86MonBrightnessUp, exec, swayosd-client --brightness raise"
        ", XF86MonBrightnessDown, exec, swayosd-client --brightness lower"
      ];

      windowrule = [
        "opacity 0.9 overrite 0.7 override, ^(.*)$"
      ];

      windowrulev2 = [
        "float,class:(firefox),title:(Bitwarden),"
      ];
    };
  };

  home = {
    packages = with pkgs; [
      xdg-desktop-portal
      xdg-desktop-portal-hyprland
      dbus
      xdg-utils

      grimblast
      blueman
      pavucontrol
      brightnessctl
      pamixer
      (
        pkgs.writeShellScriptBin "rotate-screen" ''
          current=$(hyprctl monitors | grep transform | awk '{ print $2 }')
          if [ "$current" = "0" ]; then
            hyprctl keyword monitor eDP-1,1920x1080@60,10000x10000,1,transform,2
          else
            hyprctl keyword monitor eDP-1,1920x1080@60,10000x10000,1,transform,0
          fi
        ''
      )
    ];
  };
}
