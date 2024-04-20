let
  simone-desktop = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIM+coXtOKoz0hlaRAFqm9hxv1dd6jKOmFw1hvhShrI0L";
  simone-laptop = "ssh-ed25519 TODO";
  simone = [ simone-desktop ];
in {
  "desktop-cloudflared.age".publicKeys = [ simone-desktop ];
  "ssh_config.age".publicKeys = simone;
}