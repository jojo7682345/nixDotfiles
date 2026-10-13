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
				content = "KERNEL==\"event*\", MODE=\"660\", GROUP=\"input\"\nKERNEL==\"uinput\", MODE=\"660\", GROUP=\"input\"\n";
			}
			{
				name = "99-usb.rules";
				content = ''
						SUBSYSTEM=="usb", ATTRS{idVendor}=="2e3c", ATTRS{idProduct}=="df11", MODE="0664", GROUP="dialout"
						SUBSYSTEM=="usb", ATTRS{idVendor}=="0483", ATTRS{idProduct}=="df11", MODE="0664", GROUP="dialout"
				'';
			}
		];
	};
}
