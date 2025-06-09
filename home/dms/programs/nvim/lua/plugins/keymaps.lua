return {
	'jojo7682345/keymaps.nvim',
	priority = 2000, -- load before setting keymaps
	opts = {
		-- default options given to `vim.keymap.set()`
		default_opts = {
		silent = true,
		noremap = true,
		},
	},
	config = function()
		require 'keymaps'.setup {}
		require 'telescope'.load_extension 'keymaps_nvim'
	end
}
