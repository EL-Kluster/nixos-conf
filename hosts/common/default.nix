{lib, ...}:

with lib;
{
  imports = [
    ../../users
    ./hardware-configuration.nix
  ];

  security.sudo = {
    enable = true;
    wheelNeedsPassword = false; 
  };

  services.openssh.enable = true;
}