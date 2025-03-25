{ pkgs, inputs, ... }:
{
  home.pointerCursor = {
    gtk.enable = true;
    name = "WhiteSur-cursors";
    package = pkgs.whitesur-cursors;
    size = 24;
    x11 = {
      enable = true;
      # defaultCursor = "WhiteSur-cursors";
    };
  };

  gtk.gtk4.extraConfig = {
    gtk-cursor-theme-name = "WhiteSur-cursors";
    gtk-cursor-theme-package = pkgs.whitesur-cursors;
    gtk-cursor-theme-size = 24;
  };
}
