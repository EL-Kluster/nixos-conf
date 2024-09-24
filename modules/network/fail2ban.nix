{lib, ...}:
with lib;
{
   services.fail2ban = {
    enable = true;
    bantime = "10m";
    maxretry = 5;
    bantime-increment = {
      enable = true; 
      multipliers = "1 2 4 8 16 32 64";
      maxtime = "48h"; 
    };
    ignoreIP = [
      "127.0.0.1/8"
      "10.0.0.0/8" 
      "172.16.0.0/12" 
      "192.168.0.0/16"
    ];
  };
}