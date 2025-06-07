{ inputs, machine, lib, ... }:
{


	nixpkgs.config.allowUnfree = true;
	nix.settings.experimental-features = [ "nix-command" "flakes" ];
}
