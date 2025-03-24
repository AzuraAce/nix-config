{ pkgs, inputs, ... }:
{
  home.pointerCursor = {
    gtk.enable = true;
    # package = inputs.rose-pine-hyprcursor;
    package = pkgs.phinger-cursors;
    name = "Phinger-cursors-light";
    size = 48;
  }; 
}
