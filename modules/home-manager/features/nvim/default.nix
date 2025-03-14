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
in
{
  programs.neovim = {
    enable = true;
    vimAlias = true;
    viAlias = true;
    coc.enable = false;
    withNodeJs = true;
    withPython3 = true;

    plugins = [
      treesitterWithGrammars
    ];

    extraPackages = [
      ripgrep
      fd
      lua-language-server
      stylua
      rust-analyzer-unwrapped
      black
      nodejs_22
      gh
    ];
  };
}