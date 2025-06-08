{
	bootloader = {
		loader = "systemd";
		canTouchEfiVariables = true;
	};
	network = {
		enableWifi = true;
		enableTui = true;
		enableSshAccess = true;
	};
	time = {
		timezone = "Europe/Amsterdam";
	};
}
