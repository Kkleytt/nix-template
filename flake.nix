{
  	description = "Автоматический сборщик системы от Kkleytt"; 
  	
  	inputs = {
		# Нестабильная ветка NixPkgs
  		nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

		# Установка Home-Manager
		home-manager = {
			url = "github:nix-community/home-manager";
			inputs.nixpkgs.follows = "nixpkgs";
		};

		# Установка WM Hyprland
		hyprland.url = "github:hyprwm/Hyprland";

		# Ссылка на установщик пакетов Flatpak
		nix-flatpak.url = "github:gmodena/nix-flatpak/?ref=v0.6.0";

		# Установка темы оформления Noctalia 
		quickshell = {
			url = "github:outfoxxed/quickshell";
			inputs.nixpkgs.follows = "nixpkgs";
		};
		noctalia = {
			url = "github:noctalia-dev/noctalia-shell";
			inputs.nixpkgs.follows = "nixpkgs";
			inputs.quickshell.follows = "quickshell";  # Use same quickshell version
		};
		caelestia-shell = {
			url = "github:caelestia-dots/shell";
			inputs.nixpkgs.follows = "nixpkgs";
		};

		# Ссылка на тему SDDM
		silentSDDM = {
			url = "github:uiriansan/SilentSDDM";
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
			config.allowUnfree = true;
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
					inputs.nix-flatpak.nixosModules.nix-flatpak
					./hosts/laptop/config.nix 
					./modules/quickshell.nix
					
					inputs.home-manager.nixosModules.home-manager
					{
						home-manager.useGlobalPkgs = true;
						home-manager.useUserPackages = true;
						home-manager.users.${username} = import ./hosts/laptop/home.nix;
					}
				];
			};
		};
	};
}
