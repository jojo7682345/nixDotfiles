{ lib, pkgs, inputs', config, ...} : {

	wayland.windowManager.hyprland = {
		enable = true;
		xwayland.enable = true;
		configType = "lua";
		systemd = {
			enable = true;
			variables = [ "--all" ];
			extraCommands = [
				"systemctl --user stop graphical-session.target"
				"systemctl --user start hyprland-session.target"
			];
		};
		extraLuaFiles = {
			config = ./config/loader.lua;
		};
	};
}