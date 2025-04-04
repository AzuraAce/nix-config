{ pkgs, inputs, ... }:
{
  home.pointerCursor = {
    gtk.enable = true; 
    name = "WhiteSur-cursors";
    package = pkgs.whitesur-cursors;
    size = 32;
    x11.enable = true;
  };

  gtk = {
    enable = true;
    cursorTheme = {
      name = "WhiteSur-cursors";
      package = pkgs.whitesur-cursors;
      size = 32;
    };
  };
}
