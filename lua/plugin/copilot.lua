return {
    {
        "zbirenbaum/copilot.lua",
        event = "VimEnter",
        cmd = "Copilot",
        opts = {
            suggestion = { enabled = false },
            panel = { enabled = false },
        },
    },
    {
        "zbirenbaum/copilot-cmp",
        config = function()
            require("copilot_cmp").setup()
        end,
    },
}
