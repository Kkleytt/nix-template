{ pkgs, ... }: {
  home.username = "kkleytt";
  home.homeDirectory = "/home/kkleytt";

  home.stateVersion = "25.11";  # Укажите актуальную версию

  home.packages = with pkgs; [
    # Ваши пользовательские пакеты
    neofetch
    lazygit
    yazi
    gnome-2048
  ];

  programs.git = {
    enable = true;
    userName = "kkleytt";
    userEmail = "kkleytt@example.com";
  };

  # Другие настройки: fish, starship, alacritty и т.д.
}