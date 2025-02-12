-- Options
vim.opt.mouse = "" -- disable mouse support
vim.opt.number = false
vim.opt.relativenumber = true
vim.opt.numberwidth = 2
vim.opt.textwidth = 98
vim.opt.showmode = false -- statusline shows mode
vim.opt.breakindent = true
vim.opt.undofile = true -- save undo history
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.signcolumn = "yes"
vim.opt.updatetime = 250 -- used for CursorHold autocomd event and writing to swapfile
vim.opt.timeoutlen = 900 -- timeout triggers whichkey popup
vim.opt.splitright = true
vim.opt.splitbelow = true
vim.opt.list = true
vim.opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" } -- how whitespace chars appear
vim.opt.inccommand = "split" -- preview substitutions live as you type
vim.opt.cursorline = true
vim.opt.scrolloff = 4 -- minimal number of screen lines to keep above and below cursor
vim.opt.expandtab = true
vim.opt.shiftwidth = 4
vim.opt.softtabstop = 4
vim.opt.swapfile = false

vim.diagnostic.config({
    virtual_text = {
        severity = { min = vim.diagnostic.severity.WARN },
    },
    signs = {
        severity = { min = vim.diagnostic.severity.WARN },
    },
    underline = {
        severity = { min = vim.diagnostic.severity.WARN },
    },
})
vim.g.diagnostics_visible = false
vim.diagnostic.config({ virtual_text = vim.g.diagnostics_visible })

vim.g.yaml_indent_multiline_scalar = 1 -- fix autoindent for multiline yaml scalars

-- Undercurl
vim.cmd([[let &t_Cs = "\e[4:3m"]])
vim.cmd([[let &t_Ce = "\e[4:0m"]])

-- Keymaps
vim.g.mapleader = ","
vim.g.maplocalleader = " "
vim.keymap.set("n", "<C-j>", "<C-d>", { desc = "Scroll down half screen" })
vim.keymap.set("n", "<C-k>", "<C-u>", { desc = "Scroll up half screen" })
vim.keymap.set("n", "g;", ",", { desc = "Reverse char search" })
vim.keymap.set("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })
vim.keymap.set("n", "<leader>;", "<cmd>nohlsearch<CR>", { desc = "Remove search highlight" })
vim.keymap.set("n", "<leader>cn", ":lne<CR>", { desc = "Next location" })
vim.keymap.set("n", "<leader>cp", ":lpr<CR>", { desc = "Prev location" })
vim.keymap.set("n", "<leader>cc", ":ll<CR>", { desc = "Curr location" })
vim.keymap.set("n", "<leader>cq", ":lcl<CR>", { desc = "Curr location" })
vim.keymap.set("n", "<leader>qn", ":cne<CR>", { desc = "Next Quickfix" })
vim.keymap.set("n", "<leader>qp", ":cpr<CR>", { desc = "Prev Quickfix" })
vim.keymap.set("n", "<leader>qc", ":cl<CR>", { desc = "Curr Quickfix" })
vim.keymap.set("n", "<leader>qq", ":ccl<CR>", { desc = "Curr Quickfix" })
vim.keymap.set(
    "n",
    "<leader>io",
    vim.diagnostic.setloclist,
    { desc = "Open diagnostic location list" }
)
vim.keymap.set("n", "<leader>iv", function()
    if vim.g.diagnostics_visible then
        vim.g.diagnostics_visible = false
        vim.diagnostic.config({ virtual_text = false })
    else
        vim.g.diagnostics_visible = true
        vim.diagnostic.config({ virtual_text = true })
    end
end, { desc = "Toggle diagnostics virtual text" })
vim.keymap.set("n", "<leader>il", function()
    if vim.opt.colorcolumn["_value"] == "" then
        vim.opt.colorcolumn = "+2"
    else
        vim.opt.colorcolumn = ""
    end
end, { desc = "Toggle linewrap guide" })
vim.keymap.set("n", "<leader>in", vim.diagnostic.goto_next, { desc = "Jump to Next Diagnostic" })
vim.keymap.set("n", "<leader>ip", vim.diagnostic.goto_prev, { desc = "Jump to Prev Diagnostic" })
vim.keymap.set("n", "<leader>ii", vim.diagnostic.open_float, { desc = "Get curr diagnostic" })
vim.keymap.set("n", "<leader>ie", function()
    vim.diagnostic.enable(not vim.diagnostic.is_enabled())
end, { desc = "Toggle diagnostics" })
vim.keymap.set("n", "<leader>ro", ":view<CR>", { desc = "Set file to read-only" })
vim.keymap.set("n", "<leader>rw", ":edit<CR>", { desc = "Set file to read/write" })
vim.keymap.set("n", "<leader>m", ":Mason<CR>", { desc = "Open Mason window" })

-- Autocommands
vim.api.nvim_create_autocmd("TextYankPost", {
    desc = "Highlight when yanking (copying) text",
    group = vim.api.nvim_create_augroup("highlight-yank", { clear = true }),
    callback = function()
        vim.highlight.on_yank()
    end,
})

-- Modular configuration
require("config.window")

-- Autoformatting and autowrapping
vim.api.nvim_create_autocmd("FileType", {
    pattern = "*",
    command = "setlocal formatoptions=tcqln",
})

-- Install plugin manager
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
    local lazyrepo = "https://github.com/folke/lazy.nvim.git"
    local out = vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "--branch=stable",
        lazyrepo,
        lazypath,
    })
    if vim.v.shell_error ~= 0 then
        error("Error cloning lazy.nvim:\n" .. out)
    end
end ---@diagnostic disable-next-line: undefined-field
vim.opt.rtp:prepend(lazypath)

-- Load project-specific config from working directory
if vim.uv.fs_stat(".nvim.lua") then
    vim.cmd("source .nvim.lua")
end

-- Configure plugins
require("lazy").setup({
    require("lazyplugin.find"),
    require("lazyplugin.lsp"),
    require("lazyplugin.complete"),
    require("lazyplugin.lint"),
    require("lazyplugin.treesitter"),
    require("lazyplugin.format"),
    require("lazyplugin.debug"),
    require("lazyplugin.filetree"),
    require("lazyplugin.hud"),
    require("lazyplugin.style"),
    require("lazyplugin.vi"),
}, {
    ui = {
        icons = {
            cmd = "⌘",
            config = "🛠",
            event = "📅",
            ft = "📂",
            init = "⚙",
            keys = "🗝",
            plugin = "🔌",
            runtime = "💻",
            require = "🌙",
            source = "📄",
            start = "🚀",
            task = "📌",
            lazy = "💤 ",
        },
    },
})
