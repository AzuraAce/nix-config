{ lib, config, pkgs, ... }:
let
  background-opacity = "0.8";
  background-color = "1a1b26";
  theme = "catppuccin-mocha";

  catppuccinDrv = pkgs.fetchurl {
    url = "https://codeberg.org/dnkl/foot/raw/branch/master/themes/catppuccin-mocha";
    hash = "sha256-ueExhx/4fjw/SapR69xIIzsSm1D31P1LTLcQz/si0Wo=";
  };
  nordDrv = pkgs.fetchurl {
    url = "https://codeberg.org/dnkl/foot/raw/branch/master/themes/nord";
    hash = "sha256-Dm02rSMML5tkEyzGMLavSH9oP02An+DOVaNUD0zQtG4=";
  };
in 
{
  
  programs = {
    foot = {
      enable = true;

      settings = {
        main = {
          font = "monospace:size=10";
          box-drawings-uses-font-glyphs = "no";
          dpi-aware = "yes";
          include = "${nordDrv}";
        };
        url = {
          launch = "xdg-open \${url}";
          protocols = "http, https, ftp, ftps, file";
        };
        colors = {
          alpha = "${background-opacity}";
          background = "${background-color}";
        };
      };
    };

    ghostty = {
      enable = true;
      enableZshIntegration = true;
      settings = {
        window-decoration = false;
        background-opacity = "${background-opacity}";
        background = "#${background-color}";

        theme = "${theme}";

        # Keybindings
        keybind = [
          "ctrl+shift+q=close_surface"
          "ctrl+shift+l=new_split:right"
          "ctrl+shift+j=new_split:down"
          "ctrl+r=reload_config"
        ];
      };
    };

    kitty = {
      enable = true;

      shellIntegration.enableZshIntegration = true;
    };
  };
}
