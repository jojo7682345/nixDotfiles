{ inputs, lib, machine, ... }: 
{
	imports = [
		./fileSystem.nix
		./bootloader.nix
		./network.nix
		./cpu.nix
		./system.nix
		./nix.nix
		./users.nix
		./login.nix
	];
	nixpkgs.hostPlatform = lib.mkDefault "${machine.hardware.cpu.architecture}-linux";
	system.stateVersion = "25.05";

}
