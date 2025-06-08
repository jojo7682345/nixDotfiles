{ 
	lib,
	self,
	self',
	config,
	inputs,
	inputs',
	machine,
	systemStats,	
	... 
}:
let 
	inherit (lib) genAttrs;
in
{

	users.users = builtins.listToAttrs (map (user: {
		name = user.name;
		value = {
			isNormalUser = true;
			extraGroups = [] ++ 
				(lib.optionals (
					user.hasNetworkAccess && machine.os.network.enableTui  
				) "networkmanager") ++
				(lib.optionals (
					user.isAdmin
				) "wheel");
		};
	}) machine.users);
	home-manager = {
		verbose = true;
		useUserPackages = true;
		useGlobalPkgs = true;
		backupFileExtension = "bak";
		
		users = builtins.listToAttrs (map (user: {
			name = user.name;
			value = {
				imports = (lib.optionals
					(builtins.pathExists "${self}/home/${user.name}") 
					[ "${self}/home/${user.name}" ]
				);
				home.stateVersion = "25.05";
				home.username = user.name;
				home.homeDirectory = "/home/${user.name}";
			};
		}) machine.users);

		extraSpecialArgs = {
			inherit
				self
				self'
				inputs
				inputs'
				machine
				systemStats
			;
		};
	};
}
