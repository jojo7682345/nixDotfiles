{config, lib, pkgs, ... }: { 
	imports = [
		../../options/hardware-store.nix
	];
	
	config.system = {
		os = {
			hostname = "ilmenite";
		} // import ./os.nix;
		hardware = {
		
		} // import ./hardware.nix;
	};
}
