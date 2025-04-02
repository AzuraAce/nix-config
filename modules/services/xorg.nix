{
  environment.variables = {
    GDK_SCALE = "2";
  };
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
