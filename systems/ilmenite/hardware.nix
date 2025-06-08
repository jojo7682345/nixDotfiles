{
	displays = [{
		width = 1920;
		height = 1080;
		dpi = 1.0;
		port = "HDMI-A-1";
	}];		
	cpu = {
		architecture = "x86_64";
		vendor = "intel";
		cores = 8;
		updateMicrocode = true;
	};
	gpu = [{
		vendor = "intel";
		model = "UHD 630";
		vramMiB = 65536;
		headless = false;
		enableCUDA = false;
	}];
	ram = {
		sizeMiB = 8192;
	};
	misc = {
		hasBluetooth = true;
		hasWifi = true;
		usb3ports = 1;
	};
	storage = [{
		type = "ssd";
		interface = "nvme";
		sizeGiB = 2048;
		partitions = [{
			type = "boot";
			fileSystem = "vfat";
			sizeGiB = 1;
			mountPoint = "/boot";
			uid = "81F1-1275"; 			
			options = [ "fmask=0077" "dmask=0077" ];
		} {
			fileSystem = "ext4";
			sizeGiB = 2039;
			mountPoint = "/";
			uid = "e739f244-cbb3-4c07-9290-6ccd8c8db809";
		} {
			type = "swap";
			sizeGiB = 8;
			uid = "55f82cb7-adc2-4258-969d-dc4b28216efb";
		}];
	}];
}
