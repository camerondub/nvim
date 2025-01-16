-- Options
vim.opt.mouse = "" -- disable mouse support
vim.opt.number = false
vim.opt.relativenumber = true
vim.opt.numberwidth = 2
vim.opt.textwidth = 98
vim.opt.showmode = true -- unneeded; we use statusline
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

vim.g.diagnostics_visible = true
vim.diagnostic.config({ virtual_text = true })

-- Undercurl
vim.cmd([[let &t_Cs = "\e[4:3m"]])
vim.cmd([[let &t_Ce = "\e[4:0m"]])

-- Keymaps
vim.g.mapleader = ","
vim.g.maplocalleader = " "
vim.keymap.set("n", "<C-j>", "<C-d>", { desc = "Scroll down half screen" })
vim.keymap.set("n", "<C-k>", "<C-u>", { desc = "Scroll up half screen" })
vim.keymap.set("n", "gq", "<C-w>q", { desc = "Close window" })
vim.keymap.set("n", "<leader>wh", "<C-w>h", { desc = "Change window left" })
vim.keymap.set("n", "<leader>wj", "<C-w>j", { desc = "Change window down" })
vim.keymap.set("n", "<leader>wk", "<C-w>k", { desc = "Change window up" })
vim.keymap.set("n", "<leader>wl", "<C-w>l", { desc = "Change window right" })
vim.keymap.set("n", "<leader>wv", "<C-w>v", { desc = "Split window vertically" })
vim.keymap.set("n", "<leader>ws", "<C-w>s", { desc = "Split window horizontally" })
vim.keymap.set("n", "<leader>wo", "<C-w>o", { desc = "Close all other windows" })
vim.keymap.set("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })
vim.keymap.set("n", "<leader>;", "<cmd>nohlsearch<CR>", { desc = "Remove search highlight" })
vim.keymap.set("n", "<leader>cn", ":lne<CR>", { desc = "Next location" })
vim.keymap.set("n", "<leader>cp", ":lpr<CR>", { desc = "Prev location" })
vim.keymap.set("n", "<leader>cc", ":ll<CR>", { desc = "Curr location" })
vim.keymap.set("n", "<leader>qn", ":cne<CR>", { desc = "Next Quickfix" })
vim.keymap.set("n", "<leader>qp", ":cpr<CR>", { desc = "Prev Quickfix" })
vim.keymap.set("n", "<leader>qc", ":cl<CR>", { desc = "Curr Quickfix" })
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
vim.keymap.set("n", "<leader>in", vim.diagnostic.goto_next, { desc = "Jump to Next Diagnostic" })
vim.keymap.set("n", "<leader>ip", vim.diagnostic.goto_prev, { desc = "Jump to Prev Diagnostic" })
vim.keymap.set("n", "<leader>ii", vim.diagnostic.open_float, { desc = "Get curr diagnostic" })
vim.keymap.set("n", "<leader>ro", ":view<CR>", { desc = "Set file to read-only" })
vim.keymap.set("n", "<leader>rw", ":edit<CR>", { desc = "Set file to read/write" })
vim.keymap.set("n", "<leader>m", ":Mason", { desc = "Open Mason window" })

-- Autocommands
vim.api.nvim_create_autocmd("TextYankPost", {
    desc = "Highlight when yanking (copying) text",
    group = vim.api.nvim_create_augroup("highlight-yank", { clear = true }),
    callback = function()
        vim.highlight.on_yank()
    end,
})

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

-- Configure plugins
require("lazy").setup({
    require("cw.find"),
    require("cw.lsp"),
    require("cw.complete"),
    require("cw.lint"),
    require("cw.format"),
    require("cw.debug"),
    require("cw.hud"),
    require("cw.style"),
    require("cw.vi"),
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

-- Load project-specific config from working directory
if vim.uv.fs_stat(".nvim.lua") then
    vim.cmd("source .nvim.lua")
end
