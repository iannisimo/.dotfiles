{
  pkgs,
  lib,
  ...
}: let
  ts = pkgs.vimPlugins.nvim-treesitter.withAllGrammars;
  parsers = pkgs.symlinkJoin {
    name = "nvim-treesitter";
    paths = [ts ts.dependencies];
  };
  plugins = with pkgs.vimPlugins; [
    nvim-treesitter-textobjects 
    parsers 
    # (pkgs.vimPlugins.nvim-treesitter.withPlugins (plugins: with plugins; [
    #   c
    #   cpp
    #   lua
    #   nix
    #   json
    #   javascript
    #   jsx
    #   typescript
    #   css
    #   scss
    #   bash
    # ]))
    nvim-lspconfig
    nvim-ts-autotag
  ];
  mkEntryFromDrv = drv:
    if lib.isDerivation drv then
      { name = "${lib.getName drv}"; path = drv; }
    else
      drv;
  lazyPath = pkgs.linkFarm "lazy-plugins" (builtins.map mkEntryFromDrv plugins);
in {
  home.sessionVariables = {
    EDITOR = "nvim";
  };

  xdg.dataFile."nvim_plugins" = {
    source = lazyPath;
    recursive = true;
  };
  # xdg.dataFile."nvim_plugins/nvim-treesitter/parser".source =
  #   let
  #     parsers = pkgs.symlinkJoin {
  #       name = "treesitter-parsers";
  #       paths = (pkgs.vimPlugins.nvim-treesitter.withAllGrammars.dependencies);
  #     };
  #   in
  #   "${parsers}/parser";


  programs.neovim = {
    defaultEditor = true;
    enable = true;
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;
    withPython3 = true;
    extraPython3Packages = (ps: with ps; [
      pynvim
      jupyter-client
      ueberzug
      pillow
      cairosvg
      pnglatex
      plotly
      pyperclip
      ipykernel
      unidecode
      black
      isort
    ]);

    withNodeJs = true;
    extraPackages = with pkgs; [
      # Helpers
      ripgrep
      fd
      lazygit
      gdu
      bottom
      wl-clipboard
      # LS
      lua-language-server stylua # lua
      nil # NIX
      markdownlint-cli2 marksman # markdown
    ];
  };
}
