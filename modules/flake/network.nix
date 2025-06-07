{ lib, machine, inputs, ... }:
{
	networking = {
		hostName = machine.os.hostname;
		useDHCP = lib.mkDefault machine.os.network.useDHCP;
		wireless.enable = machine.hardware.misc.hasWifi&&machine.os.network.enableWifi&&!machine.os.network.enableTui;
		networkmanager.enable = machine.os.network.enableTui;

		firewall = {
			enable = !machine.os.network.firewall.disabled;
			

			allowedTCPPorts = let
				tcpRules = lib.filter (rule: ((rule.type=="TCP") || (rule.type=="BOTH"))) machine.os.network.firewall.rules;
			in map (rule: rule.port) tcpRules;
			allowedUDPPorts = let
				udpRules = lib.filter (rule: ((rule.type=="UDP") || (rule.type=="BOTH"))) machine.os.network.firewall.rules;
			in map (rule: rule.port) udpRules;
		};

	};
	time.timeZone = machine.os.time.timezone;

	services.openssh.enable = machine.os.network.enableSshAccess;
	
}
