{ config, pkgs, inputs, ... }:
{
  nixpkgs.overlays = [
    (final: prev: {
      dwl = prev.dwl.overrideAttrs ({
        configH = ../home-manager/modules/windowManager/dwl/dwl-config.h;
        patches = [
          ./dwl-patches/vanitygaps-0.7.patch
        ];
      });

    })
  ];
}

