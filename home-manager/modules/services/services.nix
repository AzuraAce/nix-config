{
  services = {
    # X11 compositor
    picom = {
      enable = true;
    };
  
    gnome-keyring = {enable = true;};
    
    swayosd = {
      enable = true;
    };
    
    # Service to automount external Media devices
    udiskie = {
      enable = true;
      automount = true;
      notify = true;
      tray = "auto";
      settings = {
        program_options = {
          udisks_version = 2;
          tray = "auto";
        };
        icon_names.media = [ "media-optical" ];
      };
    };
    
    dunst = {
      enable = true;
    };

    swaync = {
      enable = false;

      settings = {
        positionX = "right";
        positionY = "top";
        layer = "overlay";
        control-center-layer = "top";
        layer-shell = true;
        cssPriority = "application";
        control-center-margin-top = 0;
        control-center-margin-bottom = 0;
        control-center-margin-right = 0;
        control-center-margin-left = 0;
        notification-2fa-action = true;
        notification-inline-replies = false;
        notification-icon-size = 64;
        notification-body-image-height = 100;
        notification-body-image-width = 200;

        buttons-grid = { 
          actions = [
            {
              label = "WiFi";
              type = "toggle";
              active = true;
              command = "sh -c '[[ $SWAYNC_TOGGLE_STATE == true ]] && nmcli radio wifi on || nmcli radio wifi off'";
              update-command = "sh -c '[[ $(nmcli radio wifi) == \"enabled\" ]] && echo true || echo false'";
            }
          ];
        };
      };

      style = ''
        .notification-row {
          outline: none;
        }
        
        .notification-row:focus,
        .notification-row:hover {
          background: @noti-bg-focus;
        }
        
        .notification {
          border-radius: 12px;
          margin: 6px 12px;
          box-shadow: 0 0 0 1px rgba(0, 0, 0, 0.3), 0 1px 3px 1px rgba(0, 0, 0, 0.7),
            0 2px 6px 2px rgba(0, 0, 0, 0.3);
          padding: 0;
        }
      '';
    };
  };
}
