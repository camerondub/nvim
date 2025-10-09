return {
    {
        "folke/lazydev.nvim", -- configure lua LSP for neovim config, runtime, plugins
        ft = "lua",
        opts = {
            library = {
                { path = "luvit-meta/library", words = { "vim%.uv" } },
            },
        },
    },
    {
        "Bilal2453/luvit-meta",
        lazy = true,
    },
    {
        "neovim/nvim-lspconfig", -- main LSP configuration
        dependencies = {
            { "mason-org/mason.nvim", config = true }, -- lsp/tool installer
            "mason-org/mason-lspconfig.nvim",
            { "j-hui/fidget.nvim", opts = {} }, -- useful status updates for LSP
            "hrsh7th/cmp-nvim-lsp", -- allows extra capabilities provided by nvim-cmp
        },
        config = function()
            vim.api.nvim_create_autocmd("LspAttach", {
                group = vim.api.nvim_create_augroup("kickstart-lsp-attach", { clear = true }),
                callback = function(event)
                    local map = function(keys, func, desc, mode)
                        mode = mode or "n"
                        vim.keymap.set(
                            mode,
                            keys,
                            func,
                            { buffer = event.buf, desc = "LSP: " .. desc }
                        )
                    end

                    map("gd", require("telescope.builtin").lsp_definitions, "[G]oto [D]efinition")
                    map("gr", require("telescope.builtin").lsp_references, "[G]oto [R]eferences")
                    map(
                        "gI",
                        require("telescope.builtin").lsp_implementations,
                        "[G]oto [I]mplementation"
                    )
                    map(
                        "<leader>sD",
                        require("telescope.builtin").lsp_type_definitions,
                        "Search Type Definitions"
                    )
                    map(
                        "<leader>sd",
                        require("telescope.builtin").lsp_document_symbols,
                        "Search Document Symbols"
                    )
                    map(
                        "<leader>sy",
                        require("telescope.builtin").lsp_dynamic_workspace_symbols,
                        "Workspace Symbols"
                    )
                    map("<leader>ln", vim.lsp.buf.rename, "LSP Rename")
                    map("<leader>la", vim.lsp.buf.code_action, "LSP Code Action", { "n", "x" })
                    map("<leader>lr", "<CMD>LspRestart<CR>", "Restart LSP", { "n", "x" })
                    map("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")

                    -- highlight references of word under cursor temporarily
                    local client = vim.lsp.get_client_by_id(event.data.client_id)
                    if
                        client
                        and client.supports_method(
                            vim.lsp.protocol.Methods.textDocument_documentHighlight
                        )
                    then
                        local highlight_augroup = vim.api.nvim_create_augroup(
                            "kickstart-lsp-highlight",
                            { clear = false }
                        )
                        vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
                            buffer = event.buf,
                            group = highlight_augroup,
                            callback = vim.lsp.buf.document_highlight,
                        })

                        vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
                            buffer = event.buf,
                            group = highlight_augroup,
                            callback = vim.lsp.buf.clear_references,
                        })

                        vim.api.nvim_create_autocmd("LspDetach", {
                            group = vim.api.nvim_create_augroup(
                                "kickstart-lsp-detach",
                                { clear = true }
                            ),
                            callback = function(event2)
                                vim.lsp.buf.clear_references()
                                vim.api.nvim_clear_autocmds({
                                    group = "kickstart-lsp-highlight",
                                    buffer = event2.buf,
                                })
                            end,
                        })
                    end

                    if
                        client
                        and client.supports_method(vim.lsp.protocol.Methods.textDocument_inlayHint)
                    then
                        map("<leader>th", function()
                            vim.lsp.inlay_hint.enable(
                                not vim.lsp.inlay_hint.is_enabled({ bufnr = event.buf })
                            )
                        end, "[T]oggle Inlay [H]ints")
                    end
                end,
            })

            -- broadcast to language servers our expanded capabilities
            local capabilities = vim.lsp.protocol.make_client_capabilities()
            capabilities = vim.tbl_deep_extend(
                "force",
                capabilities,
                require("cmp_nvim_lsp").default_capabilities()
            )

            -- automatically install the following language servers
            local servers = {
                pyright = {
                    settings = {
                        python = {
                            analysis = {
                                autoSearchPaths = true,
                                diagnosticMode = "openFilesOnly",
                                useLibraryCodeForTypes = true,
                                diagnosticSeverityOverrides = {
                                    reportPrivateImportUsage = "none",
                                    reportOptionalMemberAccess = "none",
                                },
                            },
                        },
                    },
                },

                lua_ls = {
                    settings = {
                        Lua = {
                            completion = {
                                callSnippet = "Replace",
                            },
                        },
                    },
                },
            }

            require("mason").setup()

            local server_names = vim.tbl_keys(servers or {})

            require("mason-lspconfig").setup({
                ensure_installed = server_names,
            })

            for k, v in pairs(servers) do
                vim.lsp.config(k, v)
            end
        end,
    },
}
