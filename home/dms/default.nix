{ inputs, machine, config, pkgs,  ... }:
{
	home.packages = with pkgs; [ git zsh ];
	programs.zsh.enable = true;

	programs.git = {
		enable = true;
		userEmail = "jojo7682345@gmail.com";
		userName = "jojo7682345";
	};
}
