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

-- Map Ctrl-G to advance tab in any mode
local function reenter_if_terminal()
    local buf = vim.api.nvim_get_current_buf()
    if vim.bo[buf].buftype == "terminal" then
        vim.cmd("startinsert")
    end
end

local function next_tab_smart()
    if vim.fn.mode() == "t" then
        -- In terminal-insert: send the whole key sequence as real input
        local keys = vim.api.nvim_replace_termcodes("<C-\\><C-n>gt", true, false, true)
        vim.api.nvim_feedkeys(keys, "n", false)
        -- Defer the reinsert check until after the jump happens
        vim.schedule(reenter_if_terminal)
    else
        -- Not in terminal-insert: safe to use Ex/normal commands
        vim.cmd("tabnext") -- or: vim.cmd("normal! gt")
        reenter_if_terminal()
    end
end

local function prev_tab_smart()
    if vim.fn.mode() == "t" then
        local keys = vim.api.nvim_replace_termcodes("<C-\\><C-n>gT", true, false, true)
        vim.api.nvim_feedkeys(keys, "n", false)
        vim.schedule(reenter_if_terminal)
    else
        vim.cmd("tabprevious") -- or: vim.cmd("normal! gT")
        reenter_if_terminal()
    end
end

vim.keymap.set(
    { "n", "t", "i" },
    "<C-g>",
    next_tab_smart,
    { silent = true, desc = "Next tab (term-aware)" }
)

vim.keymap.set(
    { "n", "t", "i" },
    "<A-g>",
    prev_tab_smart,
    { silent = true, desc = "Prev tab (term-aware)" }
)
