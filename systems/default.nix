{ lib, config, ... }:
let
	inherit (lib) mkOption types mkIf;
in {

	options.machines = mkOption{
		type = types.listOf types.str;
		default = [];
	};
	
	config.flake.nixosCofigurations = lib.genAttrs config.machines (hostname: 
		config.inputs.nixpkgs.lib.nixosSystem {
			let machine = import ./${hostname}.nix;
			system = "${machine.hardware.cpu.architecture}-linux";
			modules = [ ../flake ];
		}
	);
}
