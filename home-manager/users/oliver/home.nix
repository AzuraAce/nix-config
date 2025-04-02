{ config, pkgs, inputs, dwl-source, outputs, monitors, ... }: {
  imports = [
    ../../modules
  ];
  home.username = "oliver";
  home.homeDirectory = "/home/oliver";

  nixpkgs = {
    config.allowUnfree = true;
    /* overlays = [
      # Add overlays your own flake exports (from overlays and pkgs dir):
      outputs.overlays.modifications
      outputs.overlays.unstable-packages
    ]; */
  };

  home.packages = with pkgs; [
    vimPlugins.vim-plug
    wmenu
    slurp
    grim
    tree
    nemo
    swaybg
    swayimg
    wallutils
    pstree
    gparted
    calcurse
    evolution
    gimp
    wget
    libreoffice
    pfetch-rs
    owofetch
    discord
    spotify
    valgrind
    code-cursor
    wl-clipboard
    dwl
    xorg.xbacklight
    st
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
    # declared in nix-config/home-manager/modules/services.nix
  };

  programs = {
    # declared in nix-config/home-manager/modules/programs.nix
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
