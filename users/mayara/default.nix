{ pkgs, ... }:

let
  sshKey = builtins.readFile ./id_rsa.pub;
in {
  users.users.mayara = {
    isNormalUser = true;
    description = "Mayara Castro";
    home = "/home/mayara";
    group = "users";
    shell = pkgs.bash;
    extraGroups = [ ]; 
    openssh.authorizedKeys.keys = [ sshKey ];
  };

  home-manager.users.mayara = { pkgs, ... }: {
    home.packages = with pkgs; [
      neovim
      git
    ];

    home.stateVersion = "23.05";
  };
  
}
