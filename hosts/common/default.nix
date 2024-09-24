{lib, pkgs, ...}:

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

  environment = {
    systemPackages = with pkgs; [
      sshfs
    ];
  };

  services.openssh.enable = true;
}