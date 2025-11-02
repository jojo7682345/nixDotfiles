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
keymaps.normal['<C-z>'] = { "<C-u>", "undo" }
keymaps.insert['<C-z>'] = { "<C-u>", "undo" }

keymaps.terminal['<Esc><Esc>'] = { "<C-\\><C-n>", "exit terminal mode" }


-- Swap lines in normal mode
keymaps.normal['<A-Up>'] = { ":m .-2<CR>==", "move line up" }
keymaps.normal['<A-Down>'] = { ":m .+1<CR>==", "move line down" }

-- Swap lines in insert mode (using <C-o> to send normal mode commands)
keymaps.insert['<A-Up>'] = { "<Esc>:m .-2<CR>==gi", "move line up" }
keymaps.insert['<A-Down>'] = { "<Esc>:m .+1<CR>==gi", "move line down" }

-- Normal mode
keymaps.normal['<C-S-M-Down>'] = { "yyp", "duplicate line down" }
keymaps.insert['<C-S-M-Down>'] = { "<Esc>yypgi", "duplicate line down" }
keymaps.normal['<C-S-M-Up>'] = { "yyP", "duplicate line up" }
keymaps.insert['<C-S-M-Up>'] = { "<Esc>yyPgi", "duplicate line up" }

keymaps.normal['<leader>b'] = { ":NvimTreeToggle<CR>", "toggle file exporer" }

keymaps.normal['<F5>'] = {
	function()
    	-- (Re-)reads launch.json if present
        if vim.fn.filereadable(".vscode/launch.json") then
            require("dap.ext.vscode").load_launchjs(nil, { cppdbg = { "c", "cpp" }, cpptools="cppdbg" })
        end
        require("dap").continue()
    end,
    "DAP Continue"
}

function onLspAttach(opts)


end
