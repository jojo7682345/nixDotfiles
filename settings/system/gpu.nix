{ lib, machine, inputs, pkgs, ... }:
{
	hardware.graphics = {
        enable = true;
    };

    services.xserver.videoDrivers = [ "nvidia" ];

    hardware.nvidia = {
        # Ada Lovelace supports the open kernel modules.
        open = true;

        # Required for proper Wayland support.
        modesetting.enable = true;

        # Start conservative; we can tune power management later.
        powerManagement.enable = false;
        powerManagement.finegrained = false;

        nvidiaSettings = true;

        prime = {
            offload.enable = true;
            offload.enableOffloadCmd = true;

            amdgpuBusId = "PCI:9:0:0";
            nvidiaBusId = "PCI:1:0:0";
        };
    };
	environment.systemPackages = with pkgs; [
        mesa-demos
    ];
}
