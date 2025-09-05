{
	wayland.windowManager.hyprland.settings = {
		general = {
			layout = "master";

			gaps_in = 8;
			gaps_out = 16;
			gaps_workspaces = 0;
			border_size = 2;
			no_border_on_floating = false;
		};
		monitor = [
			"HEADLESS-1,1920x1080@60,0x0,1"
		];
	
		bind = [
			"SUPER, RETURN, exec, alacritty"
			"SUPER, Q, killactive"
			"SUPER SHIFT, R, exec, hyprctl reload"
		];
	};
}