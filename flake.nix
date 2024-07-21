{
  description = "Nixos config flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.05";

    unstable-nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager/release-24.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    hyprland = {
      url = "git+https://github.com/hyprwm/Hyprland?submodules=1"; 
      inputs.nixpkgs.follows = "nixpkgs";
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
      inputs.nixpkgs.follows = "nixpkgs";
    };

    isw-nix = {
      url = "github:iannisimo/isw-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    agenix = {
      url = "github:ryantm/agenix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    vscode-server = {
      url = "github:nix-community/nixos-vscode-server";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    connecttunnel-nix.url = "github:iannisimo/connecttunnel-nix/dev";

  };

  outputs = {...} @ inputs: 
  let
    myLib = import ./myLib { inherit inputs; };
  in with myLib;
  {
    nixosConfigurations = {
      
      laptop = mkSystem ./hosts/laptop/configuration.nix;

      desktop = mkSystem ./hosts/desktop/configuration.nix;

      hotel = mkSystem ./hosts/hotel/configuration.nix;

    };

    homeConfigurations = {
      
      "simone@laptop" = mkHome "x86_64-linux" ./hosts/laptop/home.nix;

      "simone@desktop" = mkHome "x86_64-linux" ./hosts/desktop/home.nix;
      "hlt@desktop" = mkHome "x86_64-linux" ./hosts/desktop/home_hlt.nix;

      "simone@hotel" = mkHome "x86_64-linux" ./hosts/hotel/home.nix;

    };

    homeManagerModules.default = ./modules/home-manager;
    nixosModules.default = ./modules/nixos;
  };
}
