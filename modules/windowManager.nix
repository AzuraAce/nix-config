{pkgs, config, ...}:
{
  # X11
  services.xserver = {
    windowManager = {
      dwm = {
        enable = true;
        package = pkgs.dwm.overrideAttrs {
          src = pkgs.fetchFromGitHub {
            owner = "AzuraAce";
            repo = "dwm";
            rev = "main";
            sha256 = "sha256-cszzTybF5Opg/7KgqD2M9nGInx7DK01lX+TOfXu/B5I=";
          };
        };
      };
    };
  };
  # Wayland
  programs.sway = {
          enable = true;
          xwayland.enable = true;
  };
  programs.hyprland = {
    enable = true;
    withUWSM = false;
    xwayland.enable = true;
  };
}
