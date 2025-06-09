local telescope = {
	builtin = require("telescope.builtin"),
	extensions = require("telescope").extensions,
}

keymaps.normal['<leader>e'] = { ":Ex<CR>", "open file exporer" }
keymaps.normal['<leader>f'] = { telescope.builtin.find_files, "find files" }
keymaps.normal['<leader>g'] = { telescope.builtin.live_grep, "live grep" }
keymaps.normal['<leader>km'] = { telescope.extensions.keymaps_nvim.keymaps_nvim, "show key maps" }

keymaps.normal['<leader>u'] = { "<cmd>lua require('undotree').toggle()<CR>", "open undotree" }

keymaps.normal['<C-s>'] = { vim.cmd.update, "save" }
keymaps.insert['<C-s>'] = { vim.cmd.update, "save" }




keymaps.terminal['<Esc><Esc>'] = { "<C-\\><C-n>", "exit terminal mode" }


keymaps.normal['<leader>b'] = { ":NvimTreeToggle<CR>", "toggle file exporer" }

function onLspAttach(opts)


end
