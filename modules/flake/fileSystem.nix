{ lib, machine, ... }:
let
	inherit (lib.attrsets) genAttrs;
in
{

	fileSystems = let
		allPartitions = lib.concatMap (disk: disk.partitions) machine.hardware.storage;
		mounted = lib.filter (p : p.type != "swap") allPartitions;
	in lib.listToAttrs (map (p: {
		name = p.mountPoint;
		value = {
			device = let 
				diskIdentifier = if p.uid == null then "by-uuid/${p.uid}" else "by-label/${p.label}";
			in "/dev/disk/${diskIdentifier}";
			fsType = p.fileSystem;
		} // lib.optionalAttrs (p.options != []) {
			options = p.options;
		};
	}) mounted);
	
	swapDevices = let
		allPartitions = lib.concatMap (disk: disk.partitions) machine.hardware.storage;
		swaps = lib.filter (p: p.type == "swap") allPartitions;
	in map (p: {
		device = let
			diskIdentifier = if p.uid == null then "by-uuid/${p.uid}" else "by-label/${p.label}";
		in "/dev/disk/${diskIdentifier}";
	}) swaps;


}
