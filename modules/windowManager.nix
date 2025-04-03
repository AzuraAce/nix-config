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
            sha256 = "sha256-e8wqIxQl6fO1mscjSGbbwEB3BG8yYGBDfSr5QU2LhWM=";
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
