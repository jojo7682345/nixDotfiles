{ inputs, lib, machine, ... }: 
{
	imports = [
		./fileSystem.nix
		./bootloader.nix
	];
	system.stateVersion = "25.05";

}
