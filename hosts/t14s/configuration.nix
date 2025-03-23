{ config, lib, pkgs, inputs, ... }:
{
  imports = [
    ./hardware-configuration.nix
    ../../modules
  ];

  networking.hostName = "t14s";

  programs.zsh.enable = true;
  users.users.oliver = {
    isNormalUser = true;
    home="/home/oliver";
    shell=pkgs.zsh;
    extraGroups = [ "wheel" "networkmanager" ]; 
  };

  tlp.enable = true;
  dualBoot.enable = true;
  bluetooth.enable = false;

  system.stateVersion = "24.05";
}
