{ pkgs, ... }:

let
  sshKey = builtins.readFile ./id_rsa.pub;
in {
  users.users.marius = {
    isNormalUser = true;
    description = "Marius Mignard";
    home = "/home/marius";
    group = "users";
    shell = pkgs.bash;
    extraGroups = [ "wheel" ];  
    openssh.authorizedKeys.keys = [ sshKey ];
  };

  home-manager.users.marius = { pkgs, ... }: {
    home.packages = with pkgs; [
      vim
      neovim
      git
    ];

    home.stateVersion = "23.05";
  };
}
