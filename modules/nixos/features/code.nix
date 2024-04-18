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
        # github.copilot-chat
        
        ms-vscode-remote.remote-ssh
        ms-vscode-remote.remote-containers

        ms-toolsai.jupyter
        ms-toolsai.vscode-jupyter-slideshow
        ms-toolsai.vscode-jupyter-cell-tags
        ms-toolsai.jupyter-renderers
        ms-python.python
        ms-python.vscode-pylance
        
        ms-azuretools.vscode-docker
        mechatroner.rainbow-csv

      ] ++ pkgs.vscode-utils.extensionsFromVscodeMarketplace [
        {
          name = "overleaf-workshop";
          publisher = "iamhyc";
          version = "0.12.0";
          sha256 = "sha256-uxsbqBJEaQxf+DmSdi2uXGK3J+qmzdUyYohTaKqpe2k=";
        }
      ];
    })
  ];
}

# MISSING
# ms-python.debugpy
# ms-toolsai.jupyter-keymap