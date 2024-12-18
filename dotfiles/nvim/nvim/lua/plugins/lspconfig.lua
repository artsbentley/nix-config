return {
    "neovim/nvim-lspconfig",
    opts = {
        inlay_hints = { enabled = false },
        servers = {
            pyright = {
                settings = {
                    pyright = {
                        disableOrganizeImports = true, -- Using Ruff
                    },
                    python = {
                        analysis = {
                            ignore = { "*" }, -- Using Ruff
                            typeCheckingMode = "off", -- Using mypy
                        },
                    },
                },
            },
            setup = {
                ruff_lsp = function()
                    require("lazyvim.util").lsp.on_attach(function(client, _)
                        if client.name == "ruff_lsp" then
                            -- Disable hover in favor of Pyright
                            client.server_capabilities.hoverProvider = false
                        end
                    end)
                end,
            },

            -- pyright = {
            --     mason = false,
            --     autostart = false,
            -- },
            -- pyright = {
            --     capabilities = (function()
            --         local capabilities = vim.lsp.protocol.make_client_capabilities()
            --         capabilities.textDocument.publishDiagnostics.tagSupport.valueSet = { 2 }
            --         return capabilities
            --     end)(),
            --     settings = {
            --         python = {
            --             analysis = {
            --                 useLibraryCodeForTypes = true,
            --                 diagnosticSeverityOverrides = {
            --                     reportUnusedVariable = "warning", -- or anything
            --                 },
            --                 typeCheckingMode = "basic",
            --             },
            --         },
            --     },
            -- },
        },
    },
}
