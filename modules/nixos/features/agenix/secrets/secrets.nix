let
  system_desktop = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIM+coXtOKoz0hlaRAFqm9hxv1dd6jKOmFw1hvhShrI0L";
  systems = [ system_desktop ];
in {
  "cloudflared.age".publicKeys = [ system_desktop ];
}