return {
    "DreamMaoMao/yazi.nvim",
    lazy = false,
    -- priority = 1000.
    dependencies = {
        "nvim-telescope/telescope.nvim",
        "nvim-lua/plenary.nvim",
    },

    keys = {
        { "<leader>ba", "<cmd>Yazi<CR>", desc = "Toggle Yazi" },
    },
}
