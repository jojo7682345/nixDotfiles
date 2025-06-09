return { 
	"tiagovla/scope.nvim", 
	config = function()
		require("scope").setup({
			hooks = {
				post_tab_leave = function()
					vim.cmd(":NvimTreeClose")
				end
			}
		})

	end
}
