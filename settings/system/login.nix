{ config, lib, pkgs, ... }: {
	
	services.greetd = {
		enable = true;
		vt = 2;
		restart = true;
		settings = {
			default_session = {
				command = lib.concatStringSep " " [
					(lib.getExe pkg.greetd tuigreet)
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
