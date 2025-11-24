{ pkgs, ... }:

{
  home.packages = with pkgs; [
    starship                # prompt 2025 года
    atuin                   # умная история команд + синхронизация
    zoxide                  # умный cd (z и zi)
    eza                     # замена ls
    bat                     # замена cat
    fd                      # замена find
    ripgrep                 # rg
    fzf                     # нечёткий поиск
    fastfetch               # neofetch, но в 10 раз быстрее и красивее
    delta                   # красивый git diff
    trash-cli               # trash-put вместо rm

    curl                    # Загрузка данных по URL
    wget                    # Загрузка файлов по URL
    tldr                    # Красивый вывод информации о команде (аналог man)
    jq                      # Обработка JSON в терминале

    
  ];

  programs.zsh = {
    enable = true;
    autocd = true;
    dotDir = ".config/zsh";
    history = {
      expireDuplicatesFirst = true;
      ignoreSpace = true;
      path = "$HOME/.cache/zsh/history";
      save = 100000;
      size = 100000;
    };

    # Включаем встроенные в Home Manager быстрые плагины (на чистом C/Rust)
    enableCompletion = true;
    syntaxHighlighting.enable = true;
    autosuggestions.enable = true;

    plugins = [
      {
        name = "fzf-tab";
        src = pkgs.zsh-fzf-tab;
      }
    ];

    initExtraFirst = ''
      # ── Starship (самый быстрый и красивый prompt 2025) ──
      eval "$(starship init zsh)"

      # ── Atuin (замена всей истории zsh + поиск + синхронизация) ──
      eval "$(atuin init zsh --disable-up-arrow)"

      # ── Zoxide (умный cd) ──
      eval "$(zoxide init zsh)"

      # ── Fastfetch при старте терминала ──
      fastfetch -c ~/.config/fastfetch/config-compact.jsonc
    '';

    initExtra = ''
      # ── Удобные алиасы 2025 ──

      alias ls='eza --icons --group-directories-first --color=always'
      alias ll='eza -lh --icons --group-directories-first --color=always'
      alias la='eza -lah --icons --group-directories-first --color=always'
      alias lt='eza --tree --level=3 --icons --group-directories-first'

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

      # Git алиасы (короче и удобнее)
      alias g='git'
      alias ga='git add'
      alias gc='git commit'
      alias gp='git push'
      alias gl='git pull'
      alias gs='git status'
      alias gd='git diff'
      alias gds='git diff --staged'
      alias glog="git log --oneline --decorate --graph"

      # Красивый diff для git навсегда
      git config --global core.pager "delta"
      git config --global interactive.diffFilter "delta --color-only"
      git config --global delta.navigate true
      git config --global delta.side-by-side false
    '';

    # ── Клавиши как в 2025 (Ctrl+Стрелки, поиск по atuin и т.д.) ──
    initExtraBeforeCompInit = ''
      bindkey "^[[1;5C" forward-word          # Ctrl+Right
      bindkey "^[[1;5D" backward-word          # Ctrl+Left
      bindkey '^ ' autosuggest-accept          # Ctrl+Space — принять подсказку
    '';
  };

  programs.starship = {
    enable = true;
    settings = {
      add_newline = false;
      character = {
        success_symbol = "[➜](bold green)";
        error_symbol = "[➜](bold red)";
      };
      git_branch.style = "bold purple";
      directory.read_only = "🔒";
      nodejs.symbol = " ";
      rust.symbol = "🦀 ";
      python.symbol = "🐍 ";
      golang.symbol = "🐹 ";
    };
  };

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

  programs.zoxide = {
    enable = true;
    options = [ "--cmd" "cd" ];
  };
}