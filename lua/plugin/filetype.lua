return {
    "lambdalisue/vim-suda",
    config = function()
        vim.g.suda_smart_edit = 1
        vim.keymap.set("n", "<leader>ur", ":SudaRead<CR>", { desc = "Reopen file with sudo" })
        vim.keymap.set("n", "<leader>uw", ":SudaWrite<CR>", { desc = "Write file with sudo" })
    end,
}
