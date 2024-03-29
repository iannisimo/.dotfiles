{
  pkgs,
  config,
  lib,
  ...
}: {
  options.myHM.swww = {
    img = lib.mkOption {
      type = lib.types.str;
      default = "Multiverse_waneella.gif";
    };

    imgPath = lib.mkOption {
      type = lib.types.path;
      default = ./wallpapers;
    };

    imgs = lib.mkOption {
      type = lib.types.listOf lib.types.path;
      default = builtins.readDir config.myHM.swww.imgPath;
    };
  };

  home.packages = with pkgs; [
    swww
    (
      pkgs.writeShellScriptBin "swww-cycle" ''
        imgs=($(ls ${config.myHM.swww.imgPath}))
        current=$(swww query | sed -r 's/^.+?image: (.+?)/\1/' | xargs basename)

        index=0
        for img in "''${imgs[@]}"; do
            if [[ $img == $current ]]; then
                break
            fi
            index=$((index+1))
        done
        index=$(($((index+1))%''${#imgs[@]}))

        imgs=("''${imgs[@]/#/${config.myHM.swww.imgPath}/}")

        img=''${imgs[$index]}
        swww img $img --transition-type any --transition-duration 2 --transition-fps 30
      ''
    )
  ];

}