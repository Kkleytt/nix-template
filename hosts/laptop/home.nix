{ pkgs, ... }: {
  home.username = "kkleytt";
  home.homeDirectory = "/home/kkleytt";

  home.stateVersion = "24.11";  # Укажите актуальную версию

  home.packages = with pkgs; [
    # Ваши пользовательские пакеты
    neofetch
    lazygit
    yazi
  ];

  programs.git = {
    enable = true;
    userName = "kkleytt";
    userEmail = "you@example.com";
  };

  # Другие настройки: fish, starship, alacritty и т.д.
}