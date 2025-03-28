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
}
