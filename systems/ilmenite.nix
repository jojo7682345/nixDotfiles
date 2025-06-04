{ 
	imports = [
		../hardware/hardware-store.nix
	];

	hardware = {
		diplays = [{
			width = 1920;
			height = 1080;
			dpi = 1.0;
			port = "HDMI-A-1";
		}];		
		cpu = {
			architecture = "x86_64";
			vendor = "Intel";
			cores = 8;
		};
		gpu = [{
			vendor = "intel";
			model = "UHD 620";
			vramMB = 128;
			headless = false;
			enableCUDA = false;
		}];
	
	};
