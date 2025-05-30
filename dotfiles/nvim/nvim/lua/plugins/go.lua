return {
    {
        "ray-x/go.nvim",
        dependencies = { -- optional packages
            "ray-x/guihua.lua",
            "neovim/nvim-lspconfig",
            "nvim-treesitter/nvim-treesitter",
        },
        config = function()
            require("go").setup()
        end,
        keys = {
            { "<leader>goe", "<cmd>GoIfErr<cr>", desc = "Golang Error" },
            { "<leader>goi", "<cmd>GoImplements<cr>", desc = "Golang Interface Implementation" },
            { "<leader>got", "<cmd>GoAddTag<cr>", desc = "Golang Add Tag" },
        },
        event = { "CmdlineEnter" },
        ft = { "go", "gomod", "templ" },
        build = ':lua require("go.install").update_all_sync()', -- if you need to install/update all binaries
    },
    {
        "nvimtools/none-ls.nvim",
        optional = true,
        dependencies = {
            {
                "williamboman/mason.nvim",
                opts = function(_, opts)
                    opts.ensure_installed = opts.ensure_installed or {}
                    vim.list_extend(opts.ensure_installed, { "gomodifytags", "impl" })
                end,
            },
        },
        opts = function(_, opts)
            local nls = require("null-ls")
            opts.sources = vim.list_extend(opts.sources or {}, {
                nls.builtins.diagnostics.golangci_lint,
                -- nls.builtins.diagnostics.golangci_lint_langserver,
                nls.builtins.code_actions.gomodifytags,
                nls.builtins.code_actions.impl,
                nls.builtins.formatting.goimports,
                nls.builtins.formatting.gofumpt,
            })
        end,
    },
}
