{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    neovim
    whitesur-cursors
    unzip
    # Suckless Terminal
    (st.overrideAttrs (oldAttrs: rec {
      src = fetchFromGitHub {
        owner = "AzuraAce";
        repo = "st";
        rev = "main";
        sha256 = "sha256-ogNPUdWXoyycm3HhgQ2n5ZnTXhR+ZumPrTofNFp8xIk=";
      };
    }))
  ];
}
