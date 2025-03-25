{ pkgs, ... }:
{
    services.hypridle = {
      enable = false;
      settings = {
        general = {
          lock_cmd = "hyprlock"; # Avoid starting multiple hyprlock instances.
          before_sleep_cmd = "loginctl lock-session"; # Lock before suspend.
          after_sleep_cmd = "hyprctl dispatch dpms on"; # Avoid pressing a key twice to turn on the display.
        };

        listeners = [
          {
            timeout = 150; # 2.5 min
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
            timeout = 330; # 5.5 min
            on-timeout = "hyprctl dispatch dpms off ;; swaymsg output * dpms off"; # Screen off after timeout.
            on-resume = "hyprctl dispatch dpms on ;; swaymsg output * dpms off && brightnessctl -r"; # Restore screen.
          }
          {
            timeout = 1800; # 30 min
            on-timeout = "systemctl suspend"; # Suspend system.
          }
        ];
      };
    };
}
