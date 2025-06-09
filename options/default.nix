{ lib, options, ... }: with lib;
{ 
	options.system = {
		os = (import ./os.nix { inherit lib; });
		hardware = (import ./hardware.nix { inherit lib; });	
		

		users = mkOption {
			type = types.listOf( types.submodule { options = {
				
				name = mkOption {
					type = types.str;
				};
				
				hasNetworkAccess = mkOption {
					type = types.bool;
					default = false;
				};
				isAdmin = mkOption {
					type = types.bool;
					default = false;
				};
	
			};});
			default = [];
			description = "List of users";
		};
	};
}
