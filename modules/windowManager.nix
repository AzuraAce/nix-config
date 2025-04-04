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
            sha256 = "sha256-h3EozcnmLf/w+Keevizp3NMbR8X5zqUOcD2EIw6SE4o=";
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
