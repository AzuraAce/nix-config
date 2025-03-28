{
  pkgs,
  config,
  ...
}: {
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    syntaxHighlighting.enable = true;
    autosuggestion.enable = true;

    # Set history file
    history = {
      path = "${config.home.homeDirectory}/.histfile";
      size = 1000;
      save = 1000;
    };

    # Set default editor
    shellAliases = {
      ll = "ls -la --color=auto";
      ls = "ls --color=auto";
      grep = "grep --color=auto";
      shutdown = "sudo shutdown -h now";
      st = "st & disown";
      logout_oliver = "sudo pkill -KILL -u oliver";
      dotfiles = "git --git-dir=/home/oliver/.dotfiles --work-tree=/";
      icat = "kitten icat";
      nvim = "nix run ~/.config/nvim/";
      ff = "fastfetch";
      zathura = "zathura --fork";
    };

    # Environment Variables
    initExtra = ''
      autoload -U colors && colors
      PROMPT="%{$fg[cyan]%}%n@%M%{$reset_color%} %~ %# "

      # Completion system setup
      autoload -Uz compinit
      compinit
      zstyle ':completion:*' completer _complete _ignored
      zstyle :compinstall filename '${config.home.homeDirectory}/.zshrc'

      # Keybindings
      bindkey -v

      # Paths
      export PATH="$PATH:$HOME/scripts:/usr/avr/include:/home/oliver/.cargo/bin"

      # GPG passphrase
      export GPG_TTY=$(tty)
    '';
  };
}
