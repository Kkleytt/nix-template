{ pkgs, inputs, ... }: {
    home.username = "kkleytt";
    home.homeDirectory = "/home/kkleytt";
    home.stateVersion = "25.11";

    home.packages = with pkgs; [
        # Установка оболочки Caelestia
            inputs.caelestia-shell.packages.${system}.default
            inputs.caelestia-cli.packages.${system}.default

        ## CLI утилиты
            fastfetch                                   # Вывод информативной табличке о системе
            eza                                         # Улучшенный ls (Вывод содержимого директорий)
            btop                                        # Улучшенный top (Вывод нагрузки на систему)
            bat                                         # Улучшенный cat (Вывод содержимого файла)
            tldr                                        # Улучшенный man (Описание команд)
            dysk                                        # Вывод информации о дисках
            duf                                         # Вывод подробной информации о дисках
            atuin                                       # Сохранение истории команд
            feh                                         # CLI утилита для сортировки файлов
            fzf
            zoxide
            fd
            ripgrep
            procs
            dooit
            calcurse

        syncthing                                   # Синхронизация файлов
    ];

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