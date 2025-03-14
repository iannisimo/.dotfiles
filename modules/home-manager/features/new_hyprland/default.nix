{
    pkgs,
    config,
    lib,
    inputs,
    ...
}:
let
    hyprland = inputs.hyprland.packages.${pkgs.system}.default;
    xdg-desktop-portal-hyprland = inputs.hyprland.packages.${pkgs.system}.xdg-desktop-portal-hyprland;
    # alacritty_cwd = (pkgs.writeShellScriptBin "alacritty_cwd" (builtins.readFile ../hyprland/alacritty_cwd));
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

            exec-once = [];

            general = {
              layout = "master";
              gaps_in = 5;
              gaps_out = 10;
            };

            decoration = {
                rounding = 5;
            };

            master = {
                mfact = 0.75;
            };

            monitor = [
                # Internal
                "eDP-1,1920x1080@60,10000x10000,1"
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

            "$mod" = "SUPER";
            "$hypr" = "MOD2";

            bind = [
                "$mod, Return, exec, alacritty"
                "$mod shift, Return, exec, ${alacritty_cwd}/bin/alacritty_cwd"
                "$hypr, Z, exec, zen"
                "$hypr, T, exec, telegram-desktop"

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
}
