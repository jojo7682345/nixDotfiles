{ lib, options, ... }: with lib;
{ options.system = {
	os = {
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
	};
	hardware = {
		displays = mkOption {
			type = types.listOf (types.submodule { options = {
				port = mkOption {
					type = types.str;
					default = "";
					description = "Port the desplay is on such as eDP-1";
				};
				width = mkOption {
					type = types.ints.between 640 7680;
					default = 1920;
					description = "Screen resolution width in pixels.";
				};
				height = mkOption {
					type = types.ints.between 480 4320;
					default = 1080;
					description = "Screen resolution height in pixels.";
				};
				dpi = mkOption {
					type = types.float;
					default = 1.0;
					description = "Monitor dpi";
				};
				position = {
					x = mkOption {
						type = types.int;
						default = 0;
						description = "X position of display";
					};
					y = mkOption {
						type = types.int;
						default = 0;
						description = "Y position of display";
					};
				};
			};});
			default = [];
			description = "List of monitors";
		};
		cpu = {
			cores = mkOption {
				type = types.ints.positive;
				default = 1;
				description = "Number of cpu cores";
			};
			architecture = mkOption {
				type = types.enum [ "x86_64" "aarch64" "ricv64" ];
				default = "x86_64";
				description = "The cpu architecture";
			};
			vendor = mkOption {
				type = types.enum [ "intel" "amd" ];
				default = "amd";
				description = "The cpu vendor";
			};
			updateMicrocode = mkOption {
				type = types.bool;
				default = true;
				description = "Update microcode";
			};
			allowVirtualization = mkOption {
				type = types.bool;
				default = false;
				description = "Allows hardware virtualization";
			};
		};
		gpu = mkOption {
			type = types.listOf (types.submodule {options={
				vendor = mkOption {
        				type = types.enum [ "nvidia" "amd" "intel" "none" ];
        				default = "none";
        				description = "GPU vendor.";
      				};
      				model = mkOption {
        				type = types.str;
        				default = "";
        				description = "Optional GPU model name.";
      				};
      				vramMiB = mkOption {
        				type = types.ints.positive;
       	 				default = 0;
      	  				description = "Amount of GPU VRAM in MiB.";
     	 			};
     	 			headless = mkOption {
      	  				type = types.bool;
      	  				default = false;
      	  				description = "Whether the GPU is used without a display.";
     	 			};
     	 			enableCUDA = mkOption {
      	  				type = types.bool;
        				default = false;
        				description = "Enable CUDA support (for NVIDIA GPUs).";
      				};
			};});
			default = [];
			description = "List of GPUs";
		};
		ram = {
			sizeMiB = mkOption {
				type = types.ints.positive;
				default = 0;
				description = "size of ram in MiB"; 
			};
		};
		misc = {
			hasBluetooth = mkOption {
				type = types.bool;
				default = false;
				description = "Has bluetooth";
			};
			hasTPM = mkOption {
				type = types.bool;
				default = false;
				description = "Has tpm";
			};
			hasWifi = mkOption {
				type = types.bool;
				default = false;
				description = "Has wifi";
			};
			usb3ports = mkOption {
				type = types.ints.positives;
				default = 1;
				description = "Number of usb3 ports, defautls to 1 to enable the usb kernel module";
			};
			usbPeripherals = mkOption {
				type = types.bool;
				default = true;
				description = "Enable usb peripherals, only disable when you know what you are doing";
			};
			allowRemovableStorage = mkOption {
				type = types.bool;
				default = true;
				description = "load the usb storage kernel module";
			};
		};
		storage = mkOption {
			type = types.listOf (types.submodule { options={
				type = mkOption {
					type = types.enum [ "ssd" "hdd" "flash" ];
					default = "ssd";
					description = "Storage type";
				};
				interface = mkOption {
					type = types.enum ["sata" "nvme" "usb" ];
					description = "Storage interface";
				};
				sizeGiB = mkOption {
					type = types.ints.positive;
					default = 128;
					description = "Disk size in GiB.";
				};
				partitions = mkOption {
					type = types.listOf (types.submodule { options={
						type = mkOption {
							type = types.enum [ "boot" "swap" "default" ];
							default = "default";
							description = "partition type";
						};						
						fileSystem = mkOption {
							type = types.enum [ "ext4" "btrfs" "xfs" "vfat" "ntfs" "none"];
							default = "none";
							description = "filesystem type (ignored for swap type partitions)";
						};
						sizeGiB = mkOption {
							type = types.ints.positive;
							default = 0;
							description = "size of partition in GiB";
						};
						mountPoint = mkOption {
							type = types.str;
							description = "Mount point of partition (ignored for swap type partitions)";
						};
						label = mkOption {
							type = types.str;
							default = "";
							description = "Partition label (ignored if uid is provided)";
						};
						uid = mkOption {
							type = types.nullOr types.str;
							default = null;
							description = "partition uid";
						};
						options = mkOption {
							type = types.listOf( types.str );
							default = [];
							description = "disk options such as fmaks and dmask";
						};

					};});
					default = [];
					description = "List of partitions";
				};
			};});
			default = [];
			description = "List of disks";
		};
	};	
};
}
