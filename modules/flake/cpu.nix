{ lib, input, machine, ... } : {
	
	hardware.cpu = {
		
	}// if machine.hardware.cpu.vendor=="intel" then {
		intel = {
			updateMicrocode = machine.hardware.cpu.updateMicrocode;
		}; 
	} else if machine.hardware.cpu.vendor=="amd" then {
		amd = {
			updateMicrocode = machine.hardware.cpu.updateMicrocode;
		};
	}

}
