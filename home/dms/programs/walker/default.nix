{ lib, pkgs, inputs, config, ...} : {

	imports = [
		inputs.walker.homeManagerModules.default
	];

	programs.walker = {
		enable = true;
		runAsService = true;

		config = {
			theme = "onyx";

			placeholders = {
				"default" = {
					input = "Search";
					list = "Applications";
				};
			};
		};

		themes = {
			onyx = {
				style = builtins.readFile ./style.css;
			};
		};
	};


}