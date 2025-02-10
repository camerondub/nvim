return {
    {
        "mfussenegger/nvim-dap",
        name = "nvim-dap",
        dependencies = {
            {
                "rcarriga/nvim-dap-ui",
                opts = {
                    icons = { expanded = "▾", collapsed = "▸", current_frame = "*" },
                    controls = {
                        element = "repl",
                        enabled = false,
                        icons = {
                            pause = "⏸",
                            play = "▶",
                            step_into = "⏎",
                            step_over = "⏭",
                            step_out = "⏮",
                            step_back = "b",
                            run_last = "▶▶",
                            terminate = "⏹",
                            disconnect = "⏏",
                        },
                    },
                },
            },
            "nvim-neotest/nvim-nio",
            "williamboman/mason.nvim",
            {
                "microsoft/vscode-js-debug",
                build = "npm install --legacy-peer-deps && npx gulp vsDebugServerBundle && "
                    .. "mv dist out",
            },
            {
                "mxsdev/nvim-dap-vscode-js",
                config = function(_, _)
                    ---@diagnostic disable-next-line: missing-fields
                    require("dap-vscode-js").setup({
                        debugger_path = vim.fn.resolve(
                            vim.fn.stdpath("data") .. "/lazy/vscode-js-debug"
                        ),
                    })
                end,
            },
        },
        keys = function(_, keys)
            local dap = require("dap")
            local dapui = require("dapui")
            return {
                { "<leader>dc", dap.continue, desc = "Debug: Start/Continue" },
                { "<leader>di", dap.step_into, desc = "Debug: Step Into" },
                { "<leader>dv", dap.step_over, desc = "Debug: Step Over" },
                { "<space>", dap.step_over, desc = "Debug: Step Over" },
                { "<leader>do", dap.step_out, desc = "Debug: Step Out" },
                { "<leader>db", dap.toggle_breakpoint, desc = "Debug: Toggle Breakpoint" },
                { "<leader>de", dap.terminate, desc = "Debug: End" },
                {
                    "<leader>db",
                    function()
                        dap.set_breakpoint(vim.fn.input("Breakpoint condition: "))
                    end,
                    desc = "Debug: Set Breakpoint",
                },
                { "<leader>dt", dapui.toggle, desc = "Debug: See last session result." },
                unpack(keys),
            }
        end,
        config = function()
            local dap = require("dap")
            local dapui = require("dapui")

            require("mason-nvim-dap").setup({
                automatic_installation = true,
                handlers = {},
                ensure_installed = {},
            })

            dap.listeners.after.event_initialized["dapui_config"] = dapui.open
            dap.listeners.before.event_terminated["dapui_config"] = dapui.close
            dap.listeners.before.event_exited["dapui_config"] = dapui.close

            -- language-specific debugger config
            if vim.g.dap_python_opt ~= nil then
                dap.adapters.python = vim.g.dap_python_opt.adapter
                dap.configurations.python = vim.g.dap_python_opt.configuration
            else
                dap.adapters.python = {
                    type = "server",
                    server = "localhost",
                    port = 5678,
                }
                dap.configurations.python = {
                    {
                        type = "python",
                        request = "attach",
                        name = "Attach to Python Debugger",
                    },
                }
            end

            local node_langs = { "javascript", "javascriptreact", "typescript", "typescriptreact" }
            for _, lang in ipairs(node_langs) do
                if vim.g.dap_js_opt ~= nil then
                    dap.adapters[lang] = vim.g.dap_js_opt.adapter
                    dap.configurations[lang] = vim.g.dap_js_opt.configuration
                else
                    dap.adapters[lang] = {
                        type = "server",
                        server = "localhost",
                        port = 9230,
                    }
                    dap.configurations[lang] = {
                        {
                            type = lang,
                            request = "attach",
                            name = "Attach to Node Debugger",
                        },
                        {
                            type = "pwa-chrome",
                            request = "launch",
                            name = "Launch & Debug Chrome",
                            url = "localhost:3000",
                            webRoot = vim.fn.getcwd(),
                            protocol = "inspector",
                            sourceMaps = true,
                            userDataDir = false,
                        },
                    }
                end
            end
        end,
    },
    {
        "jay-babu/mason-nvim-dap.nvim",
        dependencies = { "nvim-dap" },
    },
}
