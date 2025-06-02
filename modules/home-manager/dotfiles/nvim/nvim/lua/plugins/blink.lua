return {
    "saghen/blink.cmp",
    opts = {
        fuzzy = {
            implementation = "prefer_rust_with_warning",
            sorts = {
                "exact",
                "score",
                "sort_text",
                -- "label",
            },
        },

        snippets = {
            preset = "luasnip",
        },
        keymap = {
            -- preset = "default",
            ["<C-u>"] = { "scroll_documentation_up" },
            ["<C-d>"] = { "scroll_documentation_down" },

            ["<Left>"] = { "cancel", "fallback" },
            ["<Right>"] = { "accept", "fallback" },

            ["<Esc>"] = {
                function(cmp)
                    cmp:cancel()
                    vim.schedule(function()
                        vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Esc>`^", true, false, true), "n", true)
                    end)
                end,
            },
        },

        cmdline = {
            enabled = true,
            completion = {
                menu = {
                    auto_show = true,
                    border = "double",
                },
                list = { selection = { preselect = false, auto_insert = false } },
            },
            keymap = {
                ["<Right>"] = { "accept", "fallback" },

                ["<Tab>"] = { "select_next", "fallback" },
                ["<Down>"] = { "select_next", "fallback" },

                ["<S-Tab>"] = { "select_prev", "fallback" },
                ["<Up>"] = { "select_prev", "fallback" },

                ["<Left>"] = { "cancel", "fallback" },
            },
        },

        completion = {
            list = { selection = { preselect = false, auto_insert = true } },
            accept = {
                create_undo_point = true,
                auto_brackets = { enabled = true },
            },
            menu = {
                border = "rounded",
                -- draw = { gap = 2 },
                -- winhighlight = "Normal:Normal,FloatBorder:FloatBorder,CursorLine:BlinkCmpMenuSelection,Search:None",
                -- winhighlight = "Normal:BlinkCmpMenu,FloatBorder:BlinkCmpMenuBorder,CursorLine:BlinkCmpMenuSelection,Search:None",
                draw = {
                    treesitter = { "lsp" },
                    columns = function(ctx)
                        local ret = { { "kind_icon" }, { "label", "label_description", gap = 1 } } -- default
                        -- Add kind, source to INSERT mode
                        if ctx.mode ~= "cmdline" then
                            table.insert(ret, { "kind", "source_name", gap = 10 })
                        end
                        return ret
                    end,
                },
                documentation = {
                    auto_show = true,
                    auto_show_delay_ms = 200,
                    window = {
                        border = "rounded",
                        -- winhighlight = "Normal:Normal,FloatBorder:FloatBorder,CursorLine:BlinkCmpDocCursorLine,Search:None",
                    },
                },
                ghost_text = {
                    enabled = true,
                    -- show_with_menu = true,
                },
            },
        },

        sources = {
            -- Remove 'buffer' if you don't want text completions, by default it's only enabled when LSP returns no items
            default = { "lsp", "path", "snippets" },

            -- needed for to disable buffer using lazyvim
            providers = {
                buffer = {
                    enabled = false,
                },
            },
        },

        signature = {
            enabled = false,
            window = {
                show_documentation = false,
            },
        },

        -- TODO: choose one
        -- snippets = { preset = "default" | "luasnip" | "mini_snippets" },

        appearance = {
            -- kind_icons = {
            --     Array = "󰅪",
            --     Class = "",
            --     Color = "󰏘",
            --     Constant = "󰏿",
            --     Constructor = "",
            --     Enum = "",
            --     EnumMember = "",
            --     Event = "",
            --     Field = "󰜢",
            --     File = "󰈙",
            --     Folder = "󰉋",
            --     Function = "󰆧",
            --     Interface = "",
            --     Keyword = "󰌋",
            --     Method = "󰆧",
            --     Module = "",
            --     Operator = "󰆕",
            --     Property = "󰜢",
            --     Reference = "󰈇",
            --     Snippet = "",
            --     Struct = "",
            --     Text = "",
            --     TypeParameter = "",
            --     Unit = "",
            --     Value = "",
            --     Variable = "󰀫",
            -- },
        },
    },
}

-- windows = {
--     autocomplete = {
--         border = "rounded",
--         min_width = 80,
--         draw = {
--             components = {
-- label = {
--     width = { fill = true, max = 60 },
--     text = function(ctx)
--         return ctx.label
--     end,
-- },
-- label_description = {
--     width = { fill = true, max = 90 },
--     text = function(ctx, package)
--         local source = ctx.item.source_id
--         local client = source == "lsp" and vim.lsp.get_client_by_id(ctx.item.client_id).name
--
--         local formattedPackage
--         if source == "lsp" and client == "jdtls" then
--             if ctx.kind == "Constructor" then
--                 if ctx.item.detail ~= nil and ctx.item.detail ~= "" then
--                     formattedPackage = ctx.item.detail:match("^[^%(]*")
--                 end
--             end
--         end
--
--         if package then
--             return package
--         elseif formattedPackage then
--             return formattedPackage
--         elseif ctx.label_description ~= nil and ctx.label_description ~= "" then
--             return ctx.label_description
--         else
--             return ""
--         end
--     end,
-- },
--             },
--         },
--     },
--     documentation = {
--         auto_show = true,
--         auto_show_delay_ms = 50,
--         border = "rounded",
--     },
--     signature_help = {
--         border = "rounded",
--     },
-- -- },
--
-- menu = {
--     min_width = 15,
--     max_height = 10,
--     border = "rounded",
--     scrollbar = true,
--     columns = {
--         { "kind_icon" },
--         { "label", "label_description", gap = 1 },
--     },
-- },
