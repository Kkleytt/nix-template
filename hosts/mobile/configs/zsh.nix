{ pkgs, ... }:

{
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestions.enable = true;
    syntaxHighlighting.enable = true;

    initExtra = ''
      fastfetch -c $HOME/.config/fastfetch/config-compact.jsonc

      # ls (просмотр директории)
      alias ls='eza --icons --group-directories-first --color=always'
      alias ll='eza -lh --icons --group-directories-first --color=always'
      alias la='eza -lha --icons --group-directories-first --color=always'
      alias lt='eza --tree --icons --group-directories-first --color=always'

      # clear (очистка терминала)
      alias cls='clear'

      # ssh (подключение к серверу)
      alias ssh-server='ssh kkleytt@46.160.250.162 -p 1900'

      source <(fzf --zsh)
      HISTFILE=~/.zsh_history
      HISTSIZE=10000
      SAVEHIST=10000
      setopt appendhistory
    '';
  };
}
