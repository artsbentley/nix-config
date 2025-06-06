return {
    "andrewferrier/debugprint.nvim",
    opts = {
        version = "*",
        -- create_keymaps = false,
        -- create_commands = false,
        display_counter = false,
        print_tag = "🚀 ",
        keymaps = {
            normal = {
                plain_below = "<leader>ip",
                -- plain_above = "g?P",
                variable_below = "<leader>iv",
                variable_above = "<leader>iV",
                -- variable_below_alwaysprompt = "",
                -- variable_above_alwaysprompt = "",
                -- surround_plain = "g?sp",
                -- surround_variable = "g?sv",
                -- surround_variable_alwaysprompt = "",
                -- textobj_below = "g?o",
                -- textobj_above = "g?O",
                -- textobj_surround = "g?so",
                -- toggle_comment_debug_prints = "",
                delete_debug_prints = "<leader>iD",
            },
            insert = {
                plain = "<C-G>p",
                variable = "<C-G>v",
            },
            visual = {
                variable_below = "g?v",
                variable_above = "g?V",
            },
        },
        -- … Other options
    },
}

-- return {
--     "andrewferrier/debugprint.nvim",
--     config = function()
--         require("debugprint").setup({
--             create_keymaps = false,
--             create_commands = false,
--             display_counter = false,
--             print_tag = "🚀 ",
--             keymaps = {
--                 normal = {
--                     -- plain_below = "g?p",
--                     -- plain_above = "g?P",
--                     variable_below = "g?iV",
--                     variable_above = "g!iv",
--                     -- variable_below_alwaysprompt = "",
--                     -- variable_above_alwaysprompt = "",
--                     -- surround_plain = "g?sp",
--                     -- surround_variable = "g?sv",
--                     -- surround_variable_alwaysprompt = "",
--                     -- textobj_below = "g?o",
--                     -- textobj_above = "g?O",
--                     -- textobj_surround = "g?so",
--                     -- toggle_comment_debug_prints = "",
--                     -- delete_debug_prints = "",
--                 },
--             },
--         })
--     end,
--     dependencies = { "echasnovski/mini.nvim", "nvim-treesitter/nvim-treesitter" },
--     -- keys = {
--     --     {
--     --         "<leader>iV",
--     --         function()
--     --             return require("debugprint").debugprint({ above = true, variable = true })
--     --         end,
--     --         desc = "[i]nsert [V]ariable debug-print above the current line",
--     --         expr = true,
--     --         mode = { "n", "v" },
--     --     },
--     --     {
--     --         "<leader>iv",
--     --         function()
--     --             return require("debugprint").debugprint({ above = false, variable = true })
--     --         end,
--     --         desc = "[i]nsert [v]ariable debug-print below the current line",
--     --         expr = true,
--     --         mode = { "n", "v" },
--     --     },
--     -- },
--     display_snippet = false,
--     commands = {
--         toggle_comment_debug_prints = "ToggleCommentDebugPrints",
--         delete_debug_prints = "DeleteDebugPrints",
--     },
--     version = "*",
-- }
