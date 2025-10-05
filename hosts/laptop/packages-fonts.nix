{ pkgs, inputs, lib, ...}: let

  python-packages = pkgs.python3.withPackages (
    ps:
      with ps; [
        pip
        requests 
        pyquery 
        aiohttp
        pydantic 
        sqlalchemy
        asyncpg
        asyncmy
        redis
        fastapi 
        uvicorn
        numpy 
        pandas 
        matplotlib
        rich 
        faker
        ]
    );

  vscode-packages = pkgs.vscode-extensions (
    ps:
      with ps; [
        # Дополнительные языки
        ms-ceintl.vscode-language-pack-ru
        ms-ceintl.vscode-language-pack-fr
        bbenoist.nix
        zainchen.json
        streetsidesoftware.code-spell-checker

        # Python Расширения
        ms-python.python
        ms-python.vscode-pylance
        ms-python.pylint
        ms-python.mypy-type-checker
        ms-python.flake8
        ms-python.black-formatter
        ms-python.isort
        ms-python.debugpy
        njpwerner.autodocstring
        

        # Полезные расширения
        formulahendry.code-runner
        ms-azuretools.vscode-docker
        ms-azuretools.vscode-containers
        usernamehw.errorlens
        eamodio.gitlens
        ritwickdey.liveserver
      ]
  );

in {

  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = (with pkgs; [
    ## 📦 Базовые системные утилиты
    btrfs-progs                               # Утилиты для работы с Btrfs
    curl                                      # загрузка данных по URL
    cpufrequtils                              # Управление частотой CPU
    duf                                       # Современный аналог du
    findutils                                 # Find, xargs и др.
    glib                                      # Для работы gsettings
    gsettings-qt                              # Qt‑обёртка для gsettings
    git                                       # Контроль версий Git
    killall                                   # Завершение процессов по имени
    libappindicator                           # Иконки в системном трее
    libnotify                                 # Уведомления
    openssl                                   # Криптография (требуется для Rainbow borders)
    openssh                                   # Поддержка SSH ключей
    pciutils                                  # Информация об устройствах PCI
    neovim                                    # Улучшенный редактор кода NeoVim
    wget                                      # Загрузка файлов по URL
    xdg-user-dirs                             # Стандартные пользовательские каталоги
    xdg-utils                                 # Утилиты XDG
    unzip                                     # CLI архиватор
    ntfs3g									                  # Поддержка NTFS файловых систем
    exfat									                    # Поддержка ExFat файловых системы


    ## CLI утилиты
    fastfetch                                 # Вывод информативной табличке о системе
    btop                                      # Улучшенный top (Вывод нагрузки на систему)
    bat                                       # Улучшенный cat (Вывод содержимого файла)
    tldr                                      # Улучшенный man (Описание команд)
    dysk                                      # Вывод информации и дисках
    zoxide                                    # Улучшенный cd
    atuin                                     # Сохранение истории команд


    ## 🖥️ Мониторинг и диагностика
    inxi                                      # Системная информация
    nvtopPackages.full                        # Мониторинг Nvidia GPU


    ## 🎨 Внешний вид и темы
    gtk-engine-murrine                        # Темы GTK2-GTK3
    libsForQt5.qtstyleplugin-kvantum
    kdePackages.qtstyleplugin-kvantum
    libsForQt5.qt5ct                          # Настройка Qt5 тем
    kdePackages.qt6ct                         # Настройка Qt6 тем
    kdePackages.qtwayland                     # Qt поддержка Wayland
    nwg-look                                  # утилита оформления
    pywal16                                   # Выборка цветов из обоев


    ## 🎧 Аудио и мультимедиа
    pamixer                                   # Управление громкостью (CLI)
    pavucontrol                               # Управление PulseAudio/PipeWire
    pulseaudio                                # Оригинальный PulseAudio для работы Swaync
    playerctl                                 # Управление медиаплеерами
    yt-dlp                                    # Загрузка видео/аудио
    brightnessctl                             # Управление яркостью экрана
    amberol                                   # Музыкальный плеер
    celluloid                                 # Видео плеер на базе MPV
    gnome-sound-recorder                      # Запись аудио


    ## 🖼️ Графика и скриншотыsystem
    grim                                      # Скриншоты (Wayland)
    imagemagick                               # CLI обработка изображений
    loupe                                     # Просмотр изображений
    slurp                                     # Выделение области
    satty                                     # Аннотации и правка скриншотов


    ## 🌐 Сеть и интернет
    networkmanagerapplet                      # GUI для NetworkManager
    # rofi-network-manager                      # Rofi интерфейс для сетей
    bluez                                     # Bluetooth стэк
    bluez-tools                               # Дополниетльные функции Bluetooth


    ## 🧩 Hyprland и Wayland
    hyprland-qt-support
    cliphist                                  # История буфера обмена
    kitty                                     # Терминал
    nwg-displays                              # Настройка дисплеев
    rofi-wayland                              # Лаунчер запуска приложений
    swaynotificationcenter                    # Центр уведомлений
    swww                                      # Обои в Wayland
    wl-clipboard                              # Буфер обмена Wayland
    wlogout                                   # Экран выхода
    yad                                       # GUI-диалоги
    hyprpicker                                # Получение цвета с экрана
    hypridle                                  # Блокировка и управление сном
    hyprpanel                                 # Бар меню сверху экрана
    hyprsunset                                # Изменение цвета экрана в зависимости от времени суток


    ## 🧰 Разработка и инструменты
    clang                                     # Компилятор C/C++
    libgcc                                    # Сборка GNU C/C++
    gccNGPackages_15.libstdcxx
    jq                                        # Парсер JSON
    docker                                    # Docker поддержка
    docker-client                             # GUI обертка вокруг Docker
    docker-compose                            # Docker-compose поддержка
    pipenv                                    # Python менеджер пакетов
    poetry                                    # Python менеджер пакетов
    uv                                        # Python менеджер пакетов


    ## 🧙 Разное
    polkit_gnome                              # Агент аутентификации

  ]) ++ [
	  python-packages                           # Установка Python библиотек
    vscode-packages                           # Установка VsCode расширений
  ];


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

	  waybar.enable = true;
	  hyprlock.enable = true;
    nm-applet.indicator = true;
    neovim.enable = true;
    git.enable = true;
	  thunar.enable = true;
    thunderbird.enable = false;
    virt-manager.enable = false;

    # steam = {
    #   enable = false;
    #   gamescopeSession.enable = true;
    #   remotePlay.openFirewall = true;
    #   dedicatedServer.openFirewall = true;
    # };

    xwayland.enable = true;

    dconf.enable = true;
    seahorse.enable = true;
    fuse.userAllowOther = true;
    mtr.enable = true;
    gnupg.agent = {
      enable = true;
      enableSSHSupport = true;
    };


    # Яндекс музыка
    # yandex-music.enable = true;
    # yandex-music.tray.enable = true;
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
    wlr.enable = false;
    extraPortals = [
      pkgs.xdg-desktop-portal-gtk
    ];
    configPackages = [
      #pkgs.xdg-desktop-portal-gtk
      #pkgs.xdg-desktop-portal
    ];
  };
}
