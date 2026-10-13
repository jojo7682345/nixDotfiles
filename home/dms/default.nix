{ inputs, machine, config, pkgs,  ... } : let

	flakeTemplates = inputs.flakeTemplates.packages.${pkgs.stdenv.hostPlatform.system}.default;
	dotfiles = "${config.home.homeDirectory}/.config/nixos";

	viratheme = pkgs.vscode-utils.extensionFromVscodeMarketplace {
		name = "vsc-material-theme-but-i-wont-sue-you";
		publisher = "t3dotgg";
		version = "35.0.3";
		sha256 = "sha256-RTYB1xQF7qQCc7znUrUB4PkKlXF1yvgrECrZbNV7JEA=";
	};
in {

	imports = [ 
		./programs
		./updating.nix
	];

	home.packages = with pkgs; [ 
		fzf
		nerd-fonts.roboto-mono
		unzip
		firefox
		kdePackages.dolphin
		thunar
		wdisplays
		clang-tools
		btop
		spotify
		jdk
		openjdk
  		jetbrains.idea
		awww
		ranger
		kicad
		tor-browser
		feishin
		mpv
		playerctl
		gnome-calculator
		hyprlock
		brightnessctl
		grim
		slurp
		swappy
		wl-clipboard
		betaflight-configurator
	] ++ [
        (pkgs.writeShellApplication {
            name = "power-menu";

            runtimeInputs = with pkgs; [
                systemd
                walker
            ];

            text = ''
                choice="$(
                    printf '%s\n' \
                        '󰐥  Shutdown' \
                        '󰜉  Restart' \
                        '󰒲  Suspend' \
                        '󰍃  Logout' |
                    walker --dmenu
                )"

                case "$choice" in
                    '󰐥  Shutdown')
                        systemctl poweroff
                        ;;
                    '󰜉  Restart')
                        systemctl reboot
                        ;;
                    '󰒲  Suspend')
                        systemctl suspend
                        ;;
                    '󰍃  Logout')
                        hyprctl dispatch exit
                        ;;
                esac
            '';
        })
    ];

	home.pointerCursor = {
		gtk.enable = true;
		# x11.enable = true;
		package = pkgs.bibata-cursors;
		name = "Bibata-Modern-Classic";
		size = 16;
	};


	
	gtk = {
		enable = true;
		theme = {
			package = pkgs.flat-remix-gtk;
			name = "Flat-Remix-GTK-Grey-Darkest";
		};

		iconTheme = {
			package = pkgs.adwaita-icon-theme;
			name = "Adwaita";
		};
		gtk4.theme = null;

		font = {
			name = "Sans";
			size = 11;
		};
	};
	
	xdg = {
		mimeApps = {
			enable = true;
			defaultApplications = {
				"inode/directory" = "thunar.desktop";
			};
		};

		desktopEntries = {

			feishin = {
				name = "Feishin";
				genericName = "Music player";
				exec = "/etc/profiles/per-user/dms/bin/feishin";
				terminal = false;
				type = "Application";
				categories = [ "AudioVideo" "Audio" "Player" "Music" ];
				comment = "A player for your self-hosted music server";
			};
		};
	};

	fonts.fontconfig.enable = true;

	programs = {
		zsh = {
			enable = true;
			enableCompletion = true;
			syntaxHighlighting.enable = true;
			dotDir = "${config.xdg.configHome}/zsh";
			autosuggestion.enable = true;
			oh-my-zsh = {
				enable = true;
				custom = "${config.home.homeDirectory}/.config/zsh/custom";
				theme = "robbyrussel";
				plugins = [ "git" "sudo" "copypath" "copyfile" "jsontools" ];
			};
			shellAliases = {
				ls = "ls -l --color=auto";
				sl= "sl -e";
				la = "ls -la --color=auto";
				grep = "grep --color=auto";
				update = "sudo nixos-rebuild switch --flake /home/dms/.config/nixos#${machine.name}";
				poweroff = "systemctl poweroff";
				reboot = "systemctl reboot";
				nix-shell = "nix-shell --run $SHELL $@";
			};
			initContent = ''
				nix() {
					if [[ $1 == "develop" ]]; then
						shift
						command nix develop -c $SHELL "$@"
					else
						command nix "$@"
					fi
				}
				source ${flakeTemplates}/share/flakeTemplates/develop.sh
			'';
		};
		git = {
			enable = true;
			settings = {
				user = {
					email = "jojo7682345@gmail.com";
					name = "jojo7682345";
				};
				init.defaultBranch = "main";
				safe.directory = [
					"/win/shared/docs/Advantix/AX3-Electrical"
					"/win/shared/docs/Advantix/AX2_FIRMWARE"
					"/win/shared/usr/avVisualizer"
					"/win"
				];
			};
		};
		neovim = {
			enable = true;
			defaultEditor = true;
			viAlias = true;
			vimAlias = true;
			extraPackages = with pkgs; [
				ripgrep
			];
			withPython3 = false;
			withRuby = false;
		};
		vscode = {
			enable = true;
			profiles.default.extensions = with pkgs.vscode-extensions; [
				ms-vscode.cpptools
				mkhl.direnv
				bbenoist.nix
				llvm-vs-code-extensions.vscode-clangd
				pkief.material-icon-theme
			] ++ [
				viratheme
			];
		};
		direnv = {
			enable = true;
			nix-direnv.enable = true;
		};
		zoxide = {
			enable = true;
			enableZshIntegration = true;
			options = [
				"--cmd cd"
			];
		};
		alacritty = {
			enable = true;
			settings = {
				font = {
					size = 12;
					bold = {
						family = "RobotoMono Nerd Font";
						style = "Bold";
					};
					bold_italic = {
						family = "RobotoMono Nerd Font";
						style = "Bold Italic";
					};
					italic = {
						family = "RobotoMono Nerd Font";
						style = "Italic";
					};
					normal = {
						family = "RobotoMono Nerd Font";
						style = "Regular";
					};
				};
				window = {
					dynamic_title = true;
					opacity = 0.8;
					blur = true;
				};
			};
		};
	};
	services = {
		# wayvnc = {
		# 	enable = true;
		# 	settings = {
		# 		address = "0.0.0.0";
		# 		port = 5900;
		# 	};
		# };
	};


	home.file.".config/zsh/custom/themes/robbyrussel.zsh-theme".source = builtins.fetchurl {
		url = "https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/themes/robbyrussell.zsh-theme";
		sha256 = "b722bc9912c76619113bbfd76c4fc43984273dbd864ca8704e918e75d4dd9761";
	};
	xdg.configFile."nvim".source = ./programs/nvim;

	home.file."docs".source = config.lib.file.mkOutOfStoreSymlink "/win/shared/docs";
	#xdg.configFile."hypr".source = ./programs/hyprland/config;


	services = {
		hypridle = {
			enable = true;
			settings = {
				general = {
					lock_cmd = "${pkgs.procps}/bin/pidof hyprlock || ${pkgs.hyprlock}/bin/hyprlock";

					before_sleep_cmd = "${pkgs.systemd}/bin/loginctl lock-session";
					after_sleep_cmd = "${pkgs.hyprland}/bin/hyprctl dispatch 'hl.dsp.dpms({ action = \"on\"})'";

					ignore_dbus_inhibit = false;
					ignore_systemd_inhibit = false;
				};
				listener = [
					{ # dim after 5 minutes
						timeout = 300;
						on-timeout = "${pkgs.brightnessctl}/bin/brightnessctl -s set 10%";
						on-resume = "${pkgs.brightnessctl}/bin/brightnessctl -r";
					}
					{
						timeout = 600;
						on-timeout = "${pkgs.systemd}/bin/loginctl lock-session";
					}
					{
						timeout = 900;
						on-timeout = "${pkgs.hyprland}/bin/hyprctl dispatch 'hl.dsp.dpms({ action = \"off\"})'";
						on-resume = "${pkgs.hyprland}/bin/hyprctl dispatch 'hl.dsp.dpms({ action = \"on\"})'";

					}
				];
			};
		};
	};

	xdg.configFile."elephant/menus/powerprofile.toml".text = ''
		name = "powerprofile"
		name_pretty = "Power Profile"
		icon = "preferences-system-power"

		action = "${pkgs.power-profiles-daemon}/bin/powerprofilesctl set %VALUE%"

		[[entries]]
		text = "Power Saver"
		value = "power-saver"
		icon = "battery-low"

		[[entries]]
		text = "Balanced"
		value = "balanced"
		icon = "balance-scale"

		[[entries]]
		text = "Performance"
		value = "performance"
		icon = "speedometer"
	'';

}
