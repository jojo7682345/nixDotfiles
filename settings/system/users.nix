{ 
	lib,
	pkgs,
	self,
	config,
	inputs,
	machine,
	systemStats,	
	... 
}:
let 
	inherit (lib) genAttrs;
in
{
	config.users.users = builtins.listToAttrs (map (user: {
		name = user.name;
		value = {
			isNormalUser = true;
			shell = if user.defaultShell =="zsh" then pkgs.zsh else pkgs.bash;
			extraGroups = [] ++ 
				(lib.optionals (
					user.hasNetworkAccess && machine.os.network.enableTui  
				) ["networkmanager"]) ++
				(lib.optionals (
					user.isAdmin
				) ["wheel"]);
		};
	}) machine.users);

	config.home-manager = {
		verbose = true;
		useUserPackages = true;
		useGlobalPkgs = true;
		backupFileExtension = "bak";
		
		users = builtins.listToAttrs (map (user: {
			name = user.name;
			value = {
				imports = (lib.optionals
					(lib.pathExists (self + "/home/${user.name}/default.nix")) 
					[ (self + "/home/${user.name}") ]
				);
				programs.zsh.enable = user.defaultShell == "zsh";
				home.stateVersion = "25.05";
				home.username = user.name;
				home.homeDirectory = "/home/${user.name}";
			};
		}) machine.users);

		extraSpecialArgs = {
			inherit
				self
				inputs
				machine
				systemStats;
		};
	};
}
