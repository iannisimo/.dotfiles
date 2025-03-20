{
  pkgs,
  config,
  ...
}: {
  age.secrets.mopidy = {
    file = ./agenix/secrets/mopidy.age;
    mode = "770";
    owner = "mopidy";
    group = "mopidy";
  };

  services.mopidy = {
    enable = true;
    extensionPackages = with pkgs; [ mopidy-spotify ];
    extraConfigFiles = [ config.age.secrets.mopidy.path ];
  };
}
