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

            local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })
            vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
                group = lint_augroup,
                callback = function()
                    lint.try_lint()
                end,
            })
            lint.linters.pylint.cmd = "python3"
            lint.linters.pylint.args = {
                "-m",
                "pylint",
                "-f",
                "json",
                "--from-stdin",
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
