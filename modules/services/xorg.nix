{
  environment.variables = {
    GDK_SCALE = "1";
    GDK_DPI_SCALE = "1";
    CURSOR_THEME = "WhiteSur-cursors";
    CURSOR_SIZE = "32";
  };
  services = {
    libinput = {
      mouse = {
        accelProfile = "flat";
      };
      touchpad = {
        accelProfile = "flat";
        accelSpeed = "1";
        naturalScrolling = true;
      };
    };
    xserver = {
      enable = true;
      dpi = 200;
      upscaleDefaultCursor = true;
      displayManager.startx.enable = true;
    };
  };
}
