{ lib, machine, inputs, pkgs, ... }: {
    services.navidrome = {
        enable = true;

        settings = {
            MusicFolder = machine.navidrome.musicFolder;
            Address = machine.navidrome.address;
            Port = machine.navidrome.port;
        };
    };

    environment.systemPackages = with pkgs; [
        ffmpeg
    ];
	
}
