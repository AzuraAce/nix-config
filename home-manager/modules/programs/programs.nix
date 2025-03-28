{ pkgs, config, ... }:
let
  foreground = "rgb(cdd6f4)";
in 
{
  programs.spotify-player = {
    enable = true;
    
    settings = {
      cover_img_scale = 3;
    };
  };
  # Convert LaTeX to Markdown and vice versa
  programs.pandoc = {
    enable = true;
  };
  programs.zathura = {
    highlight-active-color = "#ffffff";
    highlight-transparency = 1;
    default-bg = "rgba(0,0,0,0.7)";
    recolor-lightcolor = "rgba(0,0,0,0)";
    guioptions = "none";
  };
  programs.nnn = {
    enable = true;
  };
  programs.wlogout = {
    enable = true;
  };
  programs.hyprlock = {
    enable = true;
    settings = {
      background = [
        {
          path = "${config.home.homeDirectory}/wallpapers/rei-stylized.jpg";
          blur_passes = 2;
          contrast = 1.0;
          brightness = 0.5;
          vibrancy = 0.2;
          vibrancy_darkness = 0.2;
        }
      ];

      general = {
        no_fade_in = true;
        no_fade_out = true;
        hide_cursor = false;
        grace = 0;
        disable_loading_bar = true;
      };

      input-field = {
        monitor = "";
        size = "250, 60";
        outline_thickness = 2;
        dots_size = 0.2;
        dots_spacing = 0.35;
        dots_center = true;
        outer_color = "rgba(0, 0, 0, 0)";
        inner_color = "rgba(0, 0, 0, 0.2)";
        font_color = "${foreground}";
        fade_on_empty = false;
        rounding = -1;
        check_color = "rgb(204, 136, 34)";
        placeholder_text = "<i><span foreground=\"##cdd6f4\">Input Password...</span></i>";
        hide_input = false;
        position = "0, -200";
        halign = "center";
        valign = "center";
      };

      label = [
        # DATE
        {
          text = "cmd[update:1000] echo \"$(date +\"%A, %B %d\")\"";
          color = "rgba(242, 243, 244, 0.75)";
          font_size = 22;
          font_family = "JetBrains Mono";
          position = "0, 300";
          halign = "center";
          valign = "center";
        }
        # TIME
        {
          text = "cmd[update:1000] echo \"$(date +%-I:%M)\"";
          color = "rgba(242, 243, 244, 0.75)";
          font_size = 95;
          font_family = "JetBrains Mono Extrabold";
          position = "0, 200";
          halign = "center";
          valign = "center";
        }
        {
          monitor = "";
          text = "cmd[update:1000] echo \"$USER\"";
          color = "${foreground}";
          font_size = 14;
          font_family = "JetBrains Mono";
          position = "0, -10";
          halign = "center";
          valign = "top";
        }
      ];
    };
  };
}
