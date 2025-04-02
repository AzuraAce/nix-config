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
            sha256 = "sha256-J7WfhURMZxlNxpIF9pblpnXN6yHxzKgjbMGh506SYHA=";
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
