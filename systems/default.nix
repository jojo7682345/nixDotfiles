{ lib, config, ... }:
let
	inherit (lib) mkOption types mkIf;


	# For each machine name, load the module and extract its `system` attribute
	getSystemForHost = hostname:
	let
		path = ./hosts + "/${hostname}.nix";
		rawModule = import path { inherit (inputs.nixpkgs) pkgs; };
	in
		"${rawModule.hardware.cpu.architecture}-linux"; # fallback if not defined
in {

	options.machines = mkOption{
		type = types.listOf types.str;
		default = [];
	};
	
	config.flake.nixosCofigurations = lib.genAttrs config.machines (hostname: 
		config.inputs.nixpkgs.lib.nixosSystem {
			options.machine = ./${hostname}.nix;
			in {
				system = "${machine.hardware.cpu.architecture}-linux";
				modules = [ ../flake ];
			}
		}
	);
}
