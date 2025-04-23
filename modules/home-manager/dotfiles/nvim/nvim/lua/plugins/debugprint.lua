return {
    "andrewferrier/debugprint.nvim",
    config = function()
        require("debugprint").setup({
            create_keymaps = false,
            create_commands = false,
            display_counter = false,
            print_tag = "🚀 ",
        })
    end,
    dependencies = { "echasnovski/mini.nvim", "nvim-treesitter/nvim-treesitter" },
    keys = {
        {
            "<leader>iV",
            function()
                return require("debugprint").debugprint({ above = true, variable = true })
            end,
            desc = "[i]nsert [V]ariable debug-print above the current line",
            expr = true,
            mode = { "n", "v" },
        },
        {
            "<leader>iv",
            function()
                return require("debugprint").debugprint({ above = false, variable = true })
            end,
            desc = "[i]nsert [v]ariable debug-print below the current line",
            expr = true,
            mode = { "n", "v" },
        },
    },
    display_snippet = false,
    commands = {
        toggle_comment_debug_prints = "ToggleCommentDebugPrints",
        delete_debug_prints = "DeleteDebugPrints",
    },
    version = "1.*",
}
