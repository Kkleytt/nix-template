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
      line_break = "";
      scan_timeout = 10;

      format = lib.concatStrings [
        # Path
        "$directory"

        # GIT
        "$git_branch"
        "$git_status"

        # Languages
        "$docker_context"
        "$nodejs"
        "$rust"
        "$python"
        "$golang"
        "$bun"
        "$deno"
        "$angular"
        "$java"
        "$php"
        "$ruby"
        "$elixir"
        "$haskell"

        # Fill
        "$fill"

        # Right
        "$cmd_duration"
        "$character"

      ];
      fill.symbol = " ";

      # Path
      directory = {
        home_symbol = " ~";
        format = "[ 󰉖 $path ](bg:#f5c2e7 fg:#1e1e2e bold)";
        truncation_length = 8;
        truncate_to_repo = true;
        read_only = " ";
        read_only_style = "197";

        substitutions = {
          ".config" = "  ";
          ".local" = " 󰉍 ";
          "Загрузки" = " 󰛴 ";
          "Downloads" = " 󰛴 ";
          "Documents" = " 󱔗 ";
          "Music" = " 󰝚 ";
          "Videos" = " 󰎁 ";
          "Pictures" = " 󰉏 ";
          "Wallpapers" = " 󰸉 ";
          "Obsidian" = " 󰠮 ";
          "~/Projects" = "  ";
        };
      };

      # Git
      git_branch.format = "[  $branch ](bg:#a6e3a1 fg:#1e1e2e bold)";
      git_branch.only_attached = true;
      git_status.format = "[$all_status$ahead_behind](bg:#a6e3a1 fg:#1e1e2e bold)";
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

      # Language
      docker_context.format = "[ 󰡨 $context ](bg:#89b4fa fg:#1e1e2e)";
      python.format   = "[  $version ($virtualenv) ](bg:#f9e2af fg:#1e1e2e)";
      nodejs.format   = "[ 󰛦 $version ](bg:#a6e3a1 fg:#1e1e2e)";
      angular.format  = "[ 󰚲 $version ](bg:#e06c75 fg:#ffffff)";
      rust.format     = "[ 󱗼 $version ](bg:#f38ba8 fg:#1e1e2e)";
      golang.format   = "[ 󰟓 $version ](bg:#89dceb fg:#1e1e2e)";
      java.format     = "[  $version ](bg:#f28fad fg:#1e1e2e)";
      php.format      = "[ 󰣾 $version ](bg:#cba6f7 fg:#1e1e2e)";
      ruby.format     = "[  $version ](bg:#f38ba8 fg:#ffffff)";
      elixir.format   = "[ 󰘬 $version ](bg:#cba6f7 fg:#1e1e2e)";
      haskell.format  = "[ 󰲒 $version ](bg:#a6e3a1 fg:#1e1e2e)";

      # Time command
      cmd_duration = {
        format = "[  $duration ](bg:#313244 fg:#cdd6f4)";
        min_time = 2000;
      };

      # Status command
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