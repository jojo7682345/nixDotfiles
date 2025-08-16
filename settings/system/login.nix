{ config, lib, pkgs, ... }: {
	
	services.greetd = {
		enable = true;
		restart = true;
		settings = {
			default_session = {
				command = lib.concatStringsSep " " [
					(lib.getExe pkgs.tuigreet)
					"--time"
					"--remember"
					"--remember-user-session"
					"--asterisks"
					#"--session '${sessionPath}'"
				];
			};
		};
	};

}
