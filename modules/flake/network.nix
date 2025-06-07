{ lib, machine, inputs, ... }:
{
	networking = {
		hostname = machine.os.hostname;
		useDHCP = machine.os.network.useDHCP;
		wireless.enable = machine.hardware.misc.hasWifi&&machine.os.network.enableWifi;
		networkmanager.enable = machine.os.network.enableTui;

		firewall = {
			enabled = !machine.os.network.disabled;
			

			allowedTCPPorts = let
				tcpRules = lib.filter (rule: ((rule.type=="TCP") || (rule.type=="BOTH"))) machine.os.network.firewall.rules;
			in map (rule: rule.port) tcpRules;
			allowedUDPPorts = let
				udpRules = lib.filter (rule: ((rule.type=="UDP") || (rule.type="BOTH"))) machine.os.network.firewall.rules;
			in map (rule: rule.port) udpRules;
		};

	};
	time.timeZone = machine.os.time.timeZone;

	services.openssh.enable = machine.os.network.enableSshAccess;
	
}
