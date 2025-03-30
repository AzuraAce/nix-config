{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    neovim
    whitesur-cursors
  ];
}
