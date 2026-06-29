{ lib, inputs, pkgs, machine, ... } : {
	
    hardware.bluetooth = if machine.hardware.misc.hasBluetooth then {
        enable = true;
        powerOnBoot = true;
    } else {
        enable = false;
    };
	
    # Optional: Install bluez-tools if bluetoothctl is missing 
    environment.systemPackages = with pkgs; [
        bluez
        bluez-tools
    ];

}
