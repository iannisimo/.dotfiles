{
  pkgs,
  config,
  lib,
  ...
}: {
  programs.neovim = {
    enable = true;
    viAlias = true;
    vimAlias = true;
    plugins = with pkgs.vimPlugins; [
      vim-nix
      copilot-vim
      nvim-lspconfig
      nvim-treesitter.withAllGrammars
      rust-tools-nvim
      vim-just
      vim-nickel
      zig-vim

      # telescope
      plenary-nvim
      telescope-nvim

      # theme
      tokyonight-nvim

      # floaterm
      vim-floaterm

      # extras
      comment-nvim
      copilot-lua
      gitsigns-nvim
      lualine-nvim
      noice-nvim
      nui-nvim
      nvim-colorizer-lua
      nvim-notify
      nvim-treesitter-context
      nvim-web-devicons
      omnisharp-extended-lsp-nvim
      rainbow-delimiters-nvim
      trouble-nvim
    ];
  };  
}
