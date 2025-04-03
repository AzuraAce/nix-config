{ config, lib, pkgs, inputs, outputs, ... }:
{
  imports = [
    ./hardware-configuration.nix
    ../../modules
  ];

  networking.hostName = "t14s";

  # Enable Wayland for Electron Apps
  # environment.sessionVariables.NIXOS_OZONE_WL = "1";

  programs.zsh.enable = true;
  users.users.oliver = {
    isNormalUser = true;
    home="/home/oliver";
    shell=pkgs.zsh;
    extraGroups = [ "wheel" "networkmanager" "video" "audio" ]; 
  };

  tlp.enable = true;
  dualBoot.enable = true;
  bluetooth.enable = false;

  system.stateVersion = "24.05";
}
