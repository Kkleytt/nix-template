{ pkgs, inputs, system, ... }: {
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
        python314                                   # Глобальный Python интерпретатор
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
        clang                                       # Альтернативный компилятор от LLVM — быстрее, лучше ошибки.
        # gcc                                         # Компилятор GNU для C/C++.

      #### Editors
        neovim                                      # Улучшенный редактор кода NeoVim
        zed-editor                                  # Быстрый аналог VsCode
        # vscode                                      # Классический VsCode
        # vscodium                                    # VsCode без телеметрии и слежки
        # jetbrains.pycharm-community                 # Бесплатная версия Pycharm
        # sublimetext4                                # Быстрый редактор кода
        # arduino-ide                                 # IDE для работы с Arduino



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
      lazygit                                       # TUI для Git (коммиты, ветки, история)
      lazydocker                                    # TUI для управления контейнерами
      lazyjournal                                   # TUI для просмотра Linux журнала
      lazyssh                                       # TUI для работы с SSH подключениями
      lazysql                                       # TUI для работы с СУБД (Postgres, MySQL)
      dooit                                         # TUI ToDo список задач
      calcurse                                      # TUI календарь со списком задач      
      rich-cli                                      # Красивый вывод JSON/текста с цветами и таблицами

    ## Необязательные приложения
      rofi-bluetooth                                # Управление Bluetooth через Rofi
      rofi-network-manager                          # Управление интернетом через Rofi
      rofi-calc                                     # Калькулятор Rofi

    ## Browsers
      # brave                                         # Браузер Brave
      # vivaldi                                       # Браузер Vivaldi
      # qutebrowser                                   # Браузер для управления без мышки
      # firefox                                       # Браузер Firefox
      

    ## Office
      amberol                                       # Музыкальный плеер
      celluloid                                     # Видео плеер на базе MPV
      onlyoffice-desktopeditors                     # Аналог Microsoft Office
      thunderbird                                   # Mail клиент
      # figma-linux                                   # Неофициальный клиент Figma


    ## Notepads & Read apps
      obsidian                                      # Полноценный Markdown редактор
      keypunch                                      # Аналог monkeytype
      # anytype                                       # Аналог Notion
      # apostrophe                                    # Красивый Markdown редактор
      # appflowy                                      # Аналог Notion
      # folio                                         # Простой Markdown редактор
      # foliate                                       # Читалка книг


    ## ToDo & Time control apps
      # morgen                                        # Все в одном: Календарь, Задачи, Заметки, Напоминания
      # errands                                       # Todo заметки
      # planify                                       # Красивые ToDo заметки
      # iotas                                         # Красивые ToDo заметки
      # kuro                                          # Неофициальный клиент Microsoft ToDo


    ## File system & Backups utils
      xfce.thunar
      yazi                                          # Файловый менеджер
      peazip                                        # Минималистичный архиватор
      pika-backup                                   # Бекап системы
      fragments                                     # Торрент клиент
      syncthing                                     # P2P синхронизация файлов без серверов
      # deja-dup                                      # Бекап файлов


    ## Standart apps in other shell
      baobab                                        # Просмотр использования диска
      gnome-secrets                                 # Менеджер паролей
      gnome-disk-utility                            # Управление дисками
      gnome-sound-recorder                          # Запись аудио
      # gnome-text-editor                             # Текстовый редактор
      # gnome-boxes                                   # Управление виртуальными машинами
      # turnon                                        # Wake-On-Lan приложение
      # gnome-frog                                    # Получение текста из скриншота
      # mission-center                                # Просмотр нагрузки на ПК
      # crow-translate                                # Переводчик
      # gnome-calendar                                # Календарь
      # gnome-calculator                              # Калькулятор
      # gnome-clocks                                  # Часы, Таймер, Секундомер
      

    ## Games
      # bottles                                       # Система запуска exe программ на базе Wine
      # retroarch                                     # Менеджер ретро-игр
      # heroic                                        # Игровая платформа для Epic Games Store
      # cartridges                                    # Лаунчер для игр (Официальных)
    
    
    ## Social
      materialgram                                  # Неофициальный клиент Telegram
      # legcord                                       # Неофициальный Discord клиент
      # rambox                                        # Менеджер соц-сетей
      # telegram-desktop                              # Официальный клиент Telegram
      # vesktop                                       # Неофициальный клеинт Discord
      # ferdium                                       # Менеджер соц-сетей
      # denaro                                        # Менеджер финансов
  

    ## WIKI: Стоит изучить данные утилиты в кратчайшие сроки и начать ими пользоваться для продуктивного использования системы
      # yazi                                          # Файловый менеджер
      # ripgrep                                       # Быстрый поиск текста в файлах 
      # atuin                                         # Расширенная история команд
      # zoxide                                        # Умный cd с запоминанием директорий
      # tldr                                          # Красивый вывод информации о команде (аналог man)
      # fd                                            # Быстрый поиск файлов (аналог find)
      # httpx                                         # Дружелюбная альтернатива curl для тестирования API
      # lazygit                                       # TUI для Git (коммиты, ветки, история)
      # lazydocker                                    # TUI для управления контейнерами
      # lazyjournal                                   # TUI для просмотра Linux журнала
      # lazyssh                                       # TUI для работы с SSH подключениями
      # lazysql                                       # TUI для работы с СУБД (Postgres, MySQL)
      # dooit                                         # TUI ToDo список задач
      # calcurse                                      # TUI календарь со списком задач
    ## WIKI:
  ]); 

  programs = {
    rofi = {
      enable = true;
      plugins = with pkgs; [
        rofi-emoji
        rofi-games
      ];
    };

    vscode = {
      enable = true;
      package = pkgs.vscode-fhs;
      # extensions = with pkgs.vscode-extensions; [
      #   njpwerner.autodocstring                       # Python Autodocstring (Генерация docstring для Python)
      #   formulahendry.code-runner                     # Code Runner (Запуск кода для разных языков)
      #   streetsidesoftware.code-spell-checker         # Code Spell Checker (Орфография английского языка)
      #   adpyke.codesnap                               # CodeSnap (Красивые скриншоты кода)
      #   naumovs.color-highlight                       # Color Highlight (Подсветка синтаксиса языка)
      #   ms-azuretools.vscode-containers               # Container Tools (Работа с Docker контейнерами)
      #   fill-labs.dependi                             # Dependi (Проверка версии библиотек)
      #   ms-azuretools.vscode-docker                   # Docker (Поддержка Docker синтаксиса)
      #   mikestead.dotenv                              # DotENV (Работа с ENV файлами)
      #   hediet.vscode-drawio                          # Draw.io Integration (Интеграция с draw.io)
      #   usernamehw.errorlens                          # Error Lens (Вывод ошибок прямо в код)
      #   tamasfe.even-better-toml                      # Even Better TOML (Поддержка языка TOML)
      #   mhutchie.git-graph                            # Git Graph (Вывод графов GIT)
      #   codezombiech.gitignore                        # Gitignore (Генерация .gitignore файлов)
      #   tal7aouy.icons                                # Icons (Набор иконок)
      #   oderwat.indent-rainbow                        # indent-rainbow (Разноцветная табуляция)
      #   ms-toolsai.jupyter                            # Jupyter (Набор расширений для работы с Jupyter)
      #   ms-toolsai.vscode-jupyter-cell-tags           # Jupyter Cell Tags ()
      #   ms-toolsai.jupyter-keymap                     # Jupyter Keymap ()
      #   ms-toolsai.jupyter-renderers                  # Jupyter Notebook Renders ()
      #   ms-toolsai.vscode-jupyter-slideshow           # Jupyter Slide Show ()
      #   ms-vscode.live-server                         # Live Preview (Запуск локлаьного сервера)
      #   ms-vsliveshare.vsliveshare                    # Live Share (Работа с кодом в команде в реальном времени)
      #   yzhang.markdown-all-in-one                    # Markdown All in One (Работа с Markdown файлами)
      #   bbenoist.nix                                  # Nix (Поддержка языка nix)
      #   esbenp.prettier-vscode                        # Prettier - Code formatter (Форматировщик кода)
      #   alefragnani.project-manager                   # Project Manager (Менеджер проектов)
      #   ms-python.vscode-pylance                      # Pylance (Линтер для Python)
      #   ms-python.python                              # Python (Поддержка языка Python)
      #   ms-python.debugpy                             # Python Debugger (Поддержка дебага Python)
      #   charliermarsh.ruff                            # Ruff (Форматировщик для Python)
      #   rust-lang.rust-analyzer                       # rust-analyzer (Поддержка языка Rust)
      #   jgclark.vscode-todo-highlight                 # TODO Highlight (Поддержка TODO меток в коде)
      #   gruntfuggly.todo-tree                         # TODO tree (Вывод TODO меток в формате дерева)
      #   funkyremi.vscode-google-translate             # VsCode Google Translate (Переводчик внутри кода)
      #   wakatime.vscode-wakatime                      # Wakatime (Анализ потраченного времени)
      #   redhat.vscode-xml                             # XML (Поддержка языка XML)
      #   # Gitpod theme
      #   # mintlify doc writer
      #   # monokai pro
      #   # Python Environment manager
      #   # Python Environments
      #   # Python extensions Pack
      #   # Python Indent
      #   # Russian Code spell checker
      #   # Russian Language pack
      #   # ty
      #   # vs code Todo
      #   # VsCode color picker
      #   # vscode-faker
      #   # YandexMusic
      #   # Репозитории GitHub
      #   # Удаленные репозитории
      # ];
    };
  };
  
  imports = [
    ./configs/git.nix                   # Настройка Git и SSH ключей
    ./configs/terminal.nix              # Настройка терминала
    #./configs/user_configs.nix          # Настройка локальных конфигов пользователя
  ];
}