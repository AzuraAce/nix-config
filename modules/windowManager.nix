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
            hash = "sha256-wqeZrFca5LPCHY2skDGaUbBaur8/w2kCtw/VCWrfS4M=";
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
