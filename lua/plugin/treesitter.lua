return {
    {
        "nvim-treesitter/nvim-treesitter", -- highlight, edit, and navigate code
        build = ":TSUpdate",
        main = "nvim-treesitter.configs",
        opts = {
            ensure_installed = {
                "bash",
                "c",
                "diff",
                "html",
                "lua",
                "luadoc",
                "markdown",
                "markdown_inline",
                "query",
                "vim",
                "vimdoc",
            },
            auto_install = true,
            highlight = {
                enable = true,
            },
            indent = { enable = true, disable = { "yaml", "markdown" } },
        },
    },
}
