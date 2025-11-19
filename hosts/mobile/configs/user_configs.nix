{ lib, ... }:
{
  # Hyprland
  home.activation.hyprProfiles = lib.hm.dag.entryAfter ["writeBoundary"] ''
    mkdir -p ~/.config/hypr
    mkdir -p ~/.config/hypr/animations
    mkdir -p ~/.config/hypr/configs
    mkdir -p ~/.config/hypr/scripts
    mkdir -p ~/.config/hypr/UserConfigs
    mkdir -p ~/.config/hypr/UserScripts
    mkdir -p ~/.config/hypr/Monitor_Profiles
    mkdir -p ~/.config/hypr/wallpaper_effects
    mkdir -p ~/.config/hypr/wallust
  '';

  home.file.".config/hypr".source              = ./hyprland;

  # Rofi

  # Caelestia

  # Kitty

  # Alacritty

  # Ghostty

  # Neovim

  # Fastfetch

  # Waybar

  # Hyprpanel
}
