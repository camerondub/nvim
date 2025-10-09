vim.diagnostic.config({
    virtual_text = {
        severity = { min = vim.diagnostic.severity.WARN },
        source = true,
    },
    signs = {
        severity = { min = vim.diagnostic.severity.WARN },
    },
    underline = {
        severity = { min = vim.diagnostic.severity.WARN },
    },
    float = {
        source = true,
    },
})
vim.g.diagnostics_visible = true
vim.diagnostic.config({
    virtual_text = vim.g.diagnostics_visible,
})
vim.keymap.set("n", "<leader>iv;", function()
    vim.g.diagnostics_visible = not vim.g.diagnostics_visible
    vim.diagnostic.config({
        virtual_text = vim.g.diagnostics_visible,
    })
end, { desc = "Toggle diagnostics virtual text" })

vim.keymap.set(
    "n",
    "<leader>io",
    vim.diagnostic.setloclist,
    { desc = "Open diagnostic location list" }
)
vim.keymap.set("n", "<leader>in", vim.diagnostic.goto_next, { desc = "Jump to Next Diagnostic" })
vim.keymap.set("n", "<leader>ip", vim.diagnostic.goto_prev, { desc = "Jump to Prev Diagnostic" })
vim.keymap.set("n", "<leader>ii", vim.diagnostic.open_float, { desc = "Get curr diagnostic" })
vim.keymap.set("n", "<leader>i;", function()
    vim.diagnostic.enable(not vim.diagnostic.is_enabled())
end, { desc = "Toggle diagnostics" })
vim.keymap.set("n", "<leader>ic", vim.diagnostic.reset, { desc = "Clear diagnostics" })
