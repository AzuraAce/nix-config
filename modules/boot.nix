{ pkgs, lib, config, ... }: {
  options = {
    dualBoot.enable = lib.mkEnableOption "Enable GRUB for dual booting";
  };

  config = {
    # Always enable EFI
    boot.loader.efi.canTouchEfiVariables = true;

    # Conditional bootloader selection
    boot.loader = {
      systemd-boot.enable = !config.dualBoot.enable; # Enable by default, disable if dual boot is enabled
      grub = {
        enable = config.dualBoot.enable; # Enable only if dual boot is enabled
        device = lib.mkIf config.dualBoot.enable "nodev";  # Required for EFI
        useOSProber = lib.mkIf config.dualBoot.enable true; # Detect other OSes
        efiSupport = lib.mkIf config.dualBoot.enable true;
        theme = pkgs.fetchFromGitHub {
                        owner = "Hitori-Laura";
                        repo = "OsageChan_GRUB_theme";
                        rev = "aa766dc5df9f03ffebbb5d876d8fa71fce719553";
                        sha256 = "EhvGE8NrRytMti+37kvl1t4RaFPDhzk3pHX02WKCCak=";
                };
      };
    };
  };
}

