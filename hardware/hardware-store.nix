{ lib, config, ... }:

with lib;
{
	system.hardware = {
		displays = mkOption {
			type = types.listOf (types.submodule {
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
			});
			default = [];
			description = "List of monitors";
		};
		cpu = {
			numCores = mkOption {
				type = types.ints.positive;
				default = 4;
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
		};
		gpu = mkOption {
			type = types.listOf (types.submodule {
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
      				vramMB = mkOption {
        				type = types.ints.positive;
       	 				default = 0;
      	  				description = "Amount of GPU VRAM in MB.";
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
			});
			default = [];
			description = "List of GPUs";
		};
	};	
}
