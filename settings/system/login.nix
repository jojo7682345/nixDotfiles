{ config, lib, pkgs, ... }: let
	sessionData = config.services.displayManager.sessionData.desktops;
	sessionPath = lib.concatStringsSep ":" [
		"${sessionData}/share/xsessions"
    	"${sessionData}/share/wayland-sessions"
	];
in {
	
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
					"--session '${sessionPath}'"
				];
			};
		};
	};

}
