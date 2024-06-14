{
  pkgs,
  lib,
  config,
  ...
}: {
  environment.systemPackages = with pkgs; [
    (vscode-with-extensions.override {
      vscodeExtensions = with vscode-extensions; [
        
        bbenoist.nix
        arrterian.nix-env-selector
        mkhl.direnv

        github.copilot
        github.copilot-chat
        donjayamanne.githistory

        ms-vscode-remote.remote-ssh
        ms-vscode-remote.remote-containers

        ms-toolsai.jupyter
        ms-toolsai.vscode-jupyter-slideshow
        ms-toolsai.vscode-jupyter-cell-tags
        ms-toolsai.jupyter-renderers
        ms-python.python
        ms-python.vscode-pylance

        ms-vscode.cpptools
        ms-vscode.cpptools-extension-pack
        ms-vscode.makefile-tools
        twxs.cmake

        ms-azuretools.vscode-docker
        mechatroner.rainbow-csv
        hookyqr.beautify
        tomoki1207.pdf
        ms-vscode.hexeditor

      ] ++ pkgs.vscode-utils.extensionsFromVscodeMarketplace [
        {
          name = "overleaf-workshop";
          publisher = "iamhyc";
          version = "0.12.0";
          sha256 = "sha256-uxsbqBJEaQxf+DmSdi2uXGK3J+qmzdUyYohTaKqpe2k=";
        }
      ] ++ pkgs.vscode-utils.extensionsFromVscodeMarketplace [
        {
          name = "yuck";
          publisher = "eww-yuck";
          version = "0.0.3";
          sha256 = "sha256-DITgLedaO0Ifrttu+ZXkiaVA7Ua5RXc4jXQHPYLqrcM=";
        }
      ] ++ pkgs.vscode-utils.extensionsFromVscodeMarketplace [
        {
          name = "remote-server";
          publisher = "ms-vscode";
          version = "1.6.2024041609";
          sha256 = "sha256-2MwWoZlN9uVSPbN5K+yBXuCwTIpgoNQ1AEadxUn40zQ=";
        }
      ];
    })
  ];
}

# MISSING
# ms-python.debugpy
# ms-toolsai.jupyter-keymap
