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

    enableCompletion = true;  
    syntaxHighlighting = { enable = true; };

    plugins = [
      { name = "fzf-tab"; src = pkgs.zsh-fzf-tab; }
      { name = "autosuggestions";  src = pkgs.zsh-autosuggestions; }
    ];

    shellAliases = {
      # Перемещение по директориям и работа с ними
      du   = "dust";
      ls   = "eza --icons --group-directories-first --color=always";
      ll   = "eza -lh --icons --group-directories-first --color=always";
      la   = "eza -lah --icons --group-directories-first --color=always";
      lt   = "eza --tree --level=3 --icons";
      cd   = "z";
      cls  = "clear";

      # Работа с файлами
      cat  = "bat --style=plain";
      rm   = "trash-put";
      grep = "rg";
      find = "fd";
      ps   = "procs";

      df   = "duf";
      ping = "gping";
      ssh-server = "ssh kkleytt@46.160.250.162 -p 1900";
      compact = "~/Projects/system/hyprland/scripts/hyprland/starship/script.sh compact";
      extra-compact = "~/Projects/system/hyprland/scripts/hyprland/starship/script.sh extra-compact";

      # git
      g    = "git";
      ga   = "git add";
      gc   = "git commit";
      gp   = "git push";
      gl   = "git pull";
      gs   = "git status";
      gd   = "git diff";
      gds  = "git diff --staged";
      glog = "git log --oneline --decorate --graph";
    };

    initContent = lib.mkMerge [
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
    settings = { };
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