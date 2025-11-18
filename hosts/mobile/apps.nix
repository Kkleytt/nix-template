{ pkgs, ... }:

{
  users.users.kkleytt = {
    isNormalUser = true;
    packages = with pkgs; [
      ## OFF

        

        
        
        
        

        
        

        

        




      
    ];
  };

  


  # Необходимо для установки Flatpack пакетов
  xdg.portal = {
    enable = true;
    config = {
      common = { default = [ "gtk" ]; };
    };
    extraPortals = with pkgs; [
      xdg-desktop-portal-wlr
      xdg-desktop-portal-gtk
    ];
  };

}
