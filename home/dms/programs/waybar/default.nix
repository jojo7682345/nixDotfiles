{ lib, pkgs, inputs', config, ...} : {

    programs.waybar = {
        enable = true;

        settings = {
            main = builtins.fromJSON (builtins.readFile ./config.jsonc);
        };

        style = builtins.readFile ./style.css;
    };

}