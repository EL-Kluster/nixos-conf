{lib, pkgs,outputs, ...}:

with lib;
{
  imports = [
    ../../users
    ./hardware-configuration.nix
  ] ++ (builtins.attrValues outputs.nixosModules);

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