{
	description = "Flake";
	
	outputs = { self, nixpkgs, ...}@inputs: 
	let
		hostFiles = builtins.attrNames (builtins.readDir ./systems);
		hosts = builtins.listToAttrs ( map (filename:
		let 
			
			machine = (nixpkgs.lib.evalModules {
				modules = [./systems/${filename}];
			}).config.system;
		in {
			name = nixpkgs.lib.strings.removeSuffix ".nix" filename;
			value = nixpkgs.lib.nixosSystem {
				system = "${machine.hardware.cpu.architecture}-linux";
				specialArgs = { inherit machine; };
				modules = [ ./modules/flake ];
			};
		}) (builtins.filter (f: f != "default.nix" && nixpkgs.lib.hasSuffix ".nix" f) hostFiles));
	in {
			nixosConfiguration = hosts;
	
	};	


	inputs = {
		nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
		
	};
}
