{ config, inputs, pkgs, ...}: {

  imports = [
    ../common
    ./k8s.nix
  ];

}