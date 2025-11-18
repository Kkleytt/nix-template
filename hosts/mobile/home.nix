{ pkgs, inputs, system, lib, ... }: {
  home.username = "kkleytt";
  home.homeDirectory = "/home/kkleytt";
  home.stateVersion = "25.11";

  # Приложения (Apps)
  home.packages = (with pkgs; [
    ## Caelestia
      inputs.caelestia-shell.packages.${system}.default
      inputs.caelestia-cli.packages.${system}.default

    ## Programming Language & Tools
      #### Virtualization  
        docker                                      # Платформа контейнеризации
        docker-compose                              # Управление мультиконтейнерными приложениями
        kubernetes                                  # Оркестрирование множеством контейнеров на разных хост-машинах

      #### Python
        jupyter-all                                 # Python ядро + поддержка создания Notebook
        uv                                          # Сверхбыстрый заменитель pip, virtualenv, poetry
        mypy                                        # Статический анализатор типов
        ruff                                        # Быстрый линтер и автоисправитель на Rust

      #### Rust
        rustc                                       # Компилятор языка Rust.
        cargo                                       # Менеджер пакетов и сборки для Rust.

      #### Javascript
        nodejs_24                                   # Интерпретатор Node.js версии 24 (актуальная LTS на 2025)
        pnpm                                        # Быстрый и экономичный менеджер пакетов для Node.js
        typescript                                  # Компилятор и типизация для TypeScript
        eslint                                      # Линтер для JavaScript/TypeScript
      
      #### C / C++
        gcc                                         # Компилятор GNU для C/C++.
        # clang                                       # Альтернативный компилятор от LLVM — быстрее, лучше ошибки.

      #### Editors
        neovim                                      # Улучшенный редактор кода NeoVim
        vscode                                      # Классический VsCode
        # vscodium                                    # 
        # jetbrains.pycharm-community                 # Бесплатная версия Pycharm
        # sublimetext4                                # Быстрый редактор кода
        # arduino-ide                                 # IDE для работы с Arduino
        # zed-editor                                  # Быстрый аналог VsCode



      #### Utils
        postman                                     # Авто-тесты для API
        devtoolbox                                  # Дополнительные функции для программиста
        ptyxis                                      # Docker-ориентированный терминал
        # qwen-code                                   # AI агент в режиме консоли Qwen [не работает так как находимся на стабильной ветке]
        # termius                                     # Gui SSH + Sftp клиент
        # turtle                                      # Gui для работы с Git
        # textpieces                                  # Дополнительные функции для программиста
        # tiny-rdm                                    # Gui для работы с Redis
        # warehouse                                   # Менеджер пакетов Flatpak

      #### Other programming tools
        pre-commit                                  # Фреймворк для запуска проверок перед коммитом
        envsubst                                    # Работа с перемнными на GO
        # zeal                                        # Документация для программистов
        

    ## ClI utils
      lazygit                                     # TUI для Git (коммиты, ветки, история)
      lazydocker                                  # TUI для управления контейнерами
      lazyjournal                                 # TUI для просмотра Linux журнала
      lazyssh                                     # TUI для работы с SSH подключениями
      lazysql                                     # TUI для работы с СУБД (Postgres, MySQL)
      dooit                                       # TUI ToDo список задач
      calcurse                                    # TUI календарь со списком задач
      ripgrep                                     # Быстрый поиск текста в файлах 
      atuin                                       # Расширенная история команд
      zoxide                                      # Умный cd с запоминанием директорий
      tldr                                        # Красивый вывод информации о команде (аналог man)
      fd                                          # Быстрый поиск файлов (аналог find)
      rich-cli                                    # Красивый вывод JSON/текста с цветами и таблицами

    ## Необязательные приложения
      rofi                                        # Лаунчер запуска приложений
      amberol                                     # Музыкальный плеер
      celluloid                                   # Видео плеер на базе MPV
      gnome-sound-recorder                        # Запись аудио
      syncthing                                   # P2P синхронизация файлов без серверов
      

    ## WIKI: Стоит изучить данные утилиты в кратчайшие сроки и начать ими пользоваться для продуктивного использования системы
      # yazi                                        # Файловый менеджер
      # ripgrep                                     # Быстрый поиск текста в файлах 
      # atuin                                       # Расширенная история команд
      # zoxide                                      # Умный cd с запоминанием директорий
      # tldr                                        # Красивый вывод информации о команде (аналог man)
      # fd                                          # Быстрый поиск файлов (аналог find)
      # httpx                                       # Дружелюбная альтернатива curl для тестирования API
      # lazygit                                     # TUI для Git (коммиты, ветки, история)
      # lazydocker                                  # TUI для управления контейнерами
      # lazyjournal                                 # TUI для просмотра Linux журнала
      # lazyssh                                     # TUI для работы с SSH подключениями
      # lazysql                                     # TUI для работы с СУБД (Postgres, MySQL)
      # dooit                                       # TUI ToDo список задач
      # calcurse                                    # TUI календарь со списком задач
    ## WIKI:

    ## Browsers
      # vivaldi                                     # Браузер Vivaldi
      # qutebrowser                                 # Браузер для управления без мышки
      # brave                                       # Браузер Brave
      # firefox                                     # Браузер Firefox
      

    ## Office
      onlyoffice-desktopeditors                   # Аналог Microsoft Office
      thunderbird                                 # Mail клиент
      # figma-linux                                 # Неофициальный клиент Figma


    ## Notepads & Read apps
      obsidian                                    # Полноценный Markdown редактор
      keypunch                                    # Аналог monkeytype
      # anytype                                     # Аналог Notion
      # apostrophe                                  # Красивый Markdown редактор
      # appflowy                                    # Аналог Notion
      # folio                                       # Простой Markdown редактор
      # foliate                                     # Читалка книг


    ## ToDo & Time control apps
      # morgen                                      # Все в одном: Календарь, Задачи, Заметки, Напоминания
      # errands                                     # Todo заметки
      # planify                                     # Красивые ToDo заметки
      # iotas                                       # Красивые ToDo заметки
      # dosage-tracker                              # Напоминалка



    ## File system & Backups utils
      xfce.thunar                                 # Стандартный файловый менеджер
      yazi                                        # Файловый менеджер
      peazip                                      # Минималистичный архиватор
      pika-backup                                 # Бекап системы
      fragments                                   # Торрент клиент
      # deja-dup                                    # Бекап файлов


    ## Standart apps in other shell
      baobab                                      # Просмотр использования диска
      gnome-secrets                               # Менеджер паролей
      gnome-text-editor                           # Текстовый редактор
      gnome-disk-utility                          # Управление дисками
      # gnome-boxes                                 # Управление виртуальными машинами
      # turnon                                      # Wake-On-Lan приложение
      # gnome-frog                                  # Получение текста из скриншота
      # mission-center                              # Просмотр нагрузки на ПК
      # crow-translate                              # Переводчик
      # gnome-calendar                              # Календарь
      # gnome-calculator                            # Калькулятор
      # gnome-clocks                                # Часы, Таймер, Секундомер
      # kooha                                       # Запись экрана
      

    ## Games
      # bottles                                     # Система запуска exe программ на базе Wine
      # retroarch                                   # Менеджер ретро-игр
      # heroic                                      # Игровая платформа для Epic Games Store
      # cartridges                                  # Лаунчер для игр (Официальных)
    
    
    ## Social
      materialgram                                # Неофициальный клиент Telegram
      # legcord                                     # Неофициальный Discord клиент
      # rambox                                      # Менеджер соц-сетей
      # telegram-desktop                            # Официальный клиент Telegram
      # vesktop                                     # Неофициальный клеинт Discord
      # cassette                                    # Аналог Яндекс Музыки
      # ferdium                                     # Менеджер соц-сетей
      # denaro                                      # Менеджер финансов
      # kuro                                        # Неофициальный клиент Microsoft ToDo
    ]);


    # Активационный шаг: добавляем Flathub и ставим приложения для пользователя
    home.activation.flatpakUserApps = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
      ${pkgs.flatpak}/bin/flatpak remote-add --if-not-exists --user flathub https://flathub.org/repo/flathub.flatpakrepo

      ${pkgs.flatpak}/bin/flatpak install -y --user flathub \
        app.zen_browser.zen \
        app.fotema.Fotema \
        io.beekeeperstudio.Studio
    '';

    

    programs = {
      
      # Настройка Git
      git = {
        enable = true;
        settings = {
          user = {
            email = "kkleytt@gmail.com";
            name = "Kkleytt";
          };
        };
      };

      
    };

    
}