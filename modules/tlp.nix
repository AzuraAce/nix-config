  # TLP Laptop Power Saving
{ lib, config, ... }:
{
  options = {
    tlp.enable = 
      lib.mkEnableOption "enables TLP Power Saving for Laptops";
  };

  config = lib.mkIf config.tlp.enable {
    services.tlp = {
      enable = true;
      settings = {
        CPU_SCALING_GOVERNOR_ON_BAT = "powersave";
        CPU_SCALING_GOVERNOR_ON_AC = "performance";

        CPU_ENERGY_PERF_POLICY_ON_BAT = "balance_power";
        CPU_ENERGY_PERF_POLICY_ON_AC = "performance";

        RADEON_DPM_PERF_LEVEL_ON_AC="auto";
        RADEON_DPM_PERF_LEVEL_ON_BAT="auto";

        #Optional helps save long term battery health
        START_CHARGE_THRESH_BAT0 = 20; # 20 and below it starts to charge
        STOP_CHARGE_THRESH_BAT0 = 90; # 90 and above it stops charging

      };
    };
  };
}
