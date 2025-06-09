return {
	"jiaoshijie/undotree",
	dependencies = "nvim-lua/plenary.nvim",
	config = function()
		require('undotree').setup({
			float_diff = true,
			layout = "left_bottom",
			position = "left",
			ignore_filetype = { 'undotree', 'undotreeDiff', 'qf', 'TelescopePromt', 'spectre_panel', 'tsplayground' },

		})
	end,
}
