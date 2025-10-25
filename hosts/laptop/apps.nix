{ pkgs, ... }:

{
  users.users.kkleytt = {
    isNormalUser = true;
    packages = with pkgs; [
      ## OFF

        # vivaldi                                   # Браузер Vivaldi
        # qutebrowser                               # Браузер для управления без мышки
        # brave                                     # Браузер Brave
        # firefox                                   # Браузер Firefox

        # morgen                                    # Все в одном: Календарь, Задачи, Заметки, Напоминания
        # errands                                   # Todo заметки
        # planify                                   # Красивые ToDo заметки
        # iotas                                     # Красивые ToDo заметки
        # appflowy                                  # Аналог Notion
        # folio                                     # Простой Markdown редактор
        # foliate                                   # Читалка книг
        # figma-linux                               # Неофициальный клиент Figma
        # apostrophe                                # Красивый Markdown редактор
        # dosage-tracker                            # Напоминалка

        # jetbrains.pycharm-community               # Бесплатная версия Pycharm
        # sublimetext4                              # Быстрый редактор кода
        # arduino-ide                               # IDE для работы с Arduino
        # zeal                                      # Документация для программистов
        # termius                                   # Gui SSH + Sftp клиент
        # turtle                                    # Gui для работы с Git
        # textpieces                                # Дополнительные функции для программиста
        # tiny-rdm                                  # Gui для работы с Redis
        # zed-editor                                # Быстрый аналог VsCode
        # vscodium                                  # VsCode без телеметрии
        # warehouse                                 # Менеджер пакетов Flatpak

        # baobab                                    # Просмотр использования диска
        # gnome-boxes                               # Управление виртуальными машинами
        # deja-dup                                  # Бекап файлов
        # turnon                                    # Wake-On-Lan приложение
        # gnome-frog                                # Получение текста из скриншота
        # mission-center                            # Просмотр нагрузки на ПК
        # crow-translate                            # Переводчик
        # gnome-calendar                            # Календарь
        # gnome-calculator                          # Калькулятор
        # gnome-clocks                              # Часы, Таймер, Секундомер
        # kooha                                     # Запись экрана
        # anytype                                   # Аналог Notion

        # bottles                                   # Система запуска exe программ на базе Wine
        # retroarch                                 # Менеджер ретро-игр
        # heroic                                    # Игровая платформа для Epic Games Store
        # cartridges                                # Лаунчер для игр (Официальных)

        # legcord                                   # Неофициальный Discord клиент
        # rambox                                    # Менеджер соц-сетей
        # telegram-desktop                          # Официальный клиент Telegram
        # vesktop                                   # Неофициальный клеинт Discord
        # cassette                                  # Аналог Яндекс Музыки
        # ferdium                                   # Менеджер соц-сетей
        # denaro                                    # Менеджер финансов
        # kuro                                      # Неофициальный клиент Microsoft ToDo




      ## Store manager
        flatpak                                   # Менеджер пакетов Flatpak


      ## Programming apps (Nvim is base)
        vscode                                    # Классический VsCode
        postman                                   # Авто-тесты для API
        ptyxis                                    # Docker-ориентированный терминал
        devtoolbox                                # Дополнительные функции для программиста


      ## Office
        onlyoffice-desktopeditors                 # Аналог Microsoft Office
        obsidian                                  # Полноценный Markdown редактор
        thunderbird                               # Mail клиент


      ## File system
        peazip                                    # Минималистичный архиватор
        pika-backup                               # Бекап системы
        fragments                                 # Торрент клиент


      ## GNOME apps
        gnome-secrets                             # Менеджер паролей
        gnome-text-editor                         # Текстовый редактор
        gnome-disk-utility                        # Управление дисками
      

      ## System
      ## Social
        materialgram                              # Неофициальный клиент Telegram
      

      ## ToDo
      ## Other
        keypunch                                  # Аналог monkeytype

    ];
  };

  services.flatpak.packages = [
    "app.zen_browser.zen"                       # Браузер Zen на базе Firefox
    "app.fotema.Fotema"                         # Менеджер фото
    "io.beekeeperstudio.Studio"                 # Управление SQL Базами Данных
  ];


  # Required to install flatpak
  xdg.portal = {
    enable = true;
    config = {
      common = { default = [ "gtk" ]; };
    };
    extraPortals = with pkgs; [
      xdg-desktop-portal-wlr
      xdg-desktop-portal-kde
      xdg-desktop-portal-gtk
    ];
  };

}
