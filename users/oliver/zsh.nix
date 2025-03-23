config:
{
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
        mouse = "xinput set-prop 'USB Gaming Mouse' 'Coordinate Transformation Matrix' 4 0 0 0 4 0 0 0 0.5";
        logout_oliver = "sudo pkill -KILL -u oliver";
        dotfiles = "git --git-dir=/home/oliver/.dotfiles --work-tree=/";
        icat = "kitten icat";
        nvim = "nix run ~/.config/nvim --";
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

        # Default terminal
        export TERMINAL=ghostty
        export EDITOR=nvim

        # Paths
        export PATH="$PATH:$HOME/scripts:/usr/avr/include:/home/oliver/.cargo/bin"
        export JAVA_HOME="/usr/lib64/openjdk-21/"
        export PATH="$PATH:$JAVA_HOME/bin"
        export GOBIN="/usr/local/bin"

        # GPG passphrase
        export GPG_TTY=$(tty)

        # Bun completions
        [ -s "/home/oliver/.bun/_bun" ] && source "/home/oliver/.bun/_bun"

        # Bun setup
        export BUN_INSTALL="$HOME/.bun"
        export PATH="$BUN_INSTALL/bin:$PATH"
      '';
}
