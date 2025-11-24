{ pkgs, config, lib, ... }:

{
  home.packages = with pkgs; [
    starship 
    atuin 
    zoxide 
    eza 
    bat 
    fd 
    ripgrep 
    fzf 
    fastfetch 
    delta 
    trash-cli
    curl 
    wget 
    tldr 
    jq
    procs 
    dust 
    duf 
    gping

    # Plugins for ZSH
    zsh-fzf-tab
  ];

  programs.zsh = {
    enable = true;
    autocd = true;
    dotDir = "${config.home.homeDirectory}/.zshrc";

    history = {
      expireDuplicatesFirst = true;
      ignoreSpace = true;
      path = "${config.xdg.cacheHome}/zsh/history";
      save = 100000;
      size = 100000;
    };

    enableCompletion   = true;  
    syntaxHighlighting = { enable = true; };

    plugins = [
      { name = "fzf-tab"; src = pkgs.zsh-fzf-tab; }
      { name = "autosuggestions";  src = pkgs.zsh-autosuggestions; }
    ];

    initContent = lib.mkMerge [
      # Самое раннее — до compinit (порядок 100)
      (lib.mkOrder 100 ''
        eval "$(starship init zsh)"
        eval "$(atuin init zsh --disable-up-arrow)"
        eval "$(zoxide init zsh)"
      '')

      (lib.mkOrder 550 ''
        # Клавиши
        bindkey "^[[1;5C" forward-word          # Ctrl+Right
        bindkey "^[[1;5D" backward-word         # Ctrl+Left
        bindkey '^ ' autosuggest-accept         # Ctrl+Space = принять подсказку
      '')

      (lib.mkOrder 600 ''
        # Автоподсказки — теперь точно работают
        source ${pkgs.zsh-autosuggestions}/share/zsh-autosuggestions/zsh-autosuggestions.zsh
        ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=#585b70,bold"

        # Fastfetch при старте
        [[ -f ${config.xdg.configHome}/fastfetch/config-compact.jsonc ]] &&
          fastfetch -c ${config.xdg.configHome}/fastfetch/config-compact.jsonc

        # ────────────────────── Алиасы 2025 ──────────────────────
        alias ls='eza --icons --group-directories-first --color=always'
        alias ll='eza -lh --icons --group-directories-first --color=always'
        alias la='eza -lah --icons --group-directories-first --color=always'
        alias lt='eza --tree --level=3 --icons'
        alias cat='bat --style=plain'
        alias grep='rg'
        alias find='fd'
        alias ps='procs'
        alias du='dust'
        alias df='duf'
        alias ping='gping'
        alias rm='trash-put'
        alias cls='clear'
        alias ssh-server='ssh kkleytt@46.160.250.162 -p 1900'

        # Git коротко и удобно
        alias g='git'
        alias ga='git add'
        alias gc='git commit'
        alias gp='git push'
        alias gl='git pull'
        alias gs='git status'
        alias gd='git diff'
        alias gds='git diff --staged'
        alias glog="git log --oneline --decorate --graph"

        # Delta — красивый diff навсегда
        command -v delta &>/dev/null && {
          git config --global core.pager "delta"
          git config --global interactive.diffFilter "delta --color-only"
          git config --global delta.navigate true
          git config --global delta.side-by-side false
        }
      '')
    ];
  };

  # ────────────────────── Starship ──────────────────────
  programs.starship = {
    enable = true;

    settings = {
      add_newline = false;
      scan_timeout = 10;

      format = "$directory$git_branch$git_state$git_status$nodejs$rust$python$golang$bun$deno$fill$cmd_duration$character";

      fill.symbol = " ";

      # Путь с фоном + сокращение до имени проекта + рабочие substitutions
      directory = {
        format = "[ 󰉖 $path ]($style) ";
        style = "bg:#1e1e2e fg:#cba6f7 bold";
        truncation_length = 8;
        truncate_to_repo = true;

        # ← Вот так правильно делают substitutions в 2025
        substitutions = {
          "${config.home.homeDirectory}/Projects" = " 󰉋 Proj";
          "${config.home.homeDirectory}/Documents" = " 󰈙 Docs";
          "${config.home.homeDirectory}/Downloads" = "  DL";
          "${config.home.homeDirectory}" = "  Home";
        };
      };

      # Только одна самая важная иконка (никакого мусора)
      git_status = {
        format = "[ $conflicted$staged$deleted$renamed$modified$untracked$stashed$ahead_behind ]($style)";
        style = "bg:#313244 fg:#f38ba8 bold";
        conflicted = "✘"; ahead = "⇡"; behind = "⇣"; diverged = "⇕";
        untracked = "?"; stashed = "$"; modified = "!"; staged = "+"; renamed = "»"; deleted = "✘";
        # Если всё чисто — вообще ничего не показывается
        up_to_date = "";
      };

      git_branch = {
        format = "[  $branch ]($style) ";
        style = "bg:#313244 fg:#a6e3a1 bold";
      };

      # Языки — без "via", с цветными фонами
      nodejs.format = "[ 󰛦 $version ](bg:#313244 fg:#a6e3a1 bold) ";
      rust.format   = "[ 󱗼 $version ](bg:#313244 fg:#f38ba8 bold) ";
      python.format = "[ 󰌠 $version ](bg:#313244 fg:#cba6f7 bold) ";
      golang.format = "[ 󰟓 $version ](bg:#313244 fg:#89dceb bold) ";

      cmd_duration = {
        format = "[  $duration ](bg:#313244 fg:#cdd6f4)";
        min_time = 2000;
      };

      character = {
        success_symbol = "[ ➜ ](bold green)";
        error_symbol   = "[ ➜ ](bold red)";
      };
    };
  };

  # ────────────────────── Atuin ──────────────────────
  programs.atuin = {
    enable = true;
    settings = {
      update_check = false;
      style = "compact";
      inline_height = 20;
      enter_accept = "enter";
      search_mode = "prefix";
      filter_mode = "global";
    };
  };

  # ────────────────────── Zoxide ──────────────────────
  programs.zoxide = {
    enable = true;
    enableZshIntegration = true;  
  };
}