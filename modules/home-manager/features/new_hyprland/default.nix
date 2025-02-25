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
in {
    wayland.windowManager.hyprland = {
        enable = true;
        package = hyprland;
        xwayland.enable = true;
        systemd.enable = true;

        settings = {
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
                kb_layout = "us,graphite,colemak_dh";
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
                "$hypr, Z, exec, zen"
                "$hypr, T, exec, telegram-desktop"
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