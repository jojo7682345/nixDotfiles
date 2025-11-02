return {
	"mfussenegger/nvim-dap",
	config = function()

		local dap = require("dap")
		dap.adapters.cppdbg = {
			name = 'cppdbg',
			type = "executable",
			command = '/home/dms/.local/share/nvim/cpptools/debugAdapters/bin/OpenDebugAD7',
			options = {
				detached = false,
			},
		}
	end,
}
