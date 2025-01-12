return {
    'mfussenegger/nvim-dap',
    dependencies = {
        {
            'rcarriga/nvim-dap-ui',
            opts = {
                icons = { expanded = '▾', collapsed = '▸', current_frame = '*' },
                controls = {
                    element = "repl",
                    enabled = false,
                    icons = {
                        pause = '⏸',
                        play = '▶',
                        step_into = '⏎',
                        step_over = '⏭',
                        step_out = '⏮',
                        step_back = 'b',
                        run_last = '▶▶',
                        terminate = '⏹',
                        disconnect = '⏏',
                    },
                },
            }
        },
        'nvim-neotest/nvim-nio',
        'williamboman/mason.nvim',
        'jay-babu/mason-nvim-dap.nvim',
    },
    keys = function(_, keys)
        local dap = require 'dap'
        local dapui = require 'dapui'
        return {
            { '<leader>dc', dap.continue, desc = 'Debug: Start/Continue' },
            { '<leader>di', dap.step_into, desc = 'Debug: Step Into' },
            { '<leader>dv', dap.step_over, desc = 'Debug: Step Over' },
            { '<leader>do', dap.step_out, desc = 'Debug: Step Out' },
            { '<leader>db', dap.toggle_breakpoint, desc = 'Debug: Toggle Breakpoint' },
            {
                '<leader>dB',
                function()
                    dap.set_breakpoint(vim.fn.input 'Breakpoint condition: ')
                end,
                desc = 'Debug: Set Breakpoint',
            },
            { '<leader>dt', dapui.toggle, desc = 'Debug: See last session result.' },
            unpack(keys),
        }
    end,
    config = function()
        local dap = require 'dap'
        local dapui = require 'dapui'

        require('mason-nvim-dap').setup {
            automatic_installation = true,
            handlers = {},
            ensure_installed = {},
        }

        dap.listeners.after.event_initialized['dapui_config'] = dapui.open
        dap.listeners.before.event_terminated['dapui_config'] = dapui.close
        dap.listeners.before.event_exited['dapui_config'] = dapui.close

    end,
}
