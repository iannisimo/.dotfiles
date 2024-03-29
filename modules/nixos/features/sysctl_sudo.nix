{
  pkgs,
  config,
  ...
}: {
  security.sudo = {
    enable = true;
    extraRules = [{
      commands = [
        {
          command = "${config.system.path}/bin/systemctl suspend";
          options = [ "NOPASSWD" ];
        }
        {
          command = "${config.system.path}/bin/systemctl poweroff";
          options = [ "NOPASSWD" ];
        }
        {
          command = "${config.system.path}/bin/systemctl reboot";
          options = [ "NOPASSWD" ];
        }
      ];
      groups = [ "wheel" ];
    }];
  };
}