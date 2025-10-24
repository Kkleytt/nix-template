{ pkgs, axShellPackage, axShellAux, axShellHomeModule, ... }: {
    home.username = "kkleytt";
    home.homeDirectory = "/home/kkleytt";
    home.stateVersion = "25.11";

    imports = [ axShellHomeModule ]
    programs.ax-shell.enable = true;
    programs.ax-shell.package = if axShellPackage != null then axShellPackage else null;
    programs.ax-shell.extraPackages = lib.filter (p: p != null) [ axShellAux ];

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