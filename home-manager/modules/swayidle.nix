{ pkgs, ... }:
{
  services.swayidle = {
    enable = true;
    
    timeouts = [
      { timeout = 3; command = "swaymsg 'output * dpms off'"; resumeCommand = "swaymsg 'output * dpms on'"; }
      { timeout = 90; command = "${pkgs.systemd}/bin/systemctl suspend"; }
    ];

    events = [
      { event = "lock"; command = "pidof ${pkgs.hyprlock}/bin/hyprlock || ${pkgs.hyprlock}/bin/hyprlock"; }
    ];
  };
}
