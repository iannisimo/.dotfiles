let
  simone-desktop = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIM+coXtOKoz0hlaRAFqm9hxv1dd6jKOmFw1hvhShrI0L";
  simone-laptop = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIOLRy60P1mlmGdN0EHs4EVVGQ34VLfAUPp6XUtQsaCnw";
  simone = [ simone-desktop simone-laptop ];
in {
  "desktop-cloudflared.age".publicKeys = [ simone-desktop ];
  "ssh_config.age".publicKeys = [ simone-desktop simone-laptop ];
}