return {
    "pwntester/octo.nvim",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-telescope/telescope.nvim",
        -- "folke/snacks.nvim",
        "nvim-tree/nvim-web-devicons",
    },
    cmd = { "Octo" },
    config = {
        picker = "telescope",
        enable_builtin = true,
        mappings = {
            review_diff = {
                -- NOTE: make it easy to switch between files while reviewing diffs
                select_next_entry = { lhs = "<Tab>", desc = "move to previous changed file" },
                select_prev_entry = { lhs = "<S-Tab>", desc = "move to next changed file" },
            },
        },
    },
    keys = {
        -- TODO: add Snacks support to Octo.nvim
        -- TODO: add this to the LazyVim extra (`<leader>go`?)
        { "<leader>o", "<cmd>Octo<cr>", desc = "Octo" },
    },
}
