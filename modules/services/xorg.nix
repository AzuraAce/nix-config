{
  environment.variables = {
    GDK_SCALE = "2";
  };
  hardware.video.hidpi.enable = true;
  services = {
    libinput = {
      mouse = {
        accelProfile = "flat";
      };
    };
    xserver = {
      enable = true;
    };
  };
}
