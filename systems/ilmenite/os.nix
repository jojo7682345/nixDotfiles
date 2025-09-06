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
	input = {
		rules = [
			{
				name = "99-input.rules";
				content = ''				
					KERNEL=="event*", MODE="660", GROUP="input"
					KERNEL=="uinput", MODE="660", GROUP="input"
				''; 
			}
		];
	}
}
