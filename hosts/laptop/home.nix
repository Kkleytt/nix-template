{ pkgs, inputs, ... }: {

    

    # programs.ax-shell = {
        # enable = true;
        # Дополнительные настройки (опционально):
        # settings = {
        #   general = {
        #     opacity = 0.95;
        #     radius = 12;
        #   };
        # };
    # };

    home.username = "kkleytt";
    home.homeDirectory = "/home/kkleytt";

    home.stateVersion = "25.11";  # Укажите актуальную версию

    home.packages = with pkgs; [
        
    ];

    imports = [
        inputs.ax-shell.homeManagerModules.default
    ];
    programs.ax-shell = {
        enable = true;
    };


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

    # Другие настройки: fish, starship, alacritty и т.д.
}