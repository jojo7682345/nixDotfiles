{
	inherit machine;
	inherit lib;

	storageCapabilties = let storage = machine.hardware.storage; in {
		hasSataDrive = (lib.any (disk: disk.interface=="sata") storage);
		hasNvmeDrive = (lib.any (disk: disk.interface=="nvme") storage);
		hasUsbDrive = (lib.any (disk: disk.interface=="usb") storage);
		hasStorage = storage!=[]||machine.hardware.misc.allowRemovableStorage;
	};

	gpuCapabilities = let gpu = machine.hardware.gpu; in {
		hasGraphical = (lib.any (gpu: !gpu.headless) gpu);
		hasCuda = (lib.any (gpu: gpu.enableCuda) gpu);
	};


}
