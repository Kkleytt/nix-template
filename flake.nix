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

		# Установка темы оформления Caelestia shell 
		quickshell = {
			url = "github:outfoxxed/quickshell";
			inputs.nixpkgs.follows = "nixpkgs";
		};
		caelestia-shell = {
			url = "github:caelestia-dots/shell";
			inputs.nixpkgs.follows = "nixpkgs";
		};
		caelestia-cli = {
			url = "github:caelestia-dots/cli";
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
		host = "mobile";
		username = "kkleytt";
		
		pkgs = import nixpkgs {
			inherit system;
			config = {
				allowUnfree = true;
				permittedInsecurePackages = [ 
					"libsoup-2.74.3" 
				];
			};
		};
	in {
		nixosConfigurations = {
			laptop = nixpkgs.lib.nixosSystem rec {
				specialArgs = { inherit inputs system username host; };
				modules = [ 
					# (import "${nixpkgs}/nixos/modules/misc/nixpkgs/read-only.nix")
					{ nixpkgs.pkgs = pkgs; }
					inputs.nix-flatpak.nixosModules.nix-flatpak
					inputs.home-manager.nixosModules.home-manager
					./hosts/${host}/config.nix 
					./modules/quickshell.nix
					{
						home-manager.useGlobalPkgs = true;
						home-manager.useUserPackages = true;
						home-manager.users.${username} = import ./hosts/${host}/home.nix {
          					inherit inputs pkgs;
        				};
					}
				];
			};
		};
	};
}