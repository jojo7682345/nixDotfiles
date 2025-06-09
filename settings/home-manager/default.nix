{ lib, self, config, inputs, machine, systemStats, ... }: {

	home-manager = {
		verbose = true;
		useUserPackages = true;
		useGlobalPkgs = true;
		backupFileExtension = "bak";
		
		users = builtins.listToAttrs (map (user: {
			name = user.name;
			value = {
				imports = (lib.optionals
					(lib.pathExists (self + /home/${user.name}/default.nix))
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
