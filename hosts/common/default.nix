{lib, ...}:

with lib;
{
  imports = [
    ../../users
  ];

  security.sudo = {
    enable = true;
    wheelNeedsPassword = false; 
  };

  services.openssh.enable = true;
}