return {
    "folke/trouble.nvim",
    keys = {
        { "L", "<cmd>Trouble diagnostics toggle focus=true filter.severity=vim.diagnostic.severity.ERROR<cr>", desc = "Diagnostics (Trouble)" },
    },
    opts = {
        modes = {
            test = {
                mode = "diagnostics",
                preview = {
                    type = "split",
                    relative = "win",
                    position = "right",
                    size = 0.3,
                },
            },
        },
    },
}
