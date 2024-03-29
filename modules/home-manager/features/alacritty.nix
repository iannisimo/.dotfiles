{
  pkgs,
  ...
}: {
  home.packages = with pkgs; [
    alacritty
  ];

  home.file."alacritty.conf" = {
    enable = true;
    target = ".config/alacritty/alacritty.toml";
    text = ''
[window]
opacity = 0.6
padding = { x = 10, y = 10 }

[scrolling]
history = 100000

[colors.primary]
foreground = "#ffffff"
'';
  };
}