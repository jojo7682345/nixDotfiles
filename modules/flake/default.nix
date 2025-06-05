{ inputs, lib, ... }: 
let
	inherit (lib.modules) mkIf;
in
{
	options = {
		
	};

	config = {
		boot.loader = {
			systemd-boot.enable = machine.os.bootloader.loader == "systemd";
			efi.canTouchEfiVariables = machine.os.bootloader.canTouchEfiVariables;
		};
		
		
		
	
	};	
}
