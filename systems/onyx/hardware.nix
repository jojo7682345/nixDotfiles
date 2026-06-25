{
	displays = [{
		width = 2560;
		height = 1440;
		dpi = 1.25;
		port = "eDP-2";
	}];		
	cpu = {
		architecture = "x86_64";
		vendor = "amd";
		cores = 24;
		updateMicrocode = true;
	};
	gpu = [{
		vendor = "nvidia";
		model = "AD106M [GeForce RTX 4070 Max-Q / Mobile]";
		vramMiB = 8188;
		headless = false;
		enableCUDA = true;
	},{
		vendor = "amd";
		model = "Raphael";
		headless = false;
	}];
	ram = {
		sizeMiB = 32034;
	};
	misc = {
		hasBluetooth = true;
		hasWifi = true;
		usb3ports = 2;
	};
	storage = [{
		type = "ssd";
		interface = "nvme";
		sizeGiB = 4096;
		partitions = [{
			type = "boot";
			fileSystem = "fat32";
			sizeGiB = 1;
			mountPoint = "/boot";
			uid = "709D-2300"; 			
			options = [ "fmask=0077" "dmask=0077" ];
		} {
			fileSystem = "ext4";
			sizeGiB = 528;
			mountPoint = "/";
			uid = "db7fcfe5-3ee9-46a8-9a1f-7b9586361819";
		} {
			type = "swap";
			sizeGiB = 16;
			uid = "63d13911-8607-4114-9ccd-38c5f1a44f13";
		}];
	},{
		
	}];
}
