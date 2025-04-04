{ stdenv, xorg, libX11, pkg-config, pkgs }:

stdenv.mkDerivation {
  pname = "dwmblocks";
  version = "4.20.24";

  src = pkgs.fetchFromGitHub {
    owner = "AzuraAce";
    repo = "dwmblocks-async";
    rev = "main";
    sha256 = "sha256-00yFYnlYKWZiwY8d+G+sbs33XOF/QcmsLTeBfjDCrZ8=";
  };

  strictDeps = true;

  nativeBuildInputs = [ pkg-config ];

  buildInputs = [ libX11 pkg-config ]
    ++ builtins.attrValues { inherit (xorg) libxcb xcbutil; };

  makeFlags = [ "PREFIX=$(out)" ];

  meta.mainProgram = "dwmblocks";
}
