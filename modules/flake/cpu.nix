{ lib, input, machine, ... } : {
	
	hardware.cpu = lib.mkMerge[ 
	(lib.mkIf (machine.hardware.cpu.vendor=="intel") {
		intel = {
			updateMicrocode = machine.hardware.cpu.updateMicrocode;
		}; 
	}) 
	(lib.mkIf (machine.hardware.cpu.vendor=="amd") {
		amd = {
			updateMicrocode = machine.hardware.cpu.updateMicrocode;
		};
	})];

}
