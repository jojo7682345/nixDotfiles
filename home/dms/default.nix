{ inputs, machine, config, pkgs,  ... } : let

	flakeTemplates = inputs.flakeTemplates.packages.${pkgs.system}.default;
	dotfiles = "${config.home.homeDirectory}/.config/nixos";
in {

	imports = [ ./programs/hyprland ];

	home.packages = with pkgs; [ 
		mc
		fzf
		nerd-fonts.roboto-mono
		unzip
		firefox
		kdePackages.dolphin
		wdisplays
	];

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
				update = "sudo nixos-rebuild switch --flake /home/dms/.config/nixos";
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
		wayvnc = {
			enable = true;
			settings = {
				address = "0.0.0.0";
				port = 5900;
			};
		};
	};


	home.file.".config/zsh/custom/themes/robbyrussel.zsh-theme".source = builtins.fetchurl {
		url = "https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/themes/robbyrussell.zsh-theme";
		sha256 = "b722bc9912c76619113bbfd76c4fc43984273dbd864ca8704e918e75d4dd9761";
	};
	xdg.configFile."nvim".source = ./programs/nvim;
	#xdg.configFile."hypr".source = ./programs/hyprland/config;
}
