{ stdenv, xorg, libX11, pkg-config, pkgs }:

stdenv.mkDerivation {
  pname = "dwmblocks";
  version = "4.20.24";

  src = pkgs.fetchFromGitHub {
    owner = "AzuraAce";
    repo = "dwmblocks-async";
    rev = "main";
    sha256 = "sha256-O8Ppi1twTxyvQFCGs5ohaE7ggqkd+DY4gB/PBuyLcA4=";
  };

  strictDeps = true;

  nativeBuildInputs = [ pkg-config ];

  buildInputs = [ libX11 pkg-config ]
    ++ builtins.attrValues { inherit (xorg) libxcb xcbutil; };

  makeFlags = [ "PREFIX=$(out)" ];

  meta.mainProgram = "dwmblocks";
}
