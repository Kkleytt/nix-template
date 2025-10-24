{ pkgs, inputs, ... }: {
    home.username = "kkleytt";
    home.homeDirectory = "/home/kkleytt";
    home.stateVersion = "25.11";

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
}