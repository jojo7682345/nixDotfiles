{
	bootloader = {
		loader = "systemd";
		canTouchEfiVariables = true;
	};
	network = {
		enableWifi = true;
		enableTui = true;
		enableSshAccess = true;
		firewall = {
			disabled = true;
		};
	};
	time = {
		timezone = "Europe/Amsterdam";
	};
}
