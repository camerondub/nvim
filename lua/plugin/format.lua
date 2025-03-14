return {
    {
        "stevearc/conform.nvim", -- auto formatting
        event = { "BufWritePre" },
        cmd = { "ConformInfo" },
        keys = {
            {
                "<leader>ff",
                function()
                    require("conform").format({ async = true, lsp_format = "fallback" })
                end,
                desc = "[F]ormat buffer",
            },
            {
                "<leader>ft",
                function()
                    vim.b.disable_autoformat = not vim.b.disable_autoformat
                    vim.notify("vim.b.disable_autoformat = " .. tostring(vim.b.disable_autoformat))
                end,
                desc = "Toggle autoformatting",
            },
        },
        opts = {
            notify_on_error = false,
            format_on_save = function(bufnr)
                if vim.b[bufnr].disable_autoformat then
                    return
                end
                local disable_filetypes = { c = true, cpp = true }
                local fname = vim.fn.expand("%")
                local fugitive_prefix = "fugitive:///"
                local lsp_format_opt
                if string.sub(fname, 1, #fugitive_prefix) == fugitive_prefix then
                    return nil
                elseif disable_filetypes[vim.bo[bufnr].filetype] then
                    lsp_format_opt = "never"
                else
                    lsp_format_opt = "fallback"
                end
                return {
                    timeout_ms = 500,
                    lsp_format = lsp_format_opt,
                }
            end,
            formatters_by_ft = {
                lua = { "stylua" },
                python = { "isort", "black" },
                javascript = { "prettier" },
                javascriptreact = { "prettier" },
                typescript = { "prettier" },
                typescriptreact = { "prettier" },
                css = { "prettier" },
            },
            log_level = vim.log.levels.ERROR,
        },
    },
}
