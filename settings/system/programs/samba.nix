{ lib, machine, inputs, pkgs, ... }: {
    environment.systemPackages = [ pkgs.cifs-utils ];

    boot.supportedFilesystems = ["cifs"];

    security.wrappers."mount.cifs" = {
        program = "mount.cifs";
        source = "${lib.getBin pkgs.cifs-utils}/bin/mount.cifs";
        owner = "root";
        group = "root";
        setuid = true;
    };

    #fileSystems.
	
}
