{ lib, options, ... }: with lib;
{ options.system = {
	os = import ./os.nix;
	hardware = import ./hardware.nix;	
};
}
