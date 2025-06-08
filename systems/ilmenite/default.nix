{config, lib, pkgs, ... }: { 
	imports = [
		../../hardware/hardware-store.nix
	];
	
	config.system = {
		os = {
			hostname = "ilmenite";
		} // import ./os.nix;
		hardware = {
		
		} // import ./hardware.nix;
	};
}
