{ pkgs, ... }:
{
  # Enable fonts
  fonts.packages = with pkgs; [
    nerdfonts
    font-awesome
  ];
}
