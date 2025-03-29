{ config, lib, pkgs, ... }:
{
    programs = {
      firefox = {
        enable = true;
        
        # List of Policies at: https://mozilla.github.io/policy-templates/
        policies = {
          Extensions = { 
            Install = [
              "https://addons.mozilla.org/firefox/downloads/file/4458450/ublock_origin-1.63.2.xpi"
              "https://addons.mozilla.org/firefox/downloads/file/4424459/reddit_enhancement_suite-5.24.8.xpi"
            ]; 
          };
        };
      };

      brave = {
        enable = true;
      };

      librewolf = {
        enable = true;
        settings = {
          # higher refresh rate than 60 hz
          "privacy.resistFingerprinting" = false;
          "identity.fxaccounts.enabled" = true;
        };
      };
    };
}

