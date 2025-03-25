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

  nixpkgs.config.allowUnfree = true;

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
    discord
    spotify
    valgrind
    hyprlock
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
