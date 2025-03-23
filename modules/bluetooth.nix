{ pkgs, lib, config, ... }: {
  options = {
    bluetooth.enable = 
      lib.mkEnableOption "enables Bluetooth";
  };

  config = lib.mkIf config.bluetooth.enable {
    hardware.bluetooth.enable = true;
    hardware.bluetooth.powerOnBoot = false;
    services.blueman.enable = true;
  };
}
