{ lib, config, machine, pkgs, ... }:{
	services.udev = {
		packages = map (rule: {
			(pkgs.writeTextFile {
				name = rule.name;
				destination = "/etc/udev/rules.d/${rule.name}";
				text = rule.content;
			});
		}) machine.os.input.rules;
	};
}
