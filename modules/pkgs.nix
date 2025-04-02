{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    neovim
    whitesur-cursors
    unzip
    (st.overrideAttrs (oldAttrs: rec {
      src = fetchFromGitHub {
        owner = "AzuraAce";
        repo = "st";
        rev = "main";
        sha256 = "sha256-IgWYqm139lUFsuvPHxM6b9pbfH6KpASClNHi6kME7/s=";
      };
    }))
  ];
}
