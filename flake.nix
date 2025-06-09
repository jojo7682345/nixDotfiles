{
	description = "Flake";
	
	outputs = { self, nixpkgs, ...}@inputs: 
	let
		hostDirs = builtins.filter
			(name: builtins.pathExists (./systems + "/${name}/default.nix"))
			(builtins.attrNames (builtins.readDir ./systems));
		hosts = builtins.listToAttrs ( map (filename:
		let 
			
			machine = (nixpkgs.lib.evalModules {
				modules = [./systems/${filename}/default.nix];
			}).config.system;
			systemStats = (import ./util/systemStats.nix { inherit machine; inherit (nixpkgs) lib; });	
		in {
			name = nixpkgs.lib.strings.removeSuffix ".nix" filename;
			value = nixpkgs.lib.nixosSystem {
				system = "${machine.hardware.cpu.architecture}-linux";
				specialArgs = { 
					inherit inputs machine self systemStats; 
					home-manager = inputs.home-manager;
				};
				modules = [ 
					./settings/system 
					inputs.home-manager.nixosModules.home-manager
				];
			};
		}) hostDirs);
	in {
			nixosConfigurations = hosts;
	
	};	


	inputs = {
		nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
		
		lix = {
			url = "https://git.lix.systems/lix-project/lix/archive/main.tar.gz";
			inputs = {
				nixpkgs.follows = "nixpkgs";
				pre-commit-hooks.follows = "";
				nix2container.follows = "";
				flake-compat.follows = "";
			};
		};
		
		home-manager = {
			type = "github";
			owner = "nix-community";
			repo = "home-manager";
			ref = "pull/4976/merge";
			inputs.nixpkgs.follows = "nixpkgs";
		};

	};
}
