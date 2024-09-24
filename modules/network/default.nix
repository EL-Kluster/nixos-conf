{lib, ...}:

with lib;
{
  imports = [
    ./fail2ban.nix
    ./firewall.nix
  ];
}