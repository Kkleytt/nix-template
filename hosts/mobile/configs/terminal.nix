{ pkgs, config, lib, ... }:

{
  home.packages = with pkgs; [
    # Only user
    starship      # Красивый и сверхбыстрый prompt для терминала
    fastfetch     # Улучшенный neofetch — мгновенный и красивый вывод информации о системе
    atuin         # Умная история команд с поиском и синхронизацией
    zoxide        # Улучшенный cd — запоминает папки и прыгает по ним командой z
    ripgrep       # Улучшенный grep — молниеносный поиск по тексту
    delta         # Улучшенный git diff — с подсветкой, side-by-side и навигацией
    trash-cli     # Безопасный rm — удаляет в корзину с возможностью восстановления
    tldr          # Короткие и понятные примеры команд вместо длинных man-страниц
    procs         # Улучшенный ps — красивый и информативный вывод процессов
    dust          # Улучшенный du — показывает, кто жрёт место на диске (деревом)
    gping         # Улучшенный ping — с графиком и цветами
    zsh-fzf-tab   # Замена стандартного Tab-комплита на fzf-подсказки

    # Global position
    bat           # Улучшенный cat — с подсветкой синтаксиса и номерами строк
    eza           # Улучшенный ls — с иконками, цветами и деревом
    fd            # Улучшенный find — в десятки раз быстрее и проще
    fzf           # Нечёткий поиск по файлам, истории, процессам и всему подряд
    curl          # Универсальная утилита для HTTP-запросов
    wget          # Классическая утилита для скачивания файлов и сайтов
    jq            # Мощный процессор JSON прямо в терминале
    duf           # Улучшенный df — красивая таблица использования дисков
    httpx                                       # Улучгенный curl - быстрее и удобнее
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

  # ────────────────────── Zoxide ──────────────────────
  home.activation.yaziPlugins = lib.hm.dag.entryAfter ["writeBoundary"] ''
    mkdir -p ~/.config/yazi/plugins
    # ────────────────────── Плагины (включай/выключай по вкусу) ──────────────────────
    ln -sf ${pkgs.yaziPlugins.mediainfo}/share/yazi/plugins/mediainfo ~/.config/yazi/plugins/ 2>/dev/null || true
    ln -sf ${pkgs.yaziPlugins.recycle-bin}/share/yazi/plugins/recycle-bin ~/.config/yazi/plugins/ 2>/dev/null || true
    ln -sf ${pkgs.yaziPlugins.chmod}/share/yazi/plugins/chmod ~/.config/yazi/plugins/ 2>/dev/null || true
    ln -sf ${pkgs.yaziPlugins.full-border}/share/yazi/plugins/full-border ~/.config/yazi/plugins/ 2>/dev/null || true
    ln -sf ${pkgs.yaziPlugins.toggle-pane}/share/yazi/plugins/toggle-pane ~/.config/yazi/plugins/ 2>/dev/null || true
    ln -sf ${pkgs.yaziPlugins.starship}/share/yazi/plugins/starship ~/.config/yazi/plugins/ 2>/dev/null || true
    ln -sf ${pkgs.yaziPlugins.mount}/share/yazi/plugins/mount ~/.config/yazi/plugins/ 2>/dev/null || true
    ln -sf ${pkgs.yaziPlugins.ouch}/share/yazi/plugins/ouch ~/.config/yazi/plugins/ 2>/dev/null || true
    ln -sf ${pkgs.yaziPlugins.git}/share/yazi/plugins/git ~/.config/yazi/plugins/ 2>/dev/null || true
    ln -sf ${pkgs.yaziPlugins.bookmarks}/share/yazi/plugins/bookmarks ~/.config/yazi/plugins/ 2>/dev/null || true
    ln -sf ${pkgs.yaziPlugins.wl-clipboard}/share/yazi/plugins/wl-clipboard ~/.config/yazi/plugins/ 2>/dev/null || true
    ln -sf ${pkgs.yaziPlugins.rich-preview}/share/yazi/plugins/rich-preview ~/.config/yazi/plugins/ 2>/dev/null || true
    ln -sf ${pkgs.yaziPlugins.sudo}/share/yazi/plugins/sudo ~/.config/yazi/plugins/ 2>/dev/null || true
    ln -sf ${pkgs.yaziPlugins.compress}/share/yazi/plugins/compress ~/.config/yazi/plugins/ 2>/dev/null || true
    ln -sf ${pkgs.yaziPlugins.miller}/share/yazi/plugins/miller ~/.config/yazi/plugins/ 2>/dev/null || true
    ln -sf ${pkgs.yaziPlugins.max-preview}/share/yazi/plugins/max-preview ~/.config/yazi/plugins/ 2>/dev/null || true
  '';
}