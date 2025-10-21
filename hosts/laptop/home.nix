{ pkgs, ... }: {
    home.username = "kkleytt";
    home.homeDirectory = "/home/kkleytt";

    home.stateVersion = "25.11";  # Укажите актуальную версию

    home.packages = with pkgs; [
        # Ваши пользовательские пакеты
    ];

    programs.git = {
        enable = true;
        settings = {
            user = {
                email = "kkleytt@gmail.com";
                name = "kkleytt";
            };
        };
    };

    # Другие настройки: fish, starship, alacritty и т.д.
}