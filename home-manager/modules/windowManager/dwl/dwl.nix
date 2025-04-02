{ config, pkgs, inputs, ... }:
{
  nixpkgs.overlays = [
    (final: prev: {
        dwl = prev.dwl.override ({
          configH = ./dwl-config.h;
          patches = [
            ./dwl-patches/vanitygaps-0.7.patch
          ];
      });

    })
  ];
}

