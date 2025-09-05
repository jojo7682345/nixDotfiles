{ lib, pkgs, inputs', config, ...} : {

	imports = [ ./config ];

	wayland.windowManager.hyprland = {
		enable = true;
		xwayland.enable = true;

		systemd = {
			enable = true;
			variables = [ "--all" ];
			extraCommands = [
				"systemctl --user stop graphical-session.target"
				"systemctl --user start hyprland-session.target"
			];
		};
	};
}