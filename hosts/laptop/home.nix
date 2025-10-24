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
        systemd = {
            enable = false; # if you prefer starting from your compositor
            target = "graphical-session.target";
            environment = [];
        };
        settings = {
            bar.status = {
            showBattery = false;
            };
            paths.wallpaperDir = "~/Images";
        };
        cli = {
            enable = true; # Also add caelestia-cli to path
            settings = {
            theme.enableGtk = false;
            };
        };
    };

}