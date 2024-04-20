let
  simone = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIM+coXtOKoz0hlaRAFqm9hxv1dd6jKOmFw1hvhShrI0L";
  users = [ simone ];
in {
  "desktop-cloudflared.age".publicKeys = [ simone ];
}