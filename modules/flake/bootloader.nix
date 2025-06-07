{ inputs, lib, machine, ... }: 
	with machine;
{

	imports = [ 
		(modulesPath + "/installer/scan/not-detected.nix")
	];

	boot.loader = {
		systemd-boot.enable = os.bootloader.loader == "systemd";
		efi.canTouchEfiVariables = os.bootloader.canTouchEfiVariables;
	};

	boot.initrd.availableKernelModules = [] ++
		(lib.optionals hardware.storage!=[]||hardware.misc.allowRemovableStorage "sd_mod") ++
		(lib.optionals (lib.any (disk: disk.interface=="sata") hardware.storage) "ahci") ++
		(lib.optionals (lib.any (disk: disk.interface=="nvme") hardware.storage) "nvme") ++
		(lib.optionals (lib.any (disk: disk.interface=="usb") hardware.storage)||hardware.misc.allowRemovableStorage "usb_storage") ++
		(lib.optionals hardware.misc.usbPeripherals "usbhid" );
	boot.initrd.kernelModules = [];

	boot.kernelModules = [] ++
		(lib.optionals hardware.cpu.allowVirtualization "kvm-intel");
	boot.extraModulePackages = [];
}
