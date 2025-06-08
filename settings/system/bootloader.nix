{ lib, machine, modulesPath, systemStats, ... }: 
	with machine;
{

	imports = [ 
		(modulesPath + "/installer/scan/not-detected.nix")
	];

	boot.loader = {
		systemd-boot.enable = os.bootloader.loader == "systemd";
		efi.canTouchEfiVariables = os.bootloader.canTouchEfiVariables;
	};

	boot.initrd.availableKernelModules = let
		caps = systemStats.storageCapabilities;
	in [] ++
		(lib.optionals caps.hasStorage ["sd_mod"]) ++
		(lib.optionals caps.hasSataDrive ["ahci"]) ++
		(lib.optionals caps.hasNvmeDrive ["nvme"]) ++
		(lib.optionals (caps.hasUsbDrive||hardware.misc.allowRemovableStorage) ["usb_storage"]) ++
		(lib.optionals hardware.misc.usbPeripherals ["usbhid"] );
	boot.initrd.kernelModules = [];

	boot.kernelModules = [] ++
		(lib.optionals hardware.cpu.allowVirtualization ["kvm-intel"]);
	boot.extraModulePackages = [];
}
