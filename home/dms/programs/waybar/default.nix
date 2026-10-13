{ lib, pkgs, inputs', config, ...} : {

    programs.waybar = {
        enable = true;

        settings = {
            main = (builtins.fromJSON (builtins.readFile ./config.jsonc)) // {
                "custom/power-profile" = {
                    exec = pkgs.writeShellScript "waybar-power-profile" ''
                        profile="$(${pkgs.power-profiles-daemon}/bin/powerprofilesctl get)"

                        case "$profile" in
                        power-saver)   label="󰾆" ;;
                        balanced)      label="󰾅" ;;
                        performance)   label="󰓅" ;;
                        *)             label="$profile" ;;
                        esac

                        printf '{"text":"%s","tooltip":"Active power profile: %s","class":"%s"}\n' "$label" "$profile" "$profile"
                    '';

                    return-type = "json";
                    format = "{text}";
                    tooltip = true;
                    interval = 5;
                    on-click = "walker -m menus:powerprofile";
                };
            };
        };

        style = builtins.readFile ./style.css;
    };

}