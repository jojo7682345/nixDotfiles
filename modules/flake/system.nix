{ inputs, pkgs, machine, lib, ...}:
{
	#minimal required packages
	environment.systemPackages = with pkgs; [
		wget
		git
	];


}
