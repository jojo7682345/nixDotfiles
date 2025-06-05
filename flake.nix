{
	description = "Flake";
	
	outputs = inputs: inputs.flake-parts.lib.mkFlake { inherit inputs; }{
		imports = [ ./systems ];
	}; 

	inputs = {
		nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
		
		flake-parts = {
			type = "github";
			owner = "hercules-ci";
			repo = "flake-parts";
			inputs.nixpkgs-lib.follows = "nixpkgs";
		};
	};
}
