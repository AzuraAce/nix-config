{
  services = {
    printing.enable = true;
    tailscale.enable = true;
    davfs2.enable = true;
    xserver.xkb.layout = "de";
    udisks2.enable = true;
    hypridle.enable = true;

    # DWM Status bar
    dwm-status = {
      enable = false;
      order = [
        "audio"
        "backlight"
        "network"
        "cpu_load"
        "battery"
        "time"
      ];
      extraConfig = ''
        separator = " | "

        [backlight]
        device = "intel_backlight"
        fallback = "amdgpu_*"
        template = "L {BL}%"
        icons = []
        
        [network]
        no_value = "NA"
        template = "{ESSID}"

        [cpu_load]
        template = "{CL1}"
        update_interval = 20

        [time]
        format = "%d-%m-%Y %H:%M"
        update_seconds = false
      '';
    };
  };
}
