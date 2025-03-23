{
  programs.ghostty = {
    enable = true;
    enableZshIntegration = true;
    settings = {
      window-decoration = false;
      background-opacity = 0.8;
      background = "#1a1b26";

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
}
