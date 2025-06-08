{ lib, options, ... }: with lib;
{ options.system = {
	os = (import ./os.nix { inherit lib; });
	hardware = (import ./hardware.nix { inherit lib; });	
};
}
