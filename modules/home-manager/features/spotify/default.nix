{
  pkgs,
  inputs,
  ...
}: let
  spicePkgs = inputs.spicetify-nix.legacyPackages.${pkgs.system};
  spicetify = inputs.spicetify-nix.lib.mkSpicetify pkgs {
    theme = spicePkgs.themes.text;
    colorScheme = "CatppuccinMocha";
    enabledExtensions = with spicePkgs.extensions; [
      fullAppDisplay
      keyboardShortcut
      shuffle
      trashbin
      powerBar
      history
      betterGenres
      hidePodcasts
      playNext
      randomBadToTheBoneRiff
      oneko
      simpleBeautifulLyrics
    ];
  };
in {
  home.packages = [ spicetify ];

  programs.ncmpcpp = {
    enable = true;
  };
}
