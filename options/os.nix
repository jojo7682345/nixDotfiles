{ lib}: with lib;
{
		hostname = mkOption {
			type = types.str;
			default = "nixos";
		};
		bootloader = {
			loader = mkOption {
				type = types.enum [ "systemd" "grub" ];
				default = "systemd";
				description = "bootloader";
			};
			canTouchEfiVariables = mkOption {
				type = types.bool;
				default = true;
			};
		};
		kernel = {
			#TODO: add kernel module stuff
		};
		time = {
			timezone = mkOption {
				type = types.str;
				default = "";
				description = "Timezone";
			};
		};
		input = {
		rules = mkOption {
				type = types.listOf (types.attrsOf types.str); # simple attribute sets
				default = [];
				example = [
					{ name = "99-rule1.rules"; content = "SUBSYSTEM==\"usb\", ATTR{idVendor}==\"1234\", MODE=\"0660\""; }
					{ name = "99-rule2.rules"; content = "SUBSYSTEM==\"usb\", ATTR{idVendor}==\"abcd\", MODE=\"0666\""; }
				];
			};
		};
		network = {
			useDHCP = mkOption {
				type = types.bool;
				default = true;
				description = "enables DHCP";
			};
			enableWifi = mkOption {
				type = types.bool;
				default = false;
			};
			enableTui = mkOption {
				type = types.bool;
				default = false;
				description = "Enables networkmanager";
			};
			enableSshAccess = mkOption {
				type = types.bool;
				default = false;
			};
			firewall = {
				disabled = mkOption {
					type = types.bool;
					default = false;
				};
				rules = mkOption {
					type = types.listOf (types.submodule {
						port = mkOption {
							type = types.ints.between 0 65535;
							default = 0;
						};
						type = mkOption {
							type = types.enum [ "TCP" "UDP" "BOTH" ];
							default = "TCP";
						};
					});
					default = [];
					description = "firewal rules";
				};
			};
		};
}
