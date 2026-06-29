{config, lib, pkgs, ... }: { 
	imports = [
		../../options
	];
	
	config.system = {
		name = "ilmenite";
		
		os = {
			hostname = "ilmenite";
		} // import ./os.nix;
		hardware = {
		
		} // import ./hardware.nix;
		users = [{
			name = "dms";
			hasNetworkAccess = true;
			isAdmin = true;
			defaultShell = "zsh";
			additionalGroups = [
				"input"
			];
		}];	
	};
}
