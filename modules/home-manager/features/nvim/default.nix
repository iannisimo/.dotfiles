{ pkgs, ... }:
let

  treesitterWithGrammars = (pkgs.vimPlugins.nvim-treesitter.withPlugins (p: [
    p.bash
    p.comment
    p.css
    p.dockerfile
    p.fish
    p.gitattributes
    p.gitignore
    p.go
    p.gomod
    p.gowork
    p.hcl
    p.javascript
    p.jq
    p.json5
    p.json
    p.lua
    p.make
    p.markdown
    p.nix
    p.python
    p.rust
    p.toml
    p.typescript
    p.vue
    p.yaml
  ]));

  treesitter-parsers = pkgs.symlinkJoin {
    name = "treesitter-parsers";
    paths = treesitterWithGrammars.dependencies;
  };
in
{
  home.packages = with pkgs; [
    ripgrep
    fd
    lua-language-server
    stylua
    rust-analyzer-unwrapped
    black
    nodejs_22
    gh
  ];

  programs.neovim = {
    enable = true;
    package = pkgs.neovim;
    vimAlias = true;
    viAlias = true;
    coc.enable = false;
    withNodeJs = true;

    plugins = [
      treesitterWithGrammars
    ];
  };

  xdg.configFile."nvim/lua".source = ./lua;

  xdg.configFile."nvim/lua/kidsan/init.lua".text = ''
    require("kidsan.set")
    require("kidsan.remap")
    vim.opt.runtimepath:append("${treesitter-parsers}")
  '';

  # Treesitter is configured as a locally developed module in lazy.nvim
  # we hardcode a symlink here so that we can refer to it in our lazy config
  xdg.dataHome."nvim/nix/nvim-treesitter/" = {
    recursive = true;
    source = treesitterWithGrammars;
  };

}