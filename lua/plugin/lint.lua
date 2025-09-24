return {
    {
        "mfussenegger/nvim-lint", -- linting
        event = { "BufReadPre", "BufNewFile" },
        config = function()
            local lint = require("lint")
            lint.linters_by_ft = {
                markdown = { "markdownlint" },
                python = { "pylint" },
            }

            vim.g.linting_enabled = true

            local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })
            vim.api.nvim_create_autocmd({ "BufWritePost" }, {
                group = lint_augroup,
                callback = function()
                    if vim.g.linting_enabled then
                        lint.try_lint()
                    end
                end,
            })

            vim.keymap.set("n", "<leader>il", function()
                if vim.g.linting_enabled then
                    vim.g.linting_enabled = false
                    vim.diagnostic.reset()
                    vim.notify("Disabled linting")
                    return
                else
                    vim.g.linting_enabled = true
                    lint.try_lint()
                    vim.notify("Enabled linting")
                end
            end, { desc = "Toggle linting" })

            lint.linters.pylint.cmd = "python3"
            lint.linters.pylint.args = {
                "-m",
                "pylint",
                "-f",
                "json",
                "--from-stdin",
                "-j",
                "8",
                function()
                    return vim.api.nvim_buf_get_name(0)
                end,
            }
        end,
    },
    {
        "rshkarin/mason-nvim-lint",
        opts = {
            ensure_installed = { "markdownlint" },
        },
    },
}
