{ pkgs, inputs, ... }: {
    home.username = "kkleytt";
    home.homeDirectory = "/home/kkleytt";
    home.stateVersion = "25.11";

    home.packages = with pkgs; [
        ## Caelestia
        inputs.caelestia-shell.packages.${system}.default
        inputs.caelestia-cli.packages.${system}.default

        ## CLI утилиты
        fastfetch
        eza
        btop
        bat
        tldr
        dysk
        duf
        atuin
        feh
        fzf
        zoxide
        fd
        ripgrep
        procs
        dooit
        calcurse
        syncthing
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