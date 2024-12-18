{
  pkgs,
  ...
}: let 
  script = ''
#!/usr/bin/env bash
curl "http://livornowififreecaptive.hs/login" -d "username=freecaptive" -d "password=nagx.U4Uf." >/dev/null 2>&1
'';
in {
  home.packages = [
    ( pkgs.writeShellScriptBin "livornowifi" script )
  ];
}
