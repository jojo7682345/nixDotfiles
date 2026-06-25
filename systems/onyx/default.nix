{config, lib, pkgs, ... }: { 
	imports = [
		../../options
	];
	
	config.system = {
		os = {
			hostname = "onyx";
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
