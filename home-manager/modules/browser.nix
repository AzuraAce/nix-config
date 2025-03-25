{ config, lib, pkgs, ... }:
let
in
{
  options.browsers = {
    selection = lib.mkOption {
      type = lib.types.listOf (lib.types.enum [ "firefox" "brave" ]);
      default = [ "firefox" ];
      description = "List of browsers to install.";
    };
  };

  config = {

    programs.firefox = lib.mkIf (lib.elem "firefox" config.browsers.selection) {
      enable = true;
      policies = {
        Extensions = { 
          Install = [
            "https://addons.mozilla.org/firefox/downloads/file/4458450/ublock_origin-1.63.2.xpi"
            "https://addons.mozilla.org/firefox/downloads/file/4424459/reddit_enhancement_suite-5.24.8.xpi"
          ]; 
        };
      };
    };

    programs.brave = lib.mkIf (lib.elem "brave" config.browsers.selection) {
      enable = true;
    };
    
  };
}

