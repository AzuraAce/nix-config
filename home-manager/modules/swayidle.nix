{ pkgs, config, ... }:
{
  services.swayidle = {
    enable = true;
    
    timeouts = [
      { timeout = 60; command = "swaymsg 'output * dpms off'"; resumeCommand = "swaymsg 'output * dpms on'"; }
      { timeout = 90; command = "${pkgs.systemd}/bin/systemctl suspend"; }
    ];
  };
}
