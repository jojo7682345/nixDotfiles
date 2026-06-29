{ lib, pkgs, inputs', config, ...} : {

	programs.walker = {
	enable = true;
	runAsService = true;

	config = {
			theme = "default";

			placeholders = {
				"default" = {
					input = "Search";
					list = "Applications";
				};
			};
		};
	};


}