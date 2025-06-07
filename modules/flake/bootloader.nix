{ lib, machine, modulesPath, ... }: 
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
		hasSataDrive = (lib.any (disk: disk.interface=="sata") hardware.storage);
		hasNvmeDrive = (lib.any (disk: disk.interface=="nvme") hardware.storage);
		hasUsbDrive = (lib.any (disk: disk.interface=="usb") hardware.storage);
		hasStorage = hardware.storage!=[]||hardware.misc.allowRemovableStorage;
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
