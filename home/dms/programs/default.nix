{ lib, pkgs, inputs', config, ...} : {

    imports = [
        ./hyprland
        ./waybar
        ./walker
    ];

}