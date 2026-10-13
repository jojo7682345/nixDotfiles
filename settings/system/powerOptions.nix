{ lib, config, machine, pkgs, ... }:{
	services = {
		logind.settings.Login = {
			HandleLidSwitch = "suspend";
			HandleLidSwitchExternalPower = "ignore";
			HandleLidSwitchDocked = "ignore";
		};
        power-profiles-daemon = {
            enable = true;
        };
	};
}
