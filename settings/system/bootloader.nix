{ lib, machine, modulesPath, systemStats, ... }: 
	with machine;
	with systemStats;
{

	imports = [ 
		(modulesPath + "/installer/scan/not-detected.nix")
	];

	boot.loader = {
		systemd-boot.enable = os.bootloader.loader == "systemd";
		efi.canTouchEfiVariables = os.bootloader.canTouchEfiVariables;
	};

	boot.initrd.availableKernelModules = let
	in [] ++
		(lib.optionals hasStorage ["sd_mod"]) ++
		(lib.optionals hasSataDrive ["ahci"]) ++
		(lib.optionals hasNvmeDrive ["nvme"]) ++
		(lib.optionals (hasUsbDrive||hardware.misc.allowRemovableStorage) ["usb_storage"]) ++
		(lib.optionals hardware.misc.usbPeripherals ["usbhid"] );
	boot.initrd.kernelModules = [];

	boot.kernelModules = [] ++
		(lib.optionals hardware.cpu.allowVirtualization ["kvm-intel"]);
	boot.extraModulePackages = [];
}
