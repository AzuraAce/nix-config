{
  environment.variables = {
    GDK_SCALE = "1";
    GDK_DPI_SCALE = "0.5";
  };
  services = {
    libinput = {
      mouse = {
        accelProfile = "flat";
      };
      touchpad = {
        accelProfile = "flat";
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
