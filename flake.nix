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
      url = "github:ralismark/eww/tray-3";
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
  };

  outputs = {...} @ inputs: 
  let
    myLib = import ./myLib { inherit inputs; };
  in with myLib;
  {
    nixosConfigurations = {
      
      laptop = mkSystem ./hosts/laptop/configuration.nix;

    };

    homeConfigurations = {
      
      "simone@laptop" = mkHome "x86_64-linux" ./hosts/laptop/home.nix;

    };

    homeManagerModules.default = ./modules/home-manager;
    nixosModules.default = ./modules/nixos;
  };
}
