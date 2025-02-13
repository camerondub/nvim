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
vim.keymap.set("n", "<leader>wt", "<C-w>t", { desc = "Go to top window" })
vim.keymap.set("n", "<leader>wb", "<C-w>b", { desc = "Go to bottom window" })
vim.keymap.set("n", "<leader>wp", "<C-w>p", { desc = "Go to prev window" })
vim.keymap.set("n", "<leader>ww", function()
    return vim.v.count .. "<C-w>w"
end, { expr = true, desc = "Go to Nth window" })

-- location window
vim.keymap.set("n", "<leader>cn", ":lne<CR>", { desc = "Next location" })
vim.keymap.set("n", "<leader>cp", ":lpr<CR>", { desc = "Prev location" })
vim.keymap.set("n", "<leader>cc", ":ll<CR>", { desc = "Curr location" })
vim.keymap.set("n", "<leader>cq", ":lcl<CR>", { desc = "Curr location" })

-- quickfix window
vim.keymap.set("n", "<leader>qn", ":cne<CR>", { desc = "Next Quickfix" })
vim.keymap.set("n", "<leader>qp", ":cpr<CR>", { desc = "Prev Quickfix" })
vim.keymap.set("n", "<leader>qc", ":cl<CR>", { desc = "Curr Quickfix" })
vim.keymap.set("n", "<leader>qq", ":ccl<CR>", { desc = "Curr Quickfix" })
