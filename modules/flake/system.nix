{ inputs, pkgs, machine, lib, ...}:
{
	#minimal required packages
	environment.systemPackages = with pkgs; [
		wget
		git
	];

	i18n.defaultLocale = "en_US.UTF-8";


}
