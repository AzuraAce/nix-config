{ pkgs, outputs, ... }:
{
  nixpkgs.overlays = [
    outputs.overlays.additions
  ];

  environment.systemPackages = with pkgs; [
    neovim
    whitesur-cursors
    unzip
    acpi
    nix-prefetch-git
    jq
    wirelesstools
    pavucontrol
    # Suckless Terminal
    xclip
    (st.overrideAttrs (oldAttrs: rec {
      src = fetchFromGitHub {
        owner = "AzuraAce";
        repo = "st";
        rev = "main";
        sha256 = "sha256-oGs5Nl7Jev7J5S+YXwHX12ZaKrlwRHEqgn35eyMIBGA=";
      };
    }))
    dmenu
    dwmblocks-async
  ];
}
