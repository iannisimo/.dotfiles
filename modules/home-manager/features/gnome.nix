{
  pkgs,
  config,
  lib,
  ...
}: {
  dconf.settings = {

    "org/gnome/shell" = {
      disabled-extensions = [];
      disable-user-extensions = false;

      enabled-extensions = [
        "user-theme@gnome-shell-extensions.gcampax.github.com"
        "caffeine@patapon.info"
        "net-label@slimani.dev"
        "drive-menu@gnome-shell-extensions.gcampax.github.com"
        "auto-move-windows@gnome-shell-extensions.gcampax.github.com"
        "launch-new-instance@gnome-shell-extensions.gcampax.github.com"
      ];

    };

    "org/gnome/desktop/input-sources" = {
      xkb-options = [
        "terminate:ctrl_alt_bksp"
        "shift:both_capslock_cancel"
        "caps:escape"
      ];
      show-all-sources = true;
    };

    "org/gnome/settings-daemon/plugins/media-keys" = {
      custom-keybindings = [
        "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/"
      ];
    };

    "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0" = {
      name = "Terminal";
      binding = "<Super>Return";
      command = "alacritty";
    };
    "org/gnome/desktop/wm/keybindings" = {
      close = ["<Super>w"];
    };
  };

  home = {
    packages = with pkgs; [
      gnomeExtensions.user-themes

      dconf-editor

      libvncserver
      gnome-remote-desktop
    ];
  };


}
