{ config, pkgs, ... }:
let
  kubeMasterIP = "10.1.1.2";
  kubeMasterHostname = "api.kube";
  kubeMasterAPIServerPort = 6443;
in
{
  networking.extraHosts = "${kubeMasterIP} ${kubeMasterHostname}";

  networking.hostName = "worker";

  networking.firewall = {
      allowedTCPPorts = [ 10250 10256 ];
      allowedUDPPortRanges = [
        { from = 30000; to = 32767; }
      ];
    };

  environment.systemPackages = with pkgs; [
    kompose
    kubectl
    kubernetes
  ];

  services.kubernetes = let
    api = "https://${kubeMasterHostname}:${toString kubeMasterAPIServerPort}";
  in
  {
    roles = ["node"];
    masterAddress = kubeMasterHostname;
    easyCerts = true;

    # point kubelet and other services to kube-apiserver
    kubelet.kubeconfig.server = api;
    apiserverAddress = api;

    addons.dns.enable = true;

    kubelet.extraOpts = "--fail-swap-on=false";
  };
}