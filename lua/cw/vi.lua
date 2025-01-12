return {
    {
        'echasnovski/mini.nvim', -- vi text objects
        config = function()
            require('mini.ai').setup { n_lines = 500 }
            require('mini.surround').setup()
        end,
    },
}
