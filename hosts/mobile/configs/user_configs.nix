{ lib, ... }:
{
  # Hyprland
  home.file.".config/hypr/animations".source                    = ./hyprland/animations;
  home.file.".config/hypr/configs".source                       = ./hyprland/configs;
  home.file.".config/hypr/UserConfigs".source                   = ./hyprland/UserConfigs;
  home.file.".config/hypr/application-style.conf".source        = ./hyprland/application-style.conf;
  home.file.".config/hypr/hypridle.conf".source                 = ./hyprland/hypridle.conf;
  home.file.".config/hypr/hyprland.conf".source                 = ./hyprland/hyprland.conf;
  home.file.".config/hypr/hyprlock-1080p.conf".source           = ./hyprland/hyprlock-1080p.conf;
  home.file.".config/hypr/hyprlock.conf".source                 = ./hyprland/hyprlock.conf;
  home.file.".config/hypr/hyprpaper.conf".source                = ./hyprland/hyprpaper.conf;
  home.file.".config/hypr/initial-boot.sh".source               = ./hyprland/initial-boot.sh;
  home.file.".config/hypr/monitors.conf".source                 = ./hyprland/monitors.conf;
  home.file.".config/hypr/workspaces.conf".source               = ./hyprland/workspaces.conf;

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
