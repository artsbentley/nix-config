return {
    "catppuccin/nvim",
    name = "catppuccin",
    event = "VeryLazy",
    config = function()
        require("catppuccin").setup({

            styles = {
                comments = { "italic" },
                conditionals = { "italic" },
                loops = {},
                functions = { "bold" },
                keywords = {},
                strings = {},
                variables = {},
                numbers = {},
                booleans = {},
                properties = {},
                types = {},
                operators = {},
            },

            -- currently breaks styles entirely
            -- no_italic = "false",
            -- no_bold = "false",

            flavour = "mocha", -- latte, frappe, macchiato, or mocha
            transparent_background = true,
            color_overrides = {
                all = {
                    -- surface0 = "#444444",
                    -- surface1 = "#666666",
                    -- surface2 = "#a3a7bc",
                    -- surface3 = "#a3a7bc",
                },
            },
            integrations = {
                cmp = true,
                gitsigns = true,
                harpoon = true,
                telescope = true,
            },
        })
    end,
}

-- return {
--     "catppuccin/nvim",
--     name = "catppuccin",
--     event = "VeryLazy",
--     opts = {
--         styles = {
--             comments = { "italic" },
--             conditionals = { "italic" },
--             loops = {},
--             functions = { "bold" },
--             keywords = {},
--             strings = {},
--             variables = {},
--             numbers = {},
--             booleans = {},
--             properties = {},
--             types = {},
--             operators = {},
--         },
--         flavour = "mocha", -- latte, frappe, macchiato, or mocha
--         transparent_background = true,
--         color_overrides = {
--             all = {
--                 -- surface0 = "#444444",
--                 -- surface1 = "#666666",
--                 -- surface2 = "#a3a7bc",
--                 -- surface3 = "#a3a7bc",
--             },
--         },
--         integrations = {
--             cmp = true,
--             gitsigns = true,
--             harpoon = true,
--             telescope = true,
--         },
--     },
-- }
