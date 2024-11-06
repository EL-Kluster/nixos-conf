{ config, pkgs, ... }:
let
  kubeMasterIP = "10.1.1.2";
  kubeMasterHostname = "api.kube";
  kubeMasterAPIServerPort = 6443;
in
{
  networking.extraHosts = "${kubeMasterIP} ${kubeMasterHostname}";

  networking.firewall = {
    allowedTCPPorts = [ 6443 10250 10259 10257 ];
    allowedUDPPortRanges = [
      { from = 2379; to = 2380; }
    ];
  };

  environment.systemPackages = with pkgs; [
    kompose
    kubectl
    kubernetes
  ];

  services.kubernetes = {
    roles = ["master" "node"];
    masterAddress = kubeMasterHostname;
    apiserverAddress = "https://${kubeMasterHostname}:${toString kubeMasterAPIServerPort}";
    easyCerts = true;
    apiserver = {
      securePort = kubeMasterAPIServerPort;
      advertiseAddress = kubeMasterIP;
    };

    addons.dns.enable = true;

    kubelet.extraOpts = "--fail-swap-on=false";
  };
}