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

      # ─────── Format ───────
        format = lib.concatStrings [
          # OS
          "[╭─](surface0)"
          "$os"

          # Username + Hostname
          "[ ](bg:lavender fg:surface0)"
          "$username"
          "$hostname"

          #  Path
          "$directory"

          #  Git
          "$git_branch"
          # "$git_status"
          "$git_commit"
          "$git_metrics"

          # Languages
          "[ ](fg:green bg:yellow)"
          "$c"
          "$rust"
          "$golang"
          "$nodejs"
          "$php"
          "$java"
          "$kotlin"
          "$haskell"
          "$python"
          "$docker_context"
          "$conda"

          # Fill
          "[ ](fg:sapphire)"
          "$fill"

          # Status
          "[](fg:red)"
          "$status"

          # Duration
          "[](fg:lavender bg:red)"
          "$cmd_duration"

          # Time + Battery
          "[](bg:lavender fg:surface0)"
          "$time"
          "$battery"
          
          # Arrows
          "[─╮](fg:surface0)"
          "$line_break"
          "[╰─](surface0)"
          "$character"
        ];
        right_format            = "[─╯](surface0)";
        narrow_format           = "$directory$git_branch$character";


      # ─────── OS ───────
        os.disabled             = true;
        os.format               = "[ 👾 ](bg:surface0 fg:lavender)()";


      # ─────── Username + Hostname только при SSH ───────
        username = {
          show_always           = false;
          format                = "[$user]($style)";
          style_user            = "bg:lavender fg:surface0";
          style_root            = "bg:lavender fg:surface0 bold";
        };
        hostname = {
          disabled              = false;
          format                = "[@$hostname](bg:lavender fg:surface0)";
          ssh_only              = true;
          ssh_symbol            = "";
          # trim_at               = ".companyname.com";
        };


      # ─────── Path ───────
        directory = {
          style                 = "bg:peach fg:surface0";
          format                = "[ $path]($style)[$read_only]($read_only_style)";
          truncation_length     = 3;
          read_only             = " 🔒";
          read_only_style       = "bg:peach";
          # truncation_symbol     = "~/";

          substitutions = {
            "Загрузки"          = "  ";
            "Downloads"         = "  ";
            "Pictures"          = " 󰉏 ";
            "Documents"         = " 󰈙 ";
            "Music"             = " 󰎈 ";
            "Videos"            = "  ";
            "Wallpapers"        = " 🖼 ";
            "Obsidian"          = "  ";
            "Projetcs"          = "  ";
            ".config"           = "  ";
            ".local"            = " 󰜚 ";
          };
        };


      # ─────── Git ───────
        git_commit = {
          format                = "[\($hash$tag\)]($style)[ ]()";
          style                 = "bg:green";
          commit_hash_length    = 8;
          tag_symbol            = "  ";
          tag_disabled          = false;
          disabled              = false;
        };
        git_metrics = {
          format                = "[\\[+$added/]($added_style)[-$deleted\\]]($deleted_style)[ ](bg:green)";
          added_style           = "bg:green fg:crust";
          deleted_style         = "bg:green fg:crust";
          disabled              = false;
        };
        git_branch.format       = "[[  $branch ](fg:crust bg:green)](bg:green)";
        git_status.format       = "[[($all_status$ahead_behind )](fg:crust bg:green)](bg:green)";
        git_status_disabled     = true;


      # ─────── Языки ───────
        nodejs.format           = "[[ ( $version) ](fg:crust bg:yellow)](bg:yellow)";
        c.format                = "[[ ( $version) ](fg:crust bg:yellow)](bg:yellow)";
        rust.format             = "[[ ( $version) ](fg:crust bg:yellow)](bg:yellow)";
        golang.format           = "[[ ( $version) ](fg:crust bg:yellow)](bg:yellow)";
        php.format              = "[[ ( $version) ](fg:crust bg:yellow)](bg:yellow)";
        java.format             = "[[ ( $version) ](fg:crust bg:yellow)](bg:yellow)";
        kotlin.format           = "[[ ( $version) ](fg:crust bg:yellow)](bg:yellow)";
        haskell.format          = "[[ ( $version) ](fg:crust bg:yellow)](bg:yellow)";
        python.format           = "[[ ( $version)(\\(#$virtualenv\\)) ](fg:crust bg:yellow)](bg:yellow)";
        docker_context.format   = "[[ ( $context) ](fg:crust bg:sapphire)](bg:yellow)";


      # ─────── Fill ───────
        fill.symbol             = " ";
        fill.style              = "bold subtext1";


      # ─────── Status ───────
        status = {
          disabled              = false;
          map_symbol            = false;
          format                = "[ 󰃤 $status $hex_status( \uf0a2 $signal_number-$signal_name)](bg:red fg:surface0)";
          success_symbol        = "";
        };


      # ─────── Duration ───────
        cmd_duration = {
          disabled              = false;
          format                = "[ [$duration ](bold fg:surface0 bg:lavender)](fg:surface0 bg:lavender)";
          show_milliseconds     = true;
          show_notifications    = false;
        };


      # ─────── Time ───────
        time.disabled           = false;
        time.format             = "[ $time ](bg:surface0 fg:lavender)";


      # ─────── Battery ───────
        battery = {
          disabled              = false;
          format                = "[ $symbol $percentage ]($style)";
          full_symbol           = "󰁹";
          charging_symbol       = "󰂄";
          discharging_symbol    = "󰂃";
          unknown_symbol        = "󰁽?";
          empty_symbol          = "󰂎";
          display               = [ { style = "fg:lavender bg:surface0"; threshold = 100; } ];
        };

      

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