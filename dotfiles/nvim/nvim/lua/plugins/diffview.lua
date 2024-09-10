return {
    "sindrets/diffview.nvim",
    dependencies = "nvim-lua/plenary.nvim",
    keys = {
        { "<leader>dd", "<cmd>DiffviewOpen<cr>", desc = "Diffview" },
        { "<leader>dq", "<cmd>DiffviewClose<cr>", desc = "Close Diffview" },
    },
    opts = {
        view = {
            use_icons = true,
            default = {
                layout = "diff2_horizontal",
                winbar_info = false, -- See ':h diffview-config-view.x.winbar_info'
            },
        },
    },
}
