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

      # palette = "catppuccin_mocha";
      palette = "custom_one";

      # ─────── Format ───────
        format = lib.concatStrings [
          # OS
          "[╭─](logo_bg)"
          "$os"

          # Username + Hostname
          "[](bg:username_bg fg:logo_bg)"
          "$username"
          "$hostname"

          #  Path
          "[](bg:path_bg fg:username_bg)"
          "$directory"

          #  Git
          "[](bg:git_bg fg:path_bg)"
          "$git_branch"
          # "$git_status"
          "$git_commit"
          "$git_metrics"

          # Languages
          "[](bg:language_bg fg:git_bg)"
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
          "[](fg:language_bg)"
          "$fill"

          # Status
          "[](fg:error_bg)"
          "$status"

          # Duration
          "[](fg:duration_bg bg:error_bg)"
          "$cmd_duration"

          # Time + Battery
          "[](fg:time_bg bg:duration_bg)"
          "$time"
          "$battery"
          
          # Arrows
          "[─╮](fg:logo_bg)"
          "$line_break"
          "[╰─](logo_bg)"
          "$character"
        ];
        right_format            = "[─╯](logo_bg)";
        narrow_format           = "$directory$git_branch$character";


      # ─────── OS ───────
        os.disabled             = false;
        os.format               = "[  ](bg:logo_bg fg:logo_fg)()";


      # ─────── Username + Hostname только при SSH ───────
        username = {
          show_always           = false;
          format                = "[$user]($style)";
          style_user            = "bg:username_bg fg:username_fg";
          style_root            = "bg:username_bg fg:username_fg bold";
        };
        hostname = {
          disabled              = false;
          format                = "[@$hostname ](bg:username_bg fg:username_fg)";
          ssh_only              = true;
          ssh_symbol            = "";
          # trim_at               = ".companyname.com";
        };


      # ─────── Path ───────
        directory = {
          style                 = "bg:path_bg fg:path_fg";
          format                = "[ $path ]($style)[$read_only]($read_only_style)";
          truncation_length     = 3;
          read_only             = " 🔒";
          read_only_style       = "bg:path_bg";
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
          style                 = "bg:git_bg";
          commit_hash_length    = 8;
          tag_symbol            = "  ";
          tag_disabled          = false;
          disabled              = false;
        };
        git_metrics = {
          format                = "[\\[+$added/]($added_style)[-$deleted\\]]($deleted_style)[ ](bg:git_bg)";
          added_style           = "bg:git_bg fg:git_fg";
          deleted_style         = "bg:git_bg fg:git_fg";
          disabled              = false;
        };
        git_branch.format       = "[[  $branch ](bg:git_bg fg:git_fg)](bg:git_bg)";
        git_status.format       = "[[($all_status$ahead_behind )](bg:git_bg fg:git_fg)](bg:git_bg)";
        git_status_disabled     = true;


      # ─────── Языки ───────
        nodejs.format           = "[[ ( $version) ](bg:language_bg fg:language_fg)](bg:language_bg)";
        c.format                = "[[ ( $version) ](bg:language_bg fg:language_fg)](bg:language_bg)";
        rust.format             = "[[ ( $version) ](bg:language_bg fg:language_fg)](bg:language_bg)";
        golang.format           = "[[ ( $version) ](bg:language_bg fg:language_fg)](bg:language_bg)";
        php.format              = "[[ ( $version) ](bg:language_bg fg:language_fg)](bg:language_bg)";
        java.format             = "[[ ( $version) ](bg:language_bg fg:language_fg)](bg:language_bg)";
        kotlin.format           = "[[ ( $version) ](bg:language_bg fg:language_fg)](bg:language_bg)";
        haskell.format          = "[[ ( $version) ](bg:language_bg fg:language_fg)](bg:language_bg)";
        python.format           = "[[ ( $version)(\\(#$virtualenv\\)) ](bg:language_bg fg:language_fg)](bg:language_bg)";
        nix_shell.format        = "[[ ( $name) ](bg:language_bg fg:language_fg)](bg:language_bg)";
        docker_context.format   = "[[ ( $context) ](bg:language_bg fg:language_fg)](bg:language_bg)";


      # ─────── Fill ───────
        fill.symbol             = " ";
        fill.style              = "bold #000000";


      # ─────── Status ───────
        status = {
          disabled              = false;
          map_symbol            = false;
          format                = "[ 󰃤 bug ](bg:error_bg fg:error_fg)";
          success_symbol        = "";
        };


      # ─────── Duration ───────
        cmd_duration = {
          disabled              = false;
          format                = "[ [$duration ](bold bg:duration_bg fg:duration_fg)](bg:duration_bg fg:duration_fg)";
          show_milliseconds     = true;
          show_notifications    = false;
        };


      # ─────── Time ───────
        time.disabled           = false;
        time.format             = "[ $time](bg:time_bg fg:time_fg)";


      # ─────── Battery ───────
        battery = {
          disabled              = false;
          format                = "[ $symbol $percentage ]($style)";
          full_symbol           = "󰁹";
          charging_symbol       = "󰂄";
          discharging_symbol    = "󰂃";
          unknown_symbol        = "󰁽?";
          empty_symbol          = "󰂎";
          display               = [ { style = "bg:time_bg fg:time_fg"; threshold = 100; } ];
        };

      # ─────── Палитра кастомная ───────
        palettes.custom_one = {
          logo_bg           = "#323232";
          logo_fg           = "#afafaf";
          
          username_bg       = "#272727";
          username_fg       = "#a3952b";

          path_bg           = "#dc9e67ff";
          path_fg           = "#5f4127ff";

          git_bg            = "#c781e7ff";
          git_fg            = "#4c1d62ff";

          language_bg       = "#8ec4cfff";
          language_fg       = "#315861ff";

          error_bg          = "#cc6767";
          error_fg          = "#7c2e2e";

          duration_bg       = "#7b8ad3ff";
          duration_fg       = "#3b4473ff";

          time_bg           = "#323232";
          time_fg           = "#afafaf";
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