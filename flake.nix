{
  description = "Nixos config flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    hyprland = {
      url = "github:hyprwm/Hyprland";
    };

    eww = {
      url = "github:elkowar/eww";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    hyprlock = {
      url = "github:hyprwm/hyprlock";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    hypridle = {
      url = "github:hyprwm/hypridle";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    spicetify-nix = {
      url = "github:the-argus/spicetify-nix";
    };

    isw-nix = {
      url = "github:iannisimo/isw-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixpkgs-howdy = {
      url = "github:fufexan/nixpkgs/howdy";
    };

    agenix = {
      url = "github:ryantm/agenix";
    };

    # sweethome = {
    #   url = "/home/simone/.config/flakes/sweethome3d-nix";
    # };
  };

  outputs = {...} @ inputs: 
  let
    myLib = import ./myLib { inherit inputs; };
  in with myLib;
  {
    nixosConfigurations = {
      
      laptop = mkSystem ./hosts/laptop/configuration.nix;

      desktop = mkSystem ./hosts/desktop/configuration.nix;

    };

    homeConfigurations = {
      
      "simone@laptop" = mkHome "x86_64-linux" ./hosts/laptop/home.nix;

      "simone@desktop" = mkHome "x86_64-linux" ./hosts/desktop/home.nix;

    };

    homeManagerModules.default = ./modules/home-manager;
    nixosModules.default = ./modules/nixos;
  };
}
