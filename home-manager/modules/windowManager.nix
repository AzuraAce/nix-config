{ pkgs, lib, config, ... }:
let
  term = "${pkgs.foot}/bin/foot";
  launcher = "${pkgs.wofi}/bin/wofi";
  file_manager = "${pkgs.nemo}/bin/nemo";
in 
{
  options.WMs = {
    enable = lib.mkEnableOption "Enable WM selection module";

    selection = lib.mkOption {
      type = lib.types.listOf (lib.types.enum [ "sway" "hyprland" ]);
      default = [ "sway" ];
      description = "List of WMs to install.";
    };
  };
  
  config = {
  wayland.windowManager.sway = lib.mkIf (lib.elem "sway" config.WMs.selection) {
    enable = true;
    xwayland = true;
    wrapperFeatures.gtk = true; # Fixes common issues with GTK 3 apps

    config = {
      output = {
        "eDP-1" = {
          mode = "2880x1800@90Hz";
          scale = "2.0";
          pos = "0 0";
        };
      };
      
      gaps = {
        inner = 5;
        outer = 20;
      };
      
      fonts = {
        names = ["monospace"];
        size = 10.0;
      };

      window = {
        border = 2;
        titlebar = false;
      };

      focus = {
        followMouse = "yes";
      };
      
      colors = {
        focused =  lib.mkOptionDefault {
          childBorder =  lib.mkForce "#7FBBE5";
          indicator =  lib.mkForce "#7FBBE5";
        };
      };

      input = {
        "type:touchpad" = {
          tap = "enabled";
          natural_scroll = "enabled";
        };
        "type:keyboard" = {
          xkb_layout = "de";
        };
      };

      bars = [
        {
          command = "${pkgs.waybar}/bin/waybar";
        }
      ];

      floating = {
        criteria = [
        {
          app_id = "ghostty.float";
        }
        {
          app_id = "org.pulseaudio.pavucontrol";
        }
        {
          app_id = "discord";
        }
        {
          app_id = "spotify";
        }
        {
          app_id = "nemo";
        }
        ];
      };

      defaultWorkspace = "workspace number 1";

      # set Mod to Windows key 
      modifier = "Mod4";

      keybindings = let
         modifier = config.wayland.windowManager.sway.config.modifier;
      in lib.mkOptionDefault {
         "${modifier}+Shift+Return"  = "exec ${term}";
         "${modifier}+Shift+q" = "kill";
         "${modifier}+d"       = "exec ${pkgs.wofi}/bin/wofi";
         "${modifier}+Shift+e"       = "exec ${pkgs.nemo}/bin/nemo";
         "XF86MonBrightnessDown" = "exec swayosd-client --brightness lower";
         "XF86MonBrightnessUp" = "exec swayosd-client --brightness raise";
         "xf86AudioMute" = "exec swayosd-client --output-volume mute-toggle";
         "xf86AudioLowerVolume" = "exec swayosd-client --output-volume lower";
         "xf86AudioRaiseVolume" = "exec swayosd-client --output-volume raise";
         "xf86AudioMicMute" = "exec swayosd-client --input-volume mute-toggle";
      };
      
      startup = [
         { command = "${term} --gtk-single-instance=true --quit-after-last-window-closed=false --initial-window=false"; }
         { command = "zsh /home/oliver/scripts/sway/start.sh"; }
      ];
    };

    extraConfig = "bindswitch --reload --locked lid:on exec hyprlock";
  };

  wayland.windowManager.hyprland = lib.mkIf (lib.elem "hyprland" config.WMs.selection){
    enable = true;
    xwayland.enable = true;

    settings = {
      monitor = ["eDP-1,2880x1800@90hz,0x0,2"];

      # Environment Variables
      env = [
        "XCURSOR_SIZE,15"
        "XCURSOR_THEME,rose-pine-hyprcursor"
        "HYPRCURSOR_THEME,rose-pine-hyprcursor"
        "HYPRCURSOR_SIZE,24"
      ];

      # General Look and Feel
      general = {
        gaps_in = 5;
        gaps_out = 20;
        border_size = 2;
        "col.active_border" = "rgba(33ccffee) rgba(00ff99ee) 45deg";
        "col.inactive_border" = "rgba(595959aa)";
        resize_on_border = false;
        allow_tearing = false;
        layout = "dwindle";
      };

      decoration = {
        rounding = 5;
        active_opacity = 1.0;
        inactive_opacity = 1.0;
        blur = {
          enabled = false;
          size = 3;
          passes = 1;
          vibrancy = 0.1696;
        };
      };

      animations = {
        enabled = false;
        bezier = "myBezier, 0.05, 0.9, 0.1, 1.05";
        animation = [
          "windows, 1, 5, myBezier"
          "windowsOut, 1, 3, default, popin 80%"
          "border, 1, 5, default"
          "borderangle, 1, 5, default"
          "fade, 1, 5, default"
          "workspaces, 1, 5, default"
        ];
      };

      dwindle = {
        pseudotile = true;
        preserve_split = true;
      };

      misc = {
        force_default_wallpaper = -1;
        disable_hyprland_logo = true;
      };

      input = {
        kb_layout = "de";
        follow_mouse = 1;
        sensitivity = 0;
        touchpad.natural_scroll = true;
      };

      gestures = {
        workspace_swipe = false;
      };

      device = {
        name = "epic-mouse-v1";
        sensitivity = -0.5;
      };

      # Keybindings
      "$mainMod" = "SUPER";
      bind = [
        "$mainMod SHIFT, return, exec, ${term} --gtk-single-instance=true"
        "$mainMod SHIFT, Q, killactive"
        "$mainMod, M, exit"
        "$mainMod, E, exec, ${file_manager}"
        "$mainMod, V, togglefloating"
        "$mainMod, F, Fullscreen"
        "$mainMod, D, exec, wmenu-run"
        "$mainMod, SPACE, exec, ${launcher}"
        "$mainMod, P, pseudo"
        "$mainMod, O, togglesplit"

        # Switch workspaces with mainMod + [0-9]
        "$mainMod, 1, workspace, 1"
        "$mainMod, 2, workspace, 2"
        "$mainMod, 3, workspace, 3"
        "$mainMod, 4, workspace, 4"
        "$mainMod, 5, workspace, 5"
        "$mainMod, 6, workspace, 6"
        "$mainMod, 7, workspace, 7"
        "$mainMod, 8, workspace, 8"
        "$mainMod, 9, workspace, 9"
        "$mainMod, 0, workspace, 10"

        "$mainMod SHIFT, 1, movetoworkspace, 1"
        "$mainMod SHIFT, 2, movetoworkspace, 2"
        "$mainMod SHIFT, 3, movetoworkspace, 3"
        "$mainMod SHIFT, 4, movetoworkspace, 4"
        "$mainMod SHIFT, 5, movetoworkspace, 5"
        "$mainMod SHIFT, 6, movetoworkspace, 6"
        "$mainMod SHIFT, 7, movetoworkspace, 7"
        "$mainMod SHIFT, 8, movetoworkspace, 8"
        "$mainMod SHIFT, 9, movetoworkspace, 9"
        "$mainMod SHIFT, 0, movetoworkspace, 10"

        # Move focus with mainMod + h,j,k,l keys
        "$mainMod, H, movefocus, l"
        "$mainMod, L, movefocus, r"
        "$mainMod, K, movefocus, u"
        "$mainMod, J, movefocus, d"

        # Move focus with mainMod + arrow keys
        "$mainMod, left, movefocus, l"
        "$mainMod, right, movefocus, r"
        "$mainMod, up, movefocus, u"
        "$mainMod, down, movefocus, d"

        # Move window with mainMod + SHIFT + arrow keys
        "$mainMod SHIFT, left, movewindow, l"
        "$mainMod SHIFT, right, movewindow, r"
        "$mainMod SHIFT, up, movewindow, u"
        "$mainMod SHIFT, down, movewindow, d"

        # Move window with mainMod + SHIFT + h,j,k,l
        "$mainMod SHIFT, H, movewindow, l"
        "$mainMod SHIFT, L, movewindow, r"
        "$mainMod SHIFT, K, movewindow, u"
        "$mainMod SHIFT, J, movewindow, d"

        # Take a screenshot and save it to the clipboard
        "$mainMod, PRINT, exec, grim -g \"$(slurp -d)\" - | wl-copy"

        # Toggle WayBar Bar
        "$mainMod, B, exec, pkill waybar && waybar"
      ];

      bindle = [
        ", XF86MonBrightnessDown, exec, swayosd-client --brightness lower"
        ", XF86MonBrightnessUp, exec, swayosd-client --brightness raise"
        ", xf86AudioMute, exec, swayosd-client --output-volume mute-toggle"
        ", xf86AudioLowerVolume, exec, swayosd-client --output-volume lower"
        ", xf86AudioRaiseVolume, exec, swayosd-client --output-volume raise"
        ", xf86AudioMicMute, exec, swayosd-client --input-volume mute-toggle"
      ];

      binde = [
        # Resize window with mainMod + ALT + arrow keys
        "$mainMod ALT, left, resizeactive, -10 0"
        "$mainMod ALT, right, resizeactive, 10 0"
        "$mainMod ALT, up, resizeactive, 0 -10"
        "$mainMod ALT, down, resizeactive, 0 10"

        # Resize window with mainMod + ALT + h,j,k,l
        "$mainMod ALT, H, resizeactive, -10 0"
        "$mainMod ALT, L, resizeactive, 10 0"
        "$mainMod ALT, K, resizeactive, 0 -10"
        "$mainMod ALT, J, resizeactive, 0 10"
      ];

      bindm = [
        # Move/resize windows with mainMod + LMB/RMB and dragging
        "$mainMod, mouse:272, movewindow"
        "$mainMod, mouse:273, resizewindow"
      ];

      # Autostart Applications
      exec-once = [
        "${term} --gtk-single-instance=true --quit-after-last-window-closed=false --initial-window=false"
        "zsh /home/oliver/scripts/hypr/start.sh"
      ];

      # Window Rules
      windowrulev2 = [
        "suppressevent maximize, class:.*"
        "float, class:ghostty.float"
        "float, class:org.pulseaudio.pavucontrol"
      ];
    };
  };

  };
}
