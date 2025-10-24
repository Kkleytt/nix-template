{ pkgs, axShellPackage, axShellHomeModule, ... }: {
    home.username = "kkleytt";
    home.homeDirectory = "/home/kkleytt";
    home.stateVersion = "25.11";

    imports = [ axShellHomeModule ];

    programs.ax-shell = {
        enable = true;
        package = axShellPackage;
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