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
    
  programs = {
  # Zsh configuration
    zsh = {
      enable = true;
      enableCompletion = true;
      ohMyZsh = {
        enable = true;
        plugins = ["git"];
        theme = "agnoster"; 
      };
      
      autosuggestions.enable = true;
      syntaxHighlighting.enable = true;
      
      promptInit = ''
        fastfetch -c $HOME/.config/fastfetch/config-compact.jsonc

        #pokemon colorscripts like. Make sure to install krabby package
        #krabby random --no-mega --no-gmax --no-regional --no-title -s; 

        # ls (просмотр директории)
        alias ls='eza --icons --group-directories-first --color=always'
        alias ll='eza -lh --icons --group-directories-first --color=always'
        alias la='eza -lha --icons --group-directories-first --color=always'
        alias lt='eza --tree --icons --group-directories-first --color=always'


        # clear (очистка терминала)
        alias cls='clear'

        # ssh (подключение к серверу)
        alias ssh-server='ssh kkleytt@46.160.250.162 -p 1900'

        source <(fzf --zsh);
        HISTFILE=~/.zsh_history;
        HISTSIZE=10000;
        SAVEHIST=10000;
        setopt appendhistory;
        '';
      };
  };
}
