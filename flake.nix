{
  description = "KooL's NixOS-Hyprland"; 
  	
  inputs = {
		# Нестабильная ветка NixPkgs
  	nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

		# Ссылка на установщик пакетов Flatpak
		nix-flatpak.url = "github:gmodena/nix-flatpak/?ref=v0.6.0";

		# Ссылка на установщик Яндекс Музыки
		yandex-music.url = "github:cucumber-sp/yandex-music-linux";

		# Ссылка на темы для Grub2
		distro-grub-themes.url = "github:AdisonCavani/distro-grub-themes";

		# Ссылка на тему SDDM
		silentSDDM = {
			url = "github:uiriansan/SilentSDDM";
			inputs.nixpkgs.follows = "nixpkgs";
		};
	
		# Настройка Hyprland
		hyprland.url = "github:hyprwm/Hyprland";
		hyprland-plugins = {
			url = "github:hyprwm/hyprland-plugins";
			inputs.hyprland.follows = "hyprland";
		};
		# Доустановить Hypgrass
		

    quickshell = {
      url = "git+https://git.outfoxxed.me/outfoxxed/quickshell";
        inputs.nixpkgs.follows = "nixpkgs";
      };

  };

  outputs = inputs@{ self, nixpkgs, ... }:
    let
			system = "x86_64-linux";
			host = "laptop";
			username = "kkleytt";

			pkgs = import nixpkgs {
				inherit system;
				config = {
				allowUnfree = true;
				};
  		};
		in {
			nixosConfigurations = {
				laptop = nixpkgs.lib.nixosSystem rec {
					specialArgs = { 
						inherit system;
						inherit inputs;
						inherit username;
						inherit host;
					};
					modules = [ 
						inputs.yandex-music.nixosModules.default
						inputs.nix-flatpak.nixosModules.nix-flatpak
						inputs.distro-grub-themes.nixosModules.${system}.default

						./hosts/laptop/config.nix 
						./modules/quickshell.nix
						
					];
				};
			};
		};
}
