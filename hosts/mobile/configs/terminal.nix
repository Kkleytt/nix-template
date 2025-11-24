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
        # Перемещение по директориям
        alias ls='eza --icons --group-directories-first --color=always'
        alias ll='eza -lh --icons --group-directories-first --color=always'
        alias la='eza -lah --icons --group-directories-first --color=always'
        alias lt='eza --tree --level=3 --icons'
        alias cd='z'
        alias cls='clear'

        # Работа с файлами
        alias cat='bat --style=plain'
        alias rm='trash-put'
        alias grep='rg'
        alias find='fd'
        alias ps='procs'
        alias du='dust'

        # Утилиты
        alias df='duf'
        alias ping='gping'
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
    line_break = "";                    # всё в одну строку
    scan_timeout = 10;

    format = "$directory$git_branch$git_status$docker_context$nodejs$rust$python$golang$bun$deno$fill$cmd_duration$character";
    fill.symbol = " ";

    # ─────── Путь (substitutions теперь работают 100%) ───────
    directory = {
      home_symbol = " ~";
      format = "[ 󰉖 $path |](bg:#2e1e41 fg:#cba6f7 bold)";
      truncation_length = 8;
      truncate_to_repo = true;
      read_only = " ";
      read_only_style = "197";

      substitutions = {
        "Projects" = "  Proj";
        "Documents" = " 󱔗 Docs";
        "Загрузки" = " 󰛴 DL";
        ".config" = "  CFG";
        ".cache" = "  Cache";
      };
    };

    # ─────── Git ───────
    git_branch.format = "[  $branch ](bg:#264224 fg:#a6e3a1 bold)";
    git_branch.only_attached = true;
    git_status.format = "[$all_status$ahead_behind|](bg:#264224 fg:#a6e3a1 bold)";
    git_status = {
      conflicted = "🏳 ";
      up_to_date = " ";
      untracked = " ";
      ahead = "⇡ $count ";
      diverged = "⇕ ⇡$ahead_count ⇣$behind_count ";
      behind = "⇣ $count ";
      stashed = " ";
      modified = " ";
      staged = "++ ";
      renamed = "襁 ";
      deleted = " ";
    };


    # ─────── 1. Docker контекст (появляется только если запущен контейнер) ───────
    docker_context = {
      format = "[ 󰡨 $context |](bg:#16243a fg:#89b4fa bold)";
      only_with_files = false;
      disabled = false;
    };

    # ─────── Языки (версия показывается всегда, venv — отдельно) ───────
    # САМЫЙ ЧИСТЫЙ И РАБОЧИЙ ВАРИАНТ 2025–2026
    python = {
      format = "[  $version (($virtualenv) )|](bg:#3c440eff fg:c#bed04a bold)";
      symbol = "";  # убираем лишнюю иконку
      version_format = "$major.$minor";  # только 3.14

      # Обнаружение Python-проекта
      python_binary = [ "python3" "python" ];
      detect_extensions = [ "py" ];
      detect_files = [ "pyproject.toml" "requirements.txt" "__init__.py" "Pipfile" ];
    };
    # nodejs.format = "[ 󰛦 $version ](bg:#313244 fg:#a6e3a1 bold)";
    # rust.format   = "[ 󱗼 $version ](bg:#313244 fg:#f38ba8 bold)";
    # python.format = "[ 󰌠 $version ](bg:#313244 fg:#cba6f7 bold)";
    # golang.format = "[ 󰟓 $version ](bg:#313244 fg:#89dceb bold)";

    cmd_duration = {
      format = "[  $duration ](bg:#313244 fg:#cdd6f4)";
      min_time = 2000;
    };

    character = {
      success_symbol = "[ ➜ ](bold green)";
      error_symbol   = "[ ➜ ](bold red)";
    };

    # Отключаем ненужное
    hostname.disabled = true;
    username.disabled = true;
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