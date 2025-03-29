{ pkgs, ... }:
{
  services = {
    swayidle = {
      enable = false;
      
      timeouts = [
        { timeout = 60; command = "swaymsg 'output * dpms off'"; resumeCommand = "swaymsg 'output * dpms on'"; }
        { timeout = 90; command = "${pkgs.systemd}/bin/systemctl suspend"; }
      ];
      events = [
        { event = "before-sleep"; command = "loginctl lock-session"; }
        { event = "lock"; command = "pidof ${pkgs.hyprlock}/bin/hyprlock || ${pkgs.hyprlock}/bin/hyprlock"; }
      ];
    };
    
    hypridle = {
      enable = true;
      settings = {
        general = {
          lock_cmd = "pidof ${pkgs.hyprlock}/bin/hyprlock || ${pkgs.hyprlock}/bin/hyprlock"; # Avoid starting multiple ${pkgs.hyprlock}/bin/hyprlock instances.
          before_sleep_cmd = "loginctl lock-session"; # Lock before suspend.
          after_sleep_cmd = "hyprctl dispatch dpms on"; # Avoid pressing a key twice to turn on the display.
        };

        listeners = [
          {
            timeout = 5; # 2.5 min
            on-timeout = "brightnessctl -s set 10"; # Set monitor backlight to minimum.
            on-resume = "brightnessctl -r"; # Restore monitor backlight.
          }
          {
            timeout = 150; # 2.5 min
            on-timeout = "brightnessctl -sd rgb:kbd_backlight set 0"; # Turn off keyboard backlight.
            on-resume = "brightnessctl -rd rgb:kbd_backlight"; # Restore keyboard backlight.
          }
          {
            timeout = 300; # 5 min
            on-timeout = "loginctl lock-session"; # Lock screen after timeout.
          }
          {
            timeout = 3; # 5.5 minimum
            # on-timeout = "hyprctl dispatch dpms off";
            on-timeout = "swaymsg 'output * dpms off'";
            # on-resume = "hyprctl dispatch dpms on";
            on-resume = "swaymsg 'output * dpms on'";
          }
          {
            timeout = 1800; # 30 min
            on-timeout = "systemctl suspend"; # Suspend system.
          }
        ];
      };
    };
  };
}
