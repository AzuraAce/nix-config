{ config, pkgs, dwl-source, ... }:
{
  nixpkgs.overlays = [
    (self: super: {
      dwl = super.dwl.overrideAttrs (oldAttrs: rec {
        src = /home/oliver/.config/dwl; # dwl-source;
        patches = [
          /home/oliver/.config/dwl/patches/cursortheme.patch
          /home/oliver/.config/dwl/patches/customfloat.patch
          /home/oliver/.config/dwl/patches/gaps.patch
          /home/oliver/.config/dwl/patches/ipc.patch
          /home/oliver/.config/dwl/patches/alpha.patch
          /home/oliver/.config/dwl/patches/movestack.patch
          /home/oliver/.config/dwl/patches/naturalscrolltrackpad.patch
          /home/oliver/.config/dwl/patches/snail.patch
          /home/oliver/.config/dwl/patches/snail-gaps.patch
        ];
      });
    })
  ];
}

