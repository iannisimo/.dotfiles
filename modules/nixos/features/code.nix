{
  pkgs,
  lib,
  config,
  ...
}: {
  environment.systemPackages = with pkgs; [
    texlive.combined.scheme-small
    (vscode-with-extensions.override {
      vscodeExtensions = with vscode-extensions; [
        
        bbenoist.nix
        arrterian.nix-env-selector
        mkhl.direnv
   
        donjayamanne.githistory
        streetsidesoftware.code-spell-checker
        chrischinchilla.vscode-pandoc
   
        ms-vscode-remote.remote-ssh
        ms-vscode-remote.remote-containers

        golang.go
   
        ms-toolsai.jupyter
        ms-toolsai.vscode-jupyter-slideshow
        ms-toolsai.vscode-jupyter-cell-tags
        ms-toolsai.jupyter-renderers
        ms-python.python
        batisteo.vscode-django
        # ms-python.vscode-pylance # bugged
   
        # ms-vscode.cpptools
        ms-vscode.cpptools-extension-pack
        ms-vscode.makefile-tools
        twxs.cmake
   
        ms-azuretools.vscode-docker
        mechatroner.rainbow-csv
        hookyqr.beautify
        tomoki1207.pdf
        ms-vscode.hexeditor
        bradlc.vscode-tailwindcss
   
      ] ++ pkgs.vscode-utils.extensionsFromVscodeMarketplace [
        {
          name = "overleaf-workshop";
          publisher = "iamhyc";
          version = "0.12.0";
          sha256 = "sha256-uxsbqBJEaQxf+DmSdi2uXGK3J+qmzdUyYohTaKqpe2k=";
        }
        {
          name = "yuck";
          publisher = "eww-yuck";
          version = "0.0.3";
          sha256 = "sha256-DITgLedaO0Ifrttu+ZXkiaVA7Ua5RXc4jXQHPYLqrcM=";
        }
        {
          name = "remote-server";
          publisher = "ms-vscode";
          version = "1.6.2024041609";
          sha256 = "sha256-2MwWoZlN9uVSPbN5K+yBXuCwTIpgoNQ1AEadxUn40zQ=";
        }
        {
          name = "prolog";
          publisher = "rebornix";
          version = "0.0.4";
          sha256 = "sha256-SZAaG3dFlDbA46s+i36CMBOU5vJ+1bgTgk+TTyi+yhA=";
        }
        {
          name = "postcss";
          publisher = "csstools";
          version = "1.0.9";
          sha256 = "sha256-5pGDKme46uT1/35WkTGL3n8ecc7wUBkHVId9VpT7c2U=";
        }
     ];
    })
  ];
}

# MISSING
# ms-python.debugpy
# ms-toolsai.jupyter-keymap
