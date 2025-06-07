{ inputs, machine, lib, ... }:
{


	users.users.dms = {
		isNormalUser = true;
		description = "dms";
		extraGroups = [ "networkmanager" "wheel"];
		packages = with pkgs; [];
	};


}
