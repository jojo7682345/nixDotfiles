{ inputs, machine, config, pkgs,  ... }:
{
	home.packages = with pkgs; [ git zsh ];
	programs = {
		zsh = {
			enable = true;
			oh-my-zsh = {
				enable = true;
				plugins = [ "git" "sudo" ];
			};
		};
		git = {
			enable = true;
			userEmail = "jojo7682345@gmail.com";
			userName = "jojo7682345";
		};
	};
}
