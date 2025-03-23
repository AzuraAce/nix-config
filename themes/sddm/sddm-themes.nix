{ pkgs }:

let 
  image = pkgs.fetchurl {
  	url = "https://raw.githubusercontent.com/Ollilauch/wallpapers/main/rei-stylized.jpg";
	sha256 = "sha256-aHRoj3GbOcHL4oQqBPJR/H46oQY/vYogqUxkZlqF12o=";
  };
in
  pkgs.stdenv.mkDerivation {
    name = "sddm-theme";
    src = pkgs.fetchFromGitHub {
      owner = "Machillka";
      repo = "Arona-sddm-login";
      rev = "abbe71cfacf86b688cf04e54e2820195fd956631";
      sha256 = "0csdbv2svnzg3azwvy8f2h3x2qhhlaig5qwnhvs3bzlzxlzqcip4";
    };
    installPhase = ''
      mkdir -p $out
      cp -R ./* $out/
      cd $out/
      rm Backgrounds/Arona.jpg
      cp -r ${image} $out/Backgrounds/Arona.jpg
        substituteInPlace theme.conf --replace-fail 'HeaderText="Welcome, Sensei"' 'HeaderText="Welcome"'
    '';
  }

