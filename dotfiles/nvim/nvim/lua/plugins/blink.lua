return {
    "saghen/blink.cmp",
    opts = {
        keymap = {
            preset = "default",
            ["<C-u>"] = { "scroll_documentation_up" },
            ["<C-d>"] = { "scroll_documentation_down" },
            ["<Left>"] = { "cancel" },
            ["<Right>"] = { "accept" },
            -- ["<Right>"] = { "select_and_accept" },
            -- ["<Right>"] = {
            --     function(cmp)
            --         cmp.confirm({
            --             behavior = "replace",
            --             select = false,
            --         })
            --     end,
            -- },
            ["<CR>"] = {}, -- Disable CR confirmation
        },

        completion = {
            list = {
                selection = "manual", -- Matches your 'noselect' behavior
                max_items = 200, -- Your original max items
            },
            accept = {
                auto_brackets = {
                    enabled = true, -- Matches your original behavior
                },
            },
        },

        windows = {
            autocomplete = {
                border = "rounded",
                min_width = 80,
                draw = {
                    components = {
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
                    },
                },
            },
            documentation = {
                auto_show = true,
                auto_show_delay_ms = 50,
                border = "rounded",
            },
            signature_help = {
                border = "rounded",
            },
        },

        menu = {
            min_width = 15,
            max_height = 10,
            border = "rounded",
            scrollbar = true,
            columns = {
                { "kind_icon" },
                { "label", "label_description", gap = 1 },
            },
        },
    },
}
