{ inputs, machine, config, pkgs,  ... }:
{
	home.packages = with pkgs; [ 
		git
		zsh
	];
	programs = {
		zsh = {
			enable = true;
			enableCompletion = true;
			syntaxHighlighting.enable = true;
			enableAutosuggestions = true;
			dotDir = ".config/zsh";
			#programs.zsh.autosuggestion.enable = true;
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
		};
		git = {
			enable = true;
			userEmail = "jojo7682345@gmail.com";
			userName = "jojo7682345";
		};
		neovim = {
			enable = true;
			defaultEditor = true;
			viAlias = true;
			vimAlias = true;
		};
	};
	home.file.".config/zsh/custom/themes/robbyrussel.zsh-theme".source = builtins.fetchurl {
		url = "https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/themes/robbyrussell.zsh-theme";
		sha256 = "b722bc9912c76619113bbfd76c4fc43984273dbd864ca8704e918e75d4dd9761";
	};
	home.file.".config/nvim".source = ./programs/nvim;
}
