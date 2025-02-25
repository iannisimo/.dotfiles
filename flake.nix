{
  description = "Nixos config flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.11";

    unstable-nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager/release-24.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    
    hyprland = {
     type = "git";
     url = "https://github.com/hyprwm/hyprland?rev=882f7ad7d2bbfc7440d0ccaef93b1cdd78e8e3ff";
     submodules = true;
     inputs.nixpkgs.follows = "nixpkgs";
    };

    quickshell = {
      url = "git+https://git.outfoxxed.me/outfoxxed/quickshell";
      inputs.nixpkgs.follows = "nixpkgs";
    };


    zen-browser = {
      url = "github:iannisimo/zen-browser-flake";
      inputs.nixpkgs.follows = "unstable-nixpkgs";
    };

    # eww = {
    #   url = "github:elkowar/eww";
    #   inputs.nixpkgs.follows = "unstable-nixpkgs";
    # };

    hyprlock = {
      url = "github:hyprwm/hyprlock";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    hypridle = {
      url = "github:hyprwm/hypridle";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    #spicetify-nix = {
    #  url = "github:Gerg-L/spicetify-nix";
    #  inputs.nixpkgs.follows = "unstable-nixpkgs";
    #};

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

    nvim = {
      url = "github:iannisimo/nix.nvim/testing";
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
