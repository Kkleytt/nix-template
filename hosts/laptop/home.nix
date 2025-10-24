{ pkgs, inputs, ... }: {
    home.username = "kkleytt";
    home.homeDirectory = "/home/kkleytt";
    home.stateVersion = "25.11";

    home.packages = (with pkgs; [
        inputs.caelestia-shell.packages.${system}.default
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

    programs.caelestia = {
        enable = true;
        settings = {
            bar.status = {
                showBattery = false;
            };
            paths.wallpaperDir = "~/Images";
        };
        cli = {
            enable = true; 
            settings = {
                theme.enableGtk = false;
            };
        };
    };

}