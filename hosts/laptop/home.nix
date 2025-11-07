{ pkgs, inputs, ... }: {
    home.username = "kkleytt";
    home.homeDirectory = "/home/kkleytt";
    home.stateVersion = "25.11";

    home.packages = (with pkgs; [
        inputs.caelestia-shell.packages.${system}.default
        inputs.caelestia-cli.packages.${system}.default
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

    programs.uv.enable = true
}