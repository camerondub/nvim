-- vim window navigation
vim.keymap.set("n", "gq", "<C-w>q", { desc = "Close window" })
vim.keymap.set("n", "<leader>wh", "<C-w>h", { desc = "Change window left" })
vim.keymap.set("n", "<leader>wj", "<C-w>j", { desc = "Change window down" })
vim.keymap.set("n", "<leader>wk", "<C-w>k", { desc = "Change window up" })
vim.keymap.set("n", "<leader>wl", "<C-w>l", { desc = "Change window right" })
vim.keymap.set("n", "<leader>wH", "<C-w>H", { desc = "Move window to Left" })
vim.keymap.set("n", "<leader>wJ", "<C-w>J", { desc = "Move window to Bot" })
vim.keymap.set("n", "<leader>wK", "<C-w>K", { desc = "Move window to Top" })
vim.keymap.set("n", "<leader>wL", "<C-w>L", { desc = "Move window to Right" })
vim.keymap.set("n", "<leader>wv", "<C-w>v", { desc = "Split window vertically" })
vim.keymap.set("n", "<leader>ws", "<C-w>s", { desc = "Split window horizontally" })
vim.keymap.set("n", "<leader>wo", "<C-w>o", { desc = "Close all other windows" })
vim.keymap.set("n", "<leader>wb", "<C-w>b", { desc = "Go to bottom window" })
vim.keymap.set("n", "<leader>wp", "<C-w>p", { desc = "Go to prev window" })
vim.keymap.set("n", "<leader>w;", "<C-w>p", { desc = "Go to prev window" })
vim.keymap.set("n", "<C-Space>", function()
    vim.cmd("wincmd w")
    if vim.bo.buftype == "terminal" then
        vim.cmd("startinsert")
    end
end, { desc = "Go to next window" })
vim.keymap.set("n", "<leader>w1", "1<C-w>w", { desc = "Go to 1st window" })
vim.keymap.set("n", "<leader>w2", "2<C-w>w", { desc = "Go to 2nd window" })
vim.keymap.set("n", "<leader>w3", "3<C-w>w", { desc = "Go to 3rd window" })
vim.keymap.set("n", "<leader>w4", "4<C-w>w", { desc = "Go to 4th window" })
vim.keymap.set("n", "<leader>w5", "5<C-w>w", { desc = "Go to 5th window" })
vim.keymap.set("n", "<leader>w6", "6<C-w>w", { desc = "Go to 6th window" })
vim.keymap.set("n", "<leader>wt", ":term<CR>", { desc = "Go to terminal window" })

-- location window
vim.keymap.set("n", "<leader>cn", ":lne<CR>", { desc = "Next location" })
vim.keymap.set("n", "<leader>cp", ":lpr<CR>", { desc = "Prev location" })
vim.keymap.set("n", "<leader>cc", ":ll<CR>", { desc = "Curr location" })
vim.keymap.set("n", "<leader>cq", ":lcl<CR>", { desc = "Curr location" })

-- quickfix window
vim.keymap.set("n", "<leader>qn", ":cne<CR>", { desc = "Next Quickfix" })
vim.keymap.set("n", "<leader>qp", ":cpr<CR>", { desc = "Prev Quickfix" })
vim.keymap.set("n", "<leader>qc", ":cc<CR>", { desc = "Curr Quickfix" })
vim.keymap.set("n", "<leader>qq", ":ccl<CR>", { desc = "Curr Quickfix" })

-- terminal window
vim.keymap.set("t", "<C-Space>", [[<C-\><C-n><C-w>w]], { noremap = true, silent = true })

-- note window
vim.keymap.set("n", "<leader>en", ":e .note.yml<CR>", { desc = "Edit local note file" })
vim.keymap.set("n", "<leader>ee", ":e .env<CR>", { desc = "Edit local env file" })
