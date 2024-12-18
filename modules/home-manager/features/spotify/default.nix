{
  pkgs,
  inputs,
  ...
}: let
  spicePkgs = inputs.spicetify-nix.packages.${pkgs.system}.default;
in {

  imports = [ inputs.spicetify-nix.homeManagerModules ];

  programs.spicetify = {
    enable = true;
    theme = spicePkgs.themes.catppuccin;
    colorScheme = "mocha";

    enabledExtensions = with spicePkgs.extensions; [
      fullAppDisplay
      shuffle
      hidePodcasts
      loopyLoop
      popupLyrics
      trashbin
    ];

    enabledCustomApps = with spicePkgs.apps; [
      lyrics-plus
      nameThatTune
    ];
  };
}
