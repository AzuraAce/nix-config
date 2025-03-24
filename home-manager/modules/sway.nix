{ pkgs, lib, config, ... }:
let
  term = "${pkgs.ghostty}/bin/ghostty";
in 
{
        wayland.windowManager.sway = {
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
                           "${modifier}+e"       = "exec ${pkgs.nemo}/bin/nemo";
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
                           # { command = "${pkgs.udiskie}"; }
                           # { command = "dunst"; }
                           # { command = "${pkgs.calcurse} --daemon"; }
                           # { command = "${pkgs.swaybg} -i /home/oliver/wallpapers/1630505.jpg"; }
                           # { command = "exec swayosd-server"; }
                        ];
                };

                # extraConfig = "bindswitch --reload --locked lid:on exec hyprlock";
        };
}
