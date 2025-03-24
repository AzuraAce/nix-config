{
  config,
  pkgs,
  inputs,
  ...
}: {
  imports = [
    ../../modules
  ];
  home.username = "oliver";
  home.homeDirectory = "/home/oliver";

  home.pointerCursor = {
    name = "Adwaita";
    package = pkgs.adwaita-icon-theme;
    size = 24;
    x11 = {
      enable = true;
      defaultCursor = "Adwaita";
    };
  };

  home.packages = with pkgs; [
    vimPlugins.vim-plug
    wmenu
    swayosd
    brave
    firefox
    zathura
    slurp
    grim
    tree
    neovim
    kitty
    dunst
    nemo
    swaybg
    swayimg
    wallutils
    pstree
    texliveFull
    gparted
    calcurse
    evolution
    gimp
    wget
    udiskie
    libreoffice
    texliveFull
    pfetch-rs
  ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. These will be explicitly sourced when using a
  # shell provided by Home Manager. If you don't want to manage your shell
  # through Home Manager then you have to manually source 'hm-session-vars.sh'
  # located at either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/oliver/etc/profile.d/hm-session-vars.sh
  #
  home.sessionVariables = {
    EDITOR = "nvim";
  };

  services = {
    gnome-keyring = {enable = true;};
    hypridle = {
      enable = true;
      settings = {
        general = {
          lock_cmd = "pidof hyprlock || hyprlock"; # Avoid starting multiple hyprlock instances.
          before_sleep_cmd = "loginctl lock-session"; # Lock before suspend.
          after_sleep_cmd = "hyprctl dispatch dpms on"; # Avoid pressing a key twice to turn on the display.
        };

        listeners = [
          {
            timeout = 150; # 2.5 min
            on-timeout = "brightnessctl -s set 10"; # Set monitor backlight to minimum.
            on-resume = "brightnessctl -r"; # Restore monitor backlight.
          }
          {
            timeout = 150; # 2.5 min
            on-timeout = "brightnessctl -sd rgb:kbd_backlight set 0"; # Turn off keyboard backlight.
            on-resume = "brightnessctl -rd rgb:kbd_backlight"; # Restore keyboard backlight.
          }
          {
            timeout = 300; # 5 min
            on-timeout = "loginctl lock-session"; # Lock screen after timeout.
          }
          {
            timeout = 330; # 5.5 min
            on-timeout = "hyprctl dispatch dpms off"; # Screen off after timeout.
            on-resume = "hyprctl dispatch dpms on && brightnessctl -r"; # Restore screen.
          }
          {
            timeout = 1800; # 30 min
            on-timeout = "systemctl suspend"; # Suspend system.
          }
        ];
      };
    };
    # syncthing = syncthingConfig;
  };

  programs = {
    # Let Home Manager install and manage itself.
    home-manager = {
      enable = true;
    };
    vim.enable = true;
    emacs = {
      enable = true;
      package = pkgs.emacs-pgtk;
    };
    htop = {
      enable = true;
    };
    wofi = {
      enable = true;
      settings = {
        mode = "drun";
        allow_images = true;
        allow_markup = true;
        gtk_dark = true;
      };
    };
    git = {
      enable = true;
      userName = "Ollilauch";
      userEmail = "oliverjbmub@gmail.com";
    };
    fastfetch = {
      enable = true;
      settings = {
        modules = [
          "title"
          "separator"
          "os"
          "host"
          "kernel"
          "uptime"
          "packages"
          "shell"
          "display"
          "wm"
          "font"
          "terminal"
          "terminalfont"
          "cpu"
          "gpu"
          "memory"
          "disk"
          "battery"
          "poweradapter"
          "break"
          "colors"
        ];
      };
    };
    direnv = {
      enable = true;
      enableBashIntegration = true; # see note on other shells below
      nix-direnv.enable = true;
    };
  };

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "23.11"; # Please read the comment before changing.
}
