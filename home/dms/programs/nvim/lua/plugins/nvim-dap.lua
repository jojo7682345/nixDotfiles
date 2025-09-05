return {
	"mfussenegger/nvim-dap",
	config = function()

		local dap = require("dap")
		dap.adapters.cppdbg = {
			name = 'cppdbg',
			type = "executable",
			command = '/home/dms/.vscode/extensions/ms-vscode.cpptools-1.26.3-linux-x64/debugAdapters/bin/OpenDebugAD7',
		}
	end,
}
