{ lib, config, ... }:
let
  background-opacity = "0.8";
  background-color = "1a1b26";
  theme = "catppuccin-mocha";
in 
{
  options.terminals = {
    selection = lib.mkOption {
      type = lib.types.listOf ( lib.types.enum [ "foot" "ghostty" "kitty" ] );
      default = [ "foot" ];
      description = "List of terminal emulators to install.";
    };
  };
  
  config = {
    programs.foot = lib.mkIf (lib.elem "foot" config.terminals.selection){
      enable = true;

      settings = {
        main = {
          dpi-aware = "yes";
        };
        colors = {
          alpha = "${background-opacity}";
          background = "${background-color}";
        };
      };
    };

    programs.ghostty = lib.mkIf (lib.elem "ghostty" config.terminals.selection){
      enable = true;
      enableZshIntegration = true;
      settings = {
        window-decoration = false;
        background-opacity = "${background-opacity}";
        background = "#${background-color}";

        theme = "${theme}";

        # Keybindings
        keybind = [
          "ctrl+shift+q=close_surface"
          "ctrl+shift+l=new_split:right"
          "ctrl+shift+j=new_split:down"
          "ctrl+r=reload_config"
        ];
      };
    };

    programs.kitty = lib.mkIf (lib.elem "kitty" config.terminals.selection){
      enable = true;

      shellIntegration.enableZshIntegration = true;
    };
  };
}
