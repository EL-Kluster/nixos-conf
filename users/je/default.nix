{ pkgs, ... }:

let
  sshKey = builtins.readFile ./id_rsa.pub;
in {
  users.users.je = {
    isNormalUser = true;
    description = "Jean-Emmanuel Ehuy";
    home = "/home/je";
    group = "users";
    shell = pkgs.bash;
    extraGroups = [  ];  
    openssh.authorizedKeys.keys = [ sshKey ];
  };

  
}
