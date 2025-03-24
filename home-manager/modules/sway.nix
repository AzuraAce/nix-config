{ pkgs, lib, config, ... }:
let
  term = "${pkgs.ghostty}/bin/ghostty";
in 
{
        wayland.windowManager.sway = {
                enable = true;
                xwayland = true;

                config = {
                        output = {
                          "eDP-1" = {
                                mode = "2880x1800@90Hz";
                                scale = 2.0;
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

                        input = {
                          "type:touchpad" = {
                            tap = "enabled";
                            natural_scroll = "enabled";
                          };
                          "type:keyboard" = {
                            xkb_layout = "de";
                          };
                        };

                        # set Mod to Windows key 
                        modifier = "Mod4";

                        keybindings = let
                           modifier = config.wayland.windowManager.sway.config.modifier;
                        in lib.mkOptionDefault {
                           "${modifier}+Return"  = "exec ${term}";
                           "${modifier}+Shift+q" = "kill";
                           "${modifier}+d"       = "exec ${pkgs.wofi}/bin/wofi";
                           "${modifier}+e"       = "exec ${pkgs.nemo}/bin/nemo";
                        };
                        
                        startup = [
                           { command = "${term} --gtk-single-instance=true --quit-after-last-window-closed=false --initial-window=false"; }
                           { command = "zsh /home/oliver/scripts/hypr/start.sh"; }
                        ];
                };
        };
}
