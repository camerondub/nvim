return {
    {
        'mfussenegger/nvim-lint', -- linting
        event = { 'BufReadPre', 'BufNewFile' },
        config = function()
            local lint = require 'lint'
            lint.linters_by_ft = {
                markdown = { 'markdownlint' },
            }

            local lint_augroup = vim.api.nvim_create_augroup('lint', { clear = true })
            vim.api.nvim_create_autocmd({ 'BufEnter', 'BufWritePost', 'InsertLeave' }, {
                group = lint_augroup,
                callback = function()
                    lint.try_lint()
                end,
            })
        end,
    }, {
        'rshkarin/mason-nvim-lint',
        ensure_installed = { 'pylint' },
    }
}
