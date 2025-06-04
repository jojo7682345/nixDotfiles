{ 
	imports = [ ./hardware-store.nix ];
	
	hardware = {
		display = [{
			width = 1920;
			height = 1080;
			dpi = 1.0;
			port = "HDMI-A-1";	
		}];
		cpu = {
			cores = 8;
			architecture = "x86_64";
			vendor = "Intel";
		};
		gpu = {
		
		};
	};
}
