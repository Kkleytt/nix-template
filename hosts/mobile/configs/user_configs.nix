{ lib, ... }:
{
  # Hyprland
  # Копируем всю папку hyprland, но без scheme (как раньше)
  home.file.".config/hypr".source = ./hyprland;
  home.activation.fixHyprPermissions = lib.hm.dag.entryAfter ["writeBoundary"] ''
    chmod -R u+w ~/.config/hypr
    find ~/.config/hypr -type f -name "*.sh" -exec chmod +x {} \;
    find ~/.config/hypr/scripts -type f -exec chmod +x {} \; 2>/dev/null || true
    find ~/.config/hypr/UserScripts -type f -exec chmod +x {} \; 2>/dev/null || true
  '';

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
