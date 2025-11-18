{ pkgs, ... }:

{

  # # Программы для установки из Flatpack
  # services.flatpak.packages = [
  #   "app.zen_browser.zen"                       # Браузер Zen на базе Firefox
  #   "app.fotema.Fotema"                         # Менеджер фото
  #   "io.beekeeperstudio.Studio"                 # Управление SQL Базами Данных
  # ];

  # # Необходимо для установки Flatpack пакетов
  # xdg.portal = {
  #   enable = true;
  #   config = {
  #     common = { default = [ "gtk" ]; };
  #   };
  #   extraPortals = with pkgs; [
  #     xdg-desktop-portal-wlr
  #     xdg-desktop-portal-gtk
  #   ];
  # };

}
