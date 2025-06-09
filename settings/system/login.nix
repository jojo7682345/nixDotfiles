{ config, lib, pkgs, ... }: {
	
	services.greetd = {
		enable = true;
		vt = 2;
		restart = true;
		settings = {
			default_session = {
				command = lib.concatStringsSep " " [
					(lib.getExe pkgs.greetd.tuigreet)
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
