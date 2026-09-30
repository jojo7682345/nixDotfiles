{ inputs, lib, machine, ... }: 
{
	imports = [] 
        ++ (lib.optionals ( machine.steam.enable ) [ ./steam.nix ])
        ++ (lib.optionals ( machine.navidrome.enable ) [ ./navidrome.nix ])
    ;
}
