return {
    "nvim-telescope/telescope.nvim",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "debugloop/telescope-undo.nvim",
        "danielfalk/smart-open.nvim",
    },
    config = function()
        require("telescope").setup({
            extensions = {
                undo = {
                    -- telescope-undo.nvim config, see below
                },
            },
            pickers = {
                find_files = {
                    theme = "dropdown",
                },
            },
        })
        require("telescope").load_extension("undo")
        require("telescope").load_extension("smart_open")
    end,
    keys = {
        -- { "<leader>sg", Util.telescope("live_grep"), desc = "Grep (root dir)" },
        -- { "<leader>sG", require("telescope.builtin").live_grep({ require("telescope.utils").buffer_dir() }), desc = "Grep (cwd)" },
        -- require("telescope.utils").buffer_dir() telescope.Util.telescope("live_grep", { cwd = utils.buffer_dir() }), desc = "Grep (cwd)" },
        {
            "<leader>uU",
            function()
                require("telescope").extensions.undo.undo({ layout_strategy = "vertical", side_by_side = false })
            end,
        },
        -- smart open telescope
        -- {
        --     "<leader><leader>",
        --     function()
        --         require("telescope").extensions.smart_open.smart_open()
        --     end,
        -- },
    },
}
