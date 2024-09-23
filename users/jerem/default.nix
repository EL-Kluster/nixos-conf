{ pkgs, ... }:

let
  sshKey = builtins.readFile ./id_rsa.pub;
in {
  users.users.jerem = {
    isNormalUser = true;
    description = "Jerem Woirhaye";
    home = "/home/jerem";
    group = "users";
    shell = pkgs.bash;
    extraGroups = [ "wheel" ];  
    openssh.authorizedKeys.keys = [ sshKey ];
  };
}
