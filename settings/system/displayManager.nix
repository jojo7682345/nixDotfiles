{ inputs, pkgs, machine, lib, systemStats, ...}: {
	programs.hyprland = if systemStats.displayCapabilities.hasDisplay then {
		enable = true;
		package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
		portalPackage = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;
	} else {
		enable = false;
	};
}