{ lib, pkgs, inputs', config, ...} : let
	hyprConfigDir = ./config;
	hyprLuaFiles = builtins.readDir hyprConfigDir;

	hyprConfigFiles = lib.mapAttrs'
		(name: type:
			lib.nameValuePair "hypr/${name}"{
				source = hyprConfigDir + "/${name}";
			}
		)
		(lib.filterAttrs
			(name: type:
				type == "regular" 
				&& lib.hasSuffix ".lua" name
				&& name != "config.lua"
				&& name != "loader.lua"
			)
			hyprLuaFiles
		);
in {

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

	xdg.configFile = hyprConfigFiles;
}