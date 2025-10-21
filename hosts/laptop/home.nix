{ pkgs, inputs, ... }: {

    home.username = "kkleytt";
    home.homeDirectory = "/home/kkleytt";

    home.stateVersion = "25.11";  # Укажите актуальную версию

    home.packages = with pkgs; [
        # Ваши пользовательские пакеты
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

    programs.ax-shell = {
        enable = true;
    };

    # Другие настройки: fish, starship, alacritty и т.д.
}