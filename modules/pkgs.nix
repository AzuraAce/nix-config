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
        hash = "sha256-qqnfUA7hmfdZh+S7e70JC8DCpVvUDR2vBm0OsdeFZQc=";
      };
    }))
  ];
}
