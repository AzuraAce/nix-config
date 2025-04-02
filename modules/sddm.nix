{ pkgs, ... }:
# Enable SDDM
{
  # Enable QT
  qt.enable = true;

  services.displayManager = {
    defaultSession = "hyprland";
      sddm = {
        enable = true;
        wayland.enable = false;
        theme = "${import ../themes/sddm/sddm-themes.nix { inherit pkgs; }}";
        settings = {
            Theme = {
              CursorTheme = "Adwaita";
              CursorSize = 24;
            };
        };
    };
  };

  environment.systemPackages = with pkgs; [
    libsForQt5.qt5.qtquickcontrols2
    libsForQt5.qt5.qtgraphicaleffects
    libsForQt5.qt5.qtsvg
  ];
}
