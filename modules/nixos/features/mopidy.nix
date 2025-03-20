{
  pkgs,
  config,
  ...
}: {
  age.secrets.mopidy = {
    file = ./agenix/secrets/mopidy.age;
    mode = "600";
    owner = "root";
    group = "root";
  };

  services.mopidy = {
    enable = true;
    extensionPackages = with pkgs; [ mopidy-spotify ];
    extraConfigFiles = [ config.age.secrets.mopidy.path ];
  };
}
