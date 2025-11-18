{ pkgs, inputs, system, ... }: {
  home.username = "kkleytt";
  home.homeDirectory = "/home/kkleytt";
  home.stateVersion = "25.11";

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
        python312                                   # Интерпретатор Python 3.12
        uv                                          # Сверхбыстрый заменитель pip, virtualenv, poetry
        mypy                                        # Статический анализатор типов
        ruff                                        # Быстрый линтер и автоисправитель на Rust
        # jupyter-all                                 # Инструмент для написания кода по секицям

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
        clang                                       # Альтернативный компилятор от LLVM — быстрее, лучше ошибки.

      #### Other programming tools
        pre-commit                                  # Фреймворк для запуска проверок перед коммитом
        

    ## ClI utils
      lazygit                                     # TUI для Git (коммиты, ветки, история)
      lazydocker                                  # TUI для управления контейнерами
      lazyjournal                                 # TUI для просмотра Linux журнала
      lazyssh                                     # TUI для работы с SSH подключениями
      lazysql                                     # TUI для работы с СУБД (Postgres, MySQL)
      dooit                                       # TUI ToDo список задач
      calcurse                                    # TUI календарь со списком задач
      syncthing                                   # P2P синхронизация файлов без серверов
      neovim                                      # Улучшенный редактор кода NeoVim
      amberol                                     # Музыкальный плеер
      celluloid                                   # Видео плеер на базе MPV
      gnome-sound-recorder                        # Запись аудио
      rich-cli                                    # Красивый вывод JSON/текста с цветами и таблицами
      httpx                                       # Дружелюбная альтернатива curl для тестирования API   
      envsubst                                    # Работа с перемнными на GO
      yazi                                        # Файловый менеджер
      rofi                                        # Лаунчер запуска приложений

    ## CLI утилиты
      feh                                         # Легкий просмотрщик изображений + Сортировщик
      fastfetch                                   # Красивый вывод информации о системе

      # Неизученные утилиты (Нераспределенные)
      ripgrep                                     # Быстрый поиск текста в файлах
      atuin                                       # Расширенная история команд
      zoxide                                      # Умный cd с запоминанием директорий
      tldr                                        # Красивый вывод информации о команде (аналог man)
      fd                                          # Быстрый поиск файлов (аналог find)
    ]);

    # Настройка Git
    programs.git = {
      enable = true;
      settings = {
        user = {
          email = "kkleytt@gmail.com";
          name = "Kkleytt";
        };
      };
    };
}