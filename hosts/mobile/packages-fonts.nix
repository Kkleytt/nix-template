# файл packager-fonts.nix, здесь происходит установка зависимостей и обязательных программ
# данный файл запускает модуль /hosts/mobile/config.nix (данный модуль самостоятельно ничего не делает)
# только распредялет обязаности по дочерним модулям вроде этого

{ pkgs, inputs, lib, ...}:

{
  environment.systemPackages = (with pkgs; [
    ## Programming Language & Tools
      # Rust
        rustc                                       # Компилятор языка Rust.
        cargo                                       # Менеджер пакетов и сборки для Rust.

      # C / C++
        gcc                                         # Компилятор GNU для C/C++.
        clang                                       # Альтернативный компилятор от LLVM — быстрее, лучше ошибки.

      # Docker / Docker-compose / Kubernetes
        docker                                      # Платформа контейнеризации
        docker-compose                              # Управление мультиконтейнерными приложениями
        kubernetes                                  # Оркестрирование множеством контейнеров на разных хост-машинах

      # Javascript
        nodejs_24                                   # Интерпретатор Node.js версии 24 (актуальная LTS на 2025)
        pnpm                                        # Быстрый и экономичный менеджер пакетов для Node.js
        typescript                                  # Компилятор и типизация для TypeScript
        eslint                                      # Линтер для JavaScript/TypeScript

      # Python
        python312                                   # Интерпретатор Python 3.12
        uv                                          # Сверхбыстрый заменитель pip, virtualenv, poetry
        mypy                                        # Статический анализатор типов
        ruff                                        # Быстрый линтер и автоисправитель на Rust

      # Other
        pre-commit                                  # Фреймворк для запуска проверок перед коммитом

      # Lazy
        lazygit                                     # TUI для Git (коммиты, ветки, история)
        lazydocker                                  # TUI для управления контейнерами
        lazyjournal                                 # TUI для просмотра Linux журнала
        lazynpm
        lazyssh
        lazysql
        openpomodoro-cli                            # TUI для Pomodoro-таймера

      # Shell
        jq                                          # Обработка JSON в терминале
        rich-cli                                    # Красивый вывод JSON/текста с цветами и таблицами
        httpie                                      # Дружелюбная альтернатива curl для тестирования API   
  
  

    ## 📦 Базовые системные утилиты
        btrfs-progs                                 # Утилиты для работы с Btrfs
        curl                                        # загрузка данных по URL
        cpufrequtils                                # Управление частотой CPU
        findutils                                   # Find, xargs и др.
        glib                                        # Для работы gsettings
        gsettings-qt                                # Qt‑обёртка для gsettings
        git                                         # Контроль версий Git
        killall                                     # Завершение процессов по имени
        libappindicator                             # Иконки в системном трее
        libnotify                                   # Уведомления
        openssl                                     # Криптография (требуется для Rainbow borders)
        openssh                                     # Поддержка SSH ключей
        pciutils                                    # Информация об устройствах PCI
        neovim                                      # Улучшенный редактор кода NeoVim
        wget                                        # Загрузка файлов по URL
        xdg-user-dirs                               # Стандартные пользовательские каталоги
        xdg-utils                                   # Утилиты XDG
        unzip                                       # CLI архиватор
        ntfs3g									                    # Поддержка NTFS файловых систем
        exfat									                      # Поддержка ExFat файловых системы
        bc                                          # Компилятор для калькулятора 
        yazi                                        # Файловый менеджер
        inotify-tools                               # Наблюдатель за файлами
        mpv                                         # Стандартный видео проигрыватель
        vlc                                         # Стандартный аудио проигрыватель
        envsubst                                    # Работа с перемнными на GO

    ## 🖥️ Мониторинг и диагностика
        nvtopPackages.full                          # Мониторинг Nvidia GPU


    ## 🎨 Внешний вид и темы
        gtk-engine-murrine                          # Темы GTK2-GTK3
        libsForQt5.qtstyleplugin-kvantum            # Поддержка QT стилей
        kdePackages.qtstyleplugin-kvantum           # Поддержка QT стилей
        libsForQt5.qt5ct                            # Настройка Qt5 тем
        kdePackages.qt6ct                           # Настройка Qt6 тем
        kdePackages.qtwayland                       # Qt поддержка Wayland
        nwg-look                                    # утилита оформления
        pywal16                                     # Выборка цветов из обоев


    ## 🎧 Аудио и мультимедиа
        pamixer                                     # Управление громкостью (CLI)
        pavucontrol                                 # Управление PulseAudio/PipeWire
        pulseaudio                                  # Оригинальный PulseAudio
        playerctl                                   # Управление медиаплеерами
        yt-dlp                                      # Загрузка видео/аудио
        brightnessctl                               # Управление яркостью экрана
        amberol                                     # Музыкальный плеер
        celluloid                                   # Видео плеер на базе MPV
        gnome-sound-recorder                        # Запись аудио


    ## 🖼️ Графика и скриншотыsystem
        grim                                        # Скриншоты (Wayland)
        imagemagick                                 # CLI обработка изображений
        loupe                                       # Просмотр изображений
        slurp                                       # Выделение области
        satty                                       # Аннотации и правка скриншотов


    ## 🌐 Сеть и интернет
        networkmanagerapplet                        # GUI для NetworkManager
        bluez                                       # Bluetooth стэк
        bluez-tools                                 # Дополниетльные функции Bluetooth
        # syncthing                                   # Синхронизация файлов


    ## 🧩 Hyprland и Wayland
        hyprland-qt-support                         # Поддержка QT тем
        cliphist                                    # История буфера обмена
        kitty                                       # Терминал
        power-profiles-daemon                       # Настройка профиля питания
        nwg-displays                                # Настройка дисплеев
        rofi                                        # Лаунчер запуска приложений
        mpvpaper                                    #
        hyprpaper                                   #
        wl-clipboard                                # Буфер обмена Wayland
        yad                                         # GUI-диалоги
        hyprpicker                                  # Получение цвета с экрана
        hypridle                                    # Блокировка и управление сном
        hyprsunset                                  # Изменение цвета экрана в зависимости от времени суток
        libsecret                                   # Хранилище паролей для безопасности приложений

    ## 🧙 Разное
        polkit_gnome                                # Агент аутентификации
        
  ]);


  # Установка шрифтов
  fonts = {
    packages = with pkgs; [
      noto-fonts
      fira-code
      noto-fonts-cjk-sans
      jetbrains-mono
      font-awesome
      terminus_font
      victor-mono
      nerd-fonts.jetbrains-mono
      nerd-fonts.fira-code
      nerd-fonts.fantasque-sans-mono
    ];
  };

  # Настройка программ
  programs = {
	  hyprland = {
      enable = true;
      portalPackage = pkgs.xdg-desktop-portal-hyprland;
  	  xwayland.enable = true;
    };

    vscode.enable = true;
    nm-applet.indicator = true;
    neovim.enable = true;
	  thunar.enable = true;
    virt-manager.enable = false;

    xwayland.enable = true;

    dconf.enable = true;
    seahorse.enable = true;
    fuse.userAllowOther = true;
    mtr.enable = true;
    gnupg.agent = {
      enable = true;
      enableSSHSupport = true;
    };
  };

  # Глобальная настройка GIT
  environment.etc."gitconfig".text = lib.mkForce ''
    [user]
      name  = Kkleytt
      email = kkleytt@gmail.com

    [url "git@github.com:"]
      insteadOf = https://github.com/

    [push]
      autoSetupRemote = true

    [credential]
      helper = cache --timeout=3600
  '';
  system.activationScripts.generateSshKey.text = ''
    echo "=== Проверка SSH-ключа для пользователя kkleytt ==="

    # 1) Создать директорию, если её нет
    if [ ! -d /home/kkleytt/.ssh ]; then
      mkdir -m 700 /home/kkleytt/.ssh
      chown kkleytt:users /home/kkleytt/.ssh
    fi

    # 2) Сгенерировать ключ, если ещё нет
    if [ ! -f /home/kkleytt/.ssh/id_ed25519 ]; then
      /run/current-system/sw/bin/ssh-keygen \
        -t ed25519 \
        -f /home/kkleytt/.ssh/id_ed25519 \
        -N "" \
        -C "kkleytt@nixos"

      chown kkleytt:users /home/kkleytt/.ssh/id_ed25519*
      chmod 600 /home/kkleytt/.ssh/id_ed25519*

      echo
      echo "👉 Публичный ключ:"
      cat /home/kkleytt/.ssh/id_ed25519.pub
      echo
      echo "Скопируйте его и добавьте в GitHub: https://github.com/settings/keys"
    fi
  '';

  # Extra Portal Configuration
  xdg.portal = {
    enable = true;
    wlr.enable = true;
    extraPortals = [
      pkgs.xdg-desktop-portal-gtk
    ];
    configPackages = [
      #pkgs.xdg-desktop-portal-gtk
      #pkgs.xdg-desktop-portal
    ];
  };
}
