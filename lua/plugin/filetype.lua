return {
    "lambdalisue/vim-suda",
    config = function()
        vim.g.suda_smart_edit = 1
        vim.keymap.set("n", "<leader>ue", ":SudaRead<CR>", { desc = "Edit file with sudo" })
        vim.keymap.set("n", "<leader>uw", ":SudaWrite<CR>", { desc = "Write file with sudo" })
    end,
}
