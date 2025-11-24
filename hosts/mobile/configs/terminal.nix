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
    command_timeout = 500;

    palette = "catppuccin_mocha";

    # ─────── Формат (всё в одну строку) ───────
    format = lib.concatStrings [
      "[╭─](bg:surface0 fg:lavender)"
      "$directory"
      "$git_branch"
      "$git_status"
      "$python"
      "$nodejs"
      "$rust"
      "$golang"
      "$docker_context"
      "$fill"
      "$cmd_duration"
      "$battery"
      "$time"
      "[](bg:crust fg:surface0)"
      "$character"
    ];

    fill.symbol = " ";

    # ─────── Путь ───────
    directory = {
      format = "[ 󰉖 $path ](bg:mauve fg:crust bold)";
      truncation_length = 5;
      truncate_to_repo = true;
      read_only = "";
    };

    # ─────── Git ───────
    git_branch.format = "[  $branch ](bg:green fg:crust bold)";
    git_status.format = "[$all_status$ahead_behind](bg:green fg:crust)";

    # ─────── Языки ───────
    python.format   = "[  $version ($virtualenv) ](bg:yellow fg:crust)";
    nodejs.format   = "[ 󰛦 $version ](bg:yellow fg:crust)";
    rust.format     = "[ 󱗼 $version ](bg:yellow fg:crust)";
    golang.format   = "[ 󰟓 $version ](bg:yellow fg:crust)";
    docker_context.format = "[ 󰡨 $context ](bg:sapphire fg:crust)";

    # ─────── Время выполнения ───────
    cmd_duration = {
      format = "[  $duration ](bg:overlay0 fg:text)";
      min_time = 2000;
    };

    # ─────── Батарея ───────
    battery = {
      format = "[ $percentage% $symbol ](bg:surface1 fg:green)";
      full_symbol = "󰂄";
      charging_symbol = "󰂄";
      discharging_symbol = "󰂃";

      display = [
        { threshold = 100; style = "bg:surface1 fg:green"; }
      ];
    };

    # ─────── Время ───────
    time = {
      disabled = false;
      format = "[  $time ](bg:surface1 fg:lavender)";
      time_format = "%H:%M";
    };

    # ─────── Стрелка ввода ───────
    character = {
      success_symbol = "[ ❯ ](bold green)";
      error_symbol = "[ ✘ ](bold red)";
    };

    # ─────── Username + Hostname только при SSH ───────
    username.show_always = false;
    hostname.ssh_only = true;

    # ─────── Палитра Catppuccin Mocha (без рекурсии) ───────
    palettes.catppuccin_mocha = {
      rosewater = "#f5e0dc";
      flamingo  = "#f2cdcd";
      pink      = "#f5c2e7";
      mauve     = "#cba6f7";
      red       = "#f38ba8";
      maroon    = "#eba0ac";
      peach     = "#fab387";
      yellow    = "#f9e2af";
      green     = "#a6e3a1";
      teal      = "#94e2d5";
      sky       = "#89dceb";
      sapphire  = "#74c7ec";
      blue      = "#89b4fa";
      lavender  = "#b4befe";
      text      = "#cdd6f4";
      subtext1  = "#bac2de";
      subtext0  = "#a6adc8";
      overlay2  = "#9399b2";
      overlay1  = "#7f849c";
      overlay0  = "#6c7086";
      surface2  = "#585b70";
      surface1  = "#45475a";
      surface0  = "#313244";
      base      = "#1e1e2e";
      mantle    = "#181825";
      crust     = "#11111b";
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