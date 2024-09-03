return {
    "andrewferrier/debugprint.nvim",
    config = function()
        require("debugprint").setup({ create_keymaps = false, create_commands = false })
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
    commands = {
        toggle_comment_debug_prints = "ToggleCommentDebugPrints",
        delete_debug_prints = "DeleteDebugPrints",
    },
    version = "1.*",
}
