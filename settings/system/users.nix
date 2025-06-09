{ lib, config, machine, pkgs, ... }:{
	users.users = builtins.listToAttrs (map (user: {
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
	programs.zsh.enable = (lib.any (user: user.defaultShell == "zsh") machine.users);
}
