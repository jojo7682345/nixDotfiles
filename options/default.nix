{ lib, options, ... }: with lib;
{ 
	options.system = {
		os = (import ./os.nix { inherit lib; });
		hardware = (import ./hardware.nix { inherit lib; });	
		
		name = mkOption {
			type = types.str;
		};

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
				defaultShell = mkOption {
					type = types.enum [ "bash" "zsh" ];
					default = "bash";
				};
				additionalGroups = mkOption {
					type = types.listOf(types.str);
					default = [];
				};
	
			};});
			default = [];
			description = "List of users";
		};

		steam = {
			enable = mkOption {
				type = types.bool;
				default = false;
			};
		};
		navidrome = {
			enable = mkOption {
				type = types.bool;
				default = false;
			};
			musicFolder = mkOption {
				type = types.str;
			};
			address = mkOption {
				type = types.str;
				default = "127.0.0.1";
			};
			port = mkOption {
				type = types.ints.u16;
				default = 4533;
			};
		};
	};
}
