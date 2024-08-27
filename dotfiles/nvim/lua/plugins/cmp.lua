return {
    {
        "hrsh7th/nvim-cmp",
        event = { "InsertEnter", "CmdLineEnter" },
        config = function()
            local cmp = require("cmp")
            local lspkind = require("lspkind")
            -- lspkind.init({
            --     symbol_map = {
            --         Copilot = "",
            --     },
            -- })
            local types = require("cmp.types")
            local compare = require("cmp.config.compare")
            cmp.setup({
                preselect = types.cmp.PreselectMode.None,
                enabled = function()
                    if vim.bo.buftype == "prompt" then
                        return false
                    end

                    return true
                end,
                window = {
                    completion = {
                        -- winhighlight = "Normal:Pmenu,FloatBorder:Pmenu,Search:None",
                        border = "rounded",
                        -- border = nil,
                        col_offset = -3,
                        side_padding = 0,
                        scrollbar = true,
                    },
                    -- creates the corners of the window
                    documentation = cmp.config.window.bordered(),
                },
                -- matching = { -- experimental, see: https://www.reddit.com/r/neovim/comments/12mgt11/cmp_settings_that_most_do_not_know/
                --     disallow_fuzzy_matching = true,
                --     disallow_fullfuzzy_matching = true,
                --     disallow_partial_fuzzy_matching = true,
                --     disallow_partial_matching = true,
                --     disallow_prefix_unmatching = false,
                -- },
                -- formatting = {
                --     fields = { "kind", "abbr", "menu" },
                --     format = function(entry, vim_item)
                --         local kind = lspkind.cmp_format({
                --             mode = "symbol_text",
                --             menu = {
                --                 luasnip = "[Snip]",
                --                 nvim_lsp = "[LSP]",
                --                 nvim_lsp_signature_help = "[Sign]",
                --                 nvim_lua = "[Lua]",
                --                 emoji = "[Emoji]",
                --                 buffer = "[Buf]",
                --                 copilot = "[Copilot]",
                --                 crates = "[Crate]",
                --                 path = "[Path]",
                --                 cmdline = "[Cmd]",
                --                 cmdline_history = "[Hist]",
                --                 git = "[Git]",
                --                 conventionalcommits = "[Conv]",
                --                 calc = "[Calc]",
                --             },
                --         })(entry, vim_item)
                --         local strings = vim.split(kind.kind, "%s", { trimempty = true })
                --         kind.kind = " " .. strings[1] .. " "
                --         return kind
                --     end,
                -- },
                formatting = {
                    format = function(_, item)
                        local icons = require("lazyvim.config").icons.kinds
                        if icons[item.kind] then
                            item.kind = icons[item.kind] .. item.kind
                        end
                        return item
                    end,
                },
                snippet = {
                    expand = function(args)
                        require("luasnip").lsp_expand(args.body)
                    end,
                },
                -- completion = { completeopt = "menu,menuone,noinsert,noselect" },
                completion = { completeopt = "menu, menuone, noinsert, noselect" },
                -- mapping = require("pynappo/keymaps").cmp.insert(),
                mapping = cmp.mapping.preset.insert({
                    ["<C-u>"] = cmp.mapping.scroll_docs(-4),
                    ["<C-d>"] = cmp.mapping.scroll_docs(4),
                    ["<C-Space>"] = cmp.mapping.complete(),
                    -- ["<Tab>"] = cmp.mapping.confirm({ select = true }),
                    ["<CR>"] = cmp.config.disable,
                    -- ["<C-p>"] = cmp.mapping.select_prev_item(),
                    -- ["<C-n>"] = cmp.mapping.select_next_item(),
                    ["<Left>"] = cmp.mapping.abort(),
                    ["<Right>"] = cmp.mapping.confirm({
                        -- fix for correct python indenting after suggestion acceptance
                        behavior = cmp.ConfirmBehavior.Replace,
                        select = false,
                    }),
                }),
                sources = cmp.config.sources({
                    { name = "nvim_lsp" },
                    { name = "luasnip" },
                    { name = "crates" },
                    { name = "emoji" },
                    { name = "calc" },
                    -- { name = "copilot" },
                    { name = "path" },
                    { name = "nvim_lua" },
                    -- { max_item_count = 4 },
                }, {
                    {
                        name = "buffer",
                        option = {
                            get_bufnrs = function()
                                local bufs = {}
                                for _, win in ipairs(vim.api.nvim_list_wins()) do
                                    bufs[vim.api.nvim_win_get_buf(win)] = true
                                end
                                return vim.tbl_keys(bufs)
                            end,
                        },
                    },
                }),
                sorting = {
                    comparators = {
                        function(...)
                            return require("cmp_buffer"):compare_locality(...)
                        end,
                        compare.offset,
                        compare.exact,
                        compare.score,
                        compare.recently_used,
                        compare.locality,
                        compare.kind,
                        compare.sort_text,
                        compare.length,
                        compare.order,
                    },
                },
                view = { entries = { name = "custom", selection_order = "near_cursor" } },
                experimental = { ghost_text = true },
            })

            cmp.setup.filetype("gitcommit", {
                sources = cmp.config.sources({
                    { name = "git" },
                    { name = "buffer" },
                    { name = "conventionalcommits" },
                    { name = "luasnip" },
                }),
            })
            -- cmp.setup.cmdline(":", {
            --     confirmation = { completeopt = "menu,menuone,noinsert" },
            --     sources = cmp.config.sources({
            --         { name = "cmdline" },
            --         { name = "cmdline_history" },
            --         { name = "path" },
            --     }),
            -- })
            cmp.setup.cmdline("/", {
                sources = {
                    { name = "buffer" },
                },
            })
        end,
        dependencies = {
            "onsails/lspkind.nvim",
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-nvim-lua",
            "hrsh7th/cmp-calc",
            "hrsh7th/cmp-path",
            "hrsh7th/cmp-cmdline",
            "dmitmel/cmp-cmdline-history",
            "hrsh7th/cmp-emoji",
            "hrsh7th/cmp-nvim-lsp",
            "f3fora/cmp-spell",
            "hrsh7th/cmp-nvim-lsp-document-symbol",
            "octaltree/cmp-look",
            "hrsh7th/cmp-nvim-lsp-signature-help",
            "davidsierradz/cmp-conventionalcommits",
            {
                "L3MON4D3/LuaSnip",
                config = function()
                    require("luasnip.loaders.from_vscode").lazy_load()
                end,
                dependencies = {
                    "rafamadriz/friendly-snippets",
                    "saadparwaiz1/cmp_luasnip",
                },
            },
        },
    },
    -- {
    --     "zbirenbaum/copilot-cmp",
    --     event = { "BufRead", "BufNewFile" },
    --     dependencies = {
    --         {
    --             "zbirenbaum/copilot.lua",
    --             config = function()
    --                 require("copilot").setup()
    --             end,
    --         },
    --     },
    --     config = function()
    --         require("copilot_cmp").setup()
    --     end,
    -- },
    {
        "petertriho/cmp-git",
        ft = { "gitcommit", "gitrebase", "octo" },
        dependencies = { "nvim-lua/plenary.nvim" },
        config = function()
            require("cmp_git").setup()
        end,
    },
    -- {
    --     "saecki/crates.nvim",
    --     event = "BufRead Cargo.toml",
    --     dependencies = { "nvim-lua/plenary.nvim" },
    --     config = function()
    --         require("crates").setup()
    --     end,
    -- },
}
