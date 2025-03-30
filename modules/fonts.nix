{ pkgs, ... }:
{
  # Enable fonts
  fonts.packages = with pkgs; [
    nerdfonts
    font-awesome
    font-awesome_5
    jetbrains-mono
  ];
}
