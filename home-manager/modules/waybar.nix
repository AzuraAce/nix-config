{pkgs, ...}: let
  floating_term = "${pkgs.foot}/bin/foot -a foot.float -o colors.alpha=0.95";
  # floating_term = "${pkgs.ghostty}/bin/ghostty --class=ghostty.float --background-opacity=0.95";
in {
  programs.waybar = {
    enable = true;
    settings = [
      {
        position = "top"; # Waybar position (top|bottom|left|right)
        height = 5; # Waybar height (remove for auto height)
        margin = "5";

        # Choose the order of the modules
        modules-left = ["custom/logo" "hyprland/workspaces" "hyprland/window" "sway/workspaces" "sway/window" "custom/media"];
        modules-center = ["clock"];
        modules-right = ["pulseaudio" "network" "backlight" "cpu" "memory" "battery" "tray"];

        # Modules configuration
        "hyprland/workspaces" = {
          disable-scroll = true;
          all-outputs = true;
          format = "{name}";
        };

        "hyprland/window" = {
          format = "{title}";
          icon = true;
          icon-size = 24;
        };

        "sway/workspaces" = {
          disable-scroll = true;
          all-outputs = true;
          format = "{name}";
        };
        
        "sway/window" = {
          format = "{title}";
          icon = true;
          icon-size = 24;
        };

        "mpd" = {
          format = "{stateIcon} {consumeIcon}{randomIcon}{repeatIcon}{singleIcon}{artist} - {album} - {title} ({elapsedTime:%M:%S}/{totalTime:%M:%S}) ⸨{songPosition}|{queueLength}⸩ ";
          format-disconnected = "Disconnected ";
          format-stopped = "{consumeIcon}{randomIcon}{repeatIcon}{singleIcon}Stopped ";
          unknown-tag = "N/A";
          interval = 2;
          consume-icons.on = " ";
          random-icons = {
            off = "<span color=\"#f53c3c\"></span> ";
            on = " ";
          };
          repeat-icons.on = " ";
          single-icons.on = "1 ";
          state-icons = {
            paused = "";
            playing = "";
          };
          tooltip-format = "MPD (connected)";
          tooltip-format-disconnected = "MPD (disconnected)";
        };

        "idle_inhibitor" = {
          format = "{icon}";
          format-icons = {
            activated = "";
            deactivated = "";
          };
        };

        "tray" = {
          icon-size = 21;
          spacing = 10;
        };

        "clock" = {
          format = "{:%R  %A %b %d }";
          tooltip-format = "<tt><small>{calendar}</small></tt>";
          calendar = {
            mode = "year";
            mode-mon-col = 3;
            weeks-pos = "right";
            on-scroll = 1;
            format = {
              months = "<span color='#ffead3'><b>{}</b></span>";
              days = "<span color='#ecc6d9'><b>{}</b></span>";
              weeks = "<span color='#99ffdd'><b>W{}</b></span>";
              weekdays = "<span color='#ffcc66'><b>{}</b></span>";
              today = "<span color='#ff6699'><b><u>{}</u></b></span>";
            };
          };
          on-click = "${floating_term} --title=calcurse -e ${pkgs.calcurse}/bin/calcurse";
          on-click-right = "mode";
          on-scroll-up = ["tz_up" "shift_up"];
          on-scroll-down = ["tz_down" "shift_down"];
        };

        "cpu" = {
          interval = 10;
          format = "{}% ";
          max-length = 10;
          on-click = "${floating_term} --title=htop -e \"htop -s PERCENT_CPU\"";
        };

        "memory" = {
          interval = 30;
          format = "{}% ";
          max-length = 10;
          on-click = "${floating_term} --title=htop -e \"htop -s PERCENT_MEM\"";
        };

        "temperature" = {
          critical-threshold = 80;
          format = "{temperatureC}°C {icon}";
          format-icons = ["" "" ""];
        };

        "backlight" = {
          format = "{percent}% {icon}";
          format-icons = ["" ""];
        };

        "battery" = {
          interval = 60;
          states = {
            good = 95;
            warning = 30;
            critical = 15;
          };
          format = "{capacity}% {icon}";
          format-charging = "󰂄 {capacity}%";
          format-plugged = "{capacity}%";
          format-alt = "{icon} {time} ";
          format-icons = ["  " "  " "  " "  " "  "];
        };

        "network" = {
          format-wifi = "{essid} ({signalStrength}%) ";
          format-ethernet = "{ifname}: {ipaddr}/{cidr} ";
          format-linked = "{ifname} (No IP) ";
          format-disconnected = "Disconnected ";
          tooltip-format = "{ifname}: {ipaddr}/{cidr}";
          on-click = "${floating_term} --title=nmtui -e nmtui";
        };

        "pulseaudio" = {
          format = "{volume}% {icon}";
          format-bluetooth = "{volume}% {icon}";
          format-muted = "";
          format-icons = {
            "alsa_output.pci-0000_00_1f.3.analog-stereo" = "";
            "alsa_output.pci-0000_00_1f.3.analog-stereo-muted" = "";
            "headphone" = "";
            "hands-free" = "";
            "headset" = "";
            "phone" = "";
            "phone-muted" = "";
            "portable" = "";
            "car" = "";
            "default" = ["" ""];
          };
          scroll-step = 1;
          on-click = "${pkgs.pavucontrol}/bin/pavucontrol";
          ignored-sinks = ["Easy Effects Sink"];
        };

        "custom/media" = {
          format = " {}";
          return-type = "json";
          max-length = 40;
          escape = true;
          exec = "$HOME/.config/waybar/mediaplayer.py 2> /dev/null";
        };

        "custom/logo" = {
          format = "{}";
          tooltip = false;
          exec = "echo \"  \";";
          on-click = "${pkgs.wlogout}/bin/wlogout";
        };
      }
    ];
    style = ''
      * {
        border: none;
        border-radius: 4px;
        /* `ttf-font-awesome` is required to be installed for icons */
        font-family: "Roboto Mono Medium", Helvetica, Arial, sans-serif;

        /* adjust font-size value to your liking: */
        font-size: 13px;

        min-height: 0;
      }

       window#waybar {
        background-color: rgba(18, 18, 18, 0.75);
        color: #f5f5f5;
        border-bottom: 1px solid #181825;
        border-radius: 10px;
      }

      window#waybar.empty {
        background-color: rgba(18, 18, 18, 0.75);
      }

      #workspaces button {
        background-color: transparent;
        color: #f5f5f5;
        /* Use box-shadow instead of border so the text isn't offset */
        box-shadow: inset 0 -3px transparent;
        padding: 0px 5px;
        margin: 0px 5px;
      }

      /* https://github.com/Alexays/Waybar/wiki/FAQ#the-workspace-buttons-have-a-strange-hover-effect */
      #workspaces button:hover {
        background: rgba(18, 18, 18, 0.9);
        box-shadow: inset 0 -3px #f5f5f5;
      }

      /* Hyprland active workspace */
      #workspaces button.active {
        background-color: #64727d;
        /* box-shadow: inset 0 -3px #f5f5f5; */
      }

      /* Sway ative workspace */
      #workspaces button.focused {
        background-color: #64727d;
        /* box-shadow: inset 0 -3px #f5f5f5; */
      }

      #workspaces button.urgent {
        background-color: #eb4d4b;
      }

      #mode {
        background-color: #64727d;
        /* border-bottom: 3px solid #f5f5f5; */
      }

      #clock,
      #battery,
      #cpu,
      #memory,
      #temperature,
      #backlight,
      #network,
      #pulseaudio,
      #custom-media,
      #tray,
      #mode,
      #idle_inhibitor,
      #mpd {
        padding: 0 10px;
        margin: 6px 3px;
        color: #000000;
      }

      #window,
      #workspaces {
        margin: 0 4px;
      }

      /* If workspaces is the leftmost module, omit left margin */
      .modules-left > widget:first-child > #workspaces {
        margin-left: 0;
      }

      /* If workspaces is the rightmost module, omit right margin */
      .modules-right > widget:last-child > #workspaces {
        margin-right: 0;
      }

      #clock {
        background-color: transparent;
        color: #f5f5f5;
      }

      #battery {
        background-color: transparent;
        color: #f5f5f5;
      }

      #battery.charging {
        color: #f5f5f5;
        background-color: transparent;
      }

      @keyframes blink {
        to {
          background-color: transparent;
          color: #f53c3c;
        }
      }

      #battery.warning:not(.charging) {
        background-color: transparent;
        color: #F5993C; /* #f5f5f5 */
      }

      #battery.critical:not(.charging) {
        background-color: transparent;
        color: #f5f5f5;
        animation-name: blink;
        animation-duration: 0.5s;
        animation-timing-function: linear;
        animation-iteration-count: infinite;
        animation-direction: alternate;
      }

      label:focus {
        background-color: #000000;
      }

      #cpu {
        background-color: transparent;
        color: #f5f5f5;
      }

      #memory {
        background-color: transparent;
        color: #f5f5f5;
      }

      #backlight {
        background-color: transparent;
        color: #f5f5f5;
      }

      #network {
        background-color: transparent;
        color: #f5f5f5;
      }

      #network.disconnected {
        background-color: #f53c3c;
      }

      #pulseaudio {
        background-color: transparent;
        color: #f5f5f5;
      }

      #pulseaudio.muted {
        background-color: transparent;
        color: #f5f5f5;
      }

      #custom-media {
        background-color: #66cc99;
        color: #2a5c45;
        min-width: 100px;
      }

      #custom-media.custom-spotify {
        background-color: #66cc99;
      }

      #custom-media.custom-vlc {
        background-color: #ffa000;
      }

      #temperature {
        background-color: #f0932b;
      }

      #temperature.critical {
        background-color: #eb4d4b;
      }

      #tray {
        background-color: #2980b9;
        margin-right: 10px;
      }

      #idle_inhibitor {
        background-color: #2d3436;
      }

      #idle_inhibitor.activated {
        background-color: #ecf0f1;
        color: #2d3436;
      }

      #mpd {
        background-color: #66cc99;
        color: #2a5c45;
      }

      #mpd.disconnected {
        background-color: #f53c3c;
      }

      #mpd.stopped {
        background-color: #90b1b1;
      }

      #mpd.paused {
        background-color: #51a37a;
      }

      #custom-logo {
        background-color: transparent;
        color: #7ebae4;
        min-width: 20px;
        padding: 0px 0px 0px 0px;
        font-size: 20px;
      }

      #language {
        background: #bbccdd;
        color: #333333;
        padding: 0 5px;
        margin: 6px 3px;
        min-width: 16px;
      }
    '';
  };
}
