{ lib, machine, ... }:
let
	inherit (lib.attrsets) genAttrs;
	allPartitions = lib.concatMap (disk: disk.partitions) machine.hardware.storage;
	mounted = lib.filter (p : p.type != "swap") allPartitions;

	deviceFor = p: let
      diskIdentifier =
        if p.uid != null
        then "by-uuid/${p.uid}"
        else "by-label/${p.label}";
    in "/dev/disk/${diskIdentifier}";
in
{

	fileSystems = lib.listToAttrs (map (p: {
		name = p.mountPoint;
		value = {
			device = deviceFor p;
			fsType = p.fileSystem;
		} // lib.optionalAttrs (p.options != []) {
			options = p.options;
		};
	}) mounted);

	systemd.tmpfiles.rules = map (p:
		"d ${p.mountPoint} 0755 root root -"
	) mounted;
	
	swapDevices = map (p: {
		device = deviceFor p;
	}) (lib.filter (p: p.type == "swap") allPartitions);


}
