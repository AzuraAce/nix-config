{ pkgs, ... }:
# Enable SDDM
{
  # Enable QT
  qt.enable = true;

  services.displayManager = {
    defaultSession = "hyprland";
      sddm = {
        enable = true;
        wayland.enable = true;
        theme = "${import ../themes/sddm/sddm-themes.nix { inherit pkgs; }}";
        settings = {
            Theme = {
              CursorTheme = "Adwaita";
                };
        };
    };
  };
}
