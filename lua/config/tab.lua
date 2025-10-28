-- General tab manipulation
vim.keymap.set("n", "<leader>to", ":TabooOpen<space>", { desc = "Create new named tab" })
vim.keymap.set("n", "<leader>tn", ":tabn<CR>", { desc = "Jump to next tab" })
vim.keymap.set("n", "<leader>tp", ":tabp<CR>", { desc = "Jump to prev tab" })
vim.keymap.set("n", "<leader>tq", ":tabc<CR>", { desc = "Close current tab" })
vim.keymap.set("n", "<leader>tr", ":TabooRename<space>", { desc = "Rename current tab" })
vim.keymap.set("n", "<leader>tc", ":tcd<space>", { desc = "Change dir for current tab" })
vim.keymap.set("n", "<leader>t1", "1gt", { desc = "Jump to 1st tab" })
vim.keymap.set("n", "<leader>t2", "2gt", { desc = "Jump to 2nd tab" })
vim.keymap.set("n", "<leader>t3", "3gt", { desc = "Jump to 3rd tab" })
vim.keymap.set("n", "<leader>t4", "4gt", { desc = "Jump to 4th tab" })
vim.keymap.set("n", "<leader>t5", "5gt", { desc = "Jump to 5th tab" })
vim.keymap.set("n", "<leader>t6", "6gt", { desc = "Jump to 6th tab" })

local function jump_or_create_tab(name, cmd)
    local found = false
    for i = 1, vim.fn.tabpagenr("$") do
        if vim.fn.TabooTabName(i) == name then
            vim.cmd("tabnext " .. i)
            found = true
        end
    end
    if not found then
        vim.cmd("TabooOpen " .. name)
        vim.cmd(cmd)
    end
end

-- Terminal tab
term_augroup = vim.api.nvim_create_augroup("terminal-mode", { clear = true })
vim.api.nvim_create_autocmd("TermOpen", {
    desc = "Configure terminal buffer options",
    group = term_augroup,
    callback = function()
        vim.api.nvim_set_option_value("rnu", false, { scope = "local" })
        vim.api.nvim_set_option_value("signcolumn", "no", { scope = "local" })
        vim.api.nvim_set_option_value("foldcolumn", "0", { scope = "local" })
    end,
})
vim.api.nvim_create_autocmd("BufEnter", {
    pattern = "term://*",
    desc = "Scroll to latest activity on entering terminal buffer",
    group = term_augroup,
    callback = function()
        vim.cmd("normal G")
    end,
})
vim.keymap.set("n", "<leader>tt", function()
    jump_or_create_tab(">term", "terminal")
end, { desc = "Open new terminal tab" })

-- DBUI tab
vim.keymap.set("n", "<leader>td", function()
    jump_or_create_tab(">db", "DBUI")
end, { desc = "Open or jump to DB tab" })
