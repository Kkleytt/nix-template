# 💫 https://github.com/JaKooLit 💫 #
# Users - NOTE: Packages defined on this will be on current user only

{ pkgs, username, ... }:

let
  inherit (import ./variables.nix) gitUsername;
in
{
  users = { 
    mutableUsers = true;
    users."${username}" = {
      homeMode = "755";
      isNormalUser = true;
      description = "${gitUsername}";
      extraGroups = [
        "networkmanager"
        "wheel"
        "libvirtd"
        "scanner"
        "lp"
        "video" 
        "input" 
        "audio"
        "docker"
      ];

    # define user packages here
    packages = with pkgs; [
      ];
    };
    
    defaultUserShell = pkgs.zsh;
  }; 
  
  environment.shells = with pkgs; [ zsh ];
  environment.systemPackages = with pkgs; [ 
    fastfetch                               # Красивый вывод информации о системе
    fzf                                     # Быстрый поиск файлов и директорий
    ripgrep                                 # Быстрый поиск текста в файлах 
    fd                                      # Быстрый поиск файлов (аналог find)
    curl                                    # Загрузка данных по URL
    wget                                    # Загрузка файлов по URL
    eza                                     # Красивая замена ls
    zoxide                                  # Умный cd с запоминанием директорий
    tldr                                    # Красивый вывод информации о команде (аналог man)
    bat                                     # Красивый вывод файлов в консоль
    jq                                      # Обработка JSON в терминале
    atuin                                   # Расширенная история команд
  ]; 
}
