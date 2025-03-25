let
  background-opacity = "0.8";
  background-color = "1a1b26";
in 
{
  programs.foot = {
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

  programs.ghostty = {
    enable = true;
    enableZshIntegration = true;
    settings = {
      window-decoration = false;
      background-opacity = "${background-opacity}";
      background = "#${background-color}";

      theme = "catppuccin-mocha";

      # Keybindings
      keybind = [
        "ctrl+shift+q=close_surface"
        "ctrl+shift+l=new_split:right"
        "ctrl+shift+j=new_split:down"
        "ctrl+r=reload_config"
      ];
    };
  };

  programs.kitty = {
    enable = true;

    shellIntegration.enableZshIntegration = true;
  };
}
