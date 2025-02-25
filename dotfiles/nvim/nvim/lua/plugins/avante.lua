return {
    "yetone/avante.nvim",
    lazy = true,
    event = "VeryLazy",
    enabled = true,
    version = false, -- set this if you want to always pull the latest change

    opts = {
        vim.api.nvim_create_autocmd("FileType", {
            pattern = "avante",
            callback = function()
                -- Map <Esc> to quit after ensuring we're in normal mode
                vim.keymap.set({ "n" }, "<Esc>", "<Cmd>stopinsert | bd!<CR>", { buffer = true })
            end,
        }),

        build = "make",
        hints = { enabled = false },
        provider = "openai",
        windows = {
            postion = "right",
            width = 40,
            sidebar_header = {
                enabled = true,
                align = "center",
                rounded = true,
            },
            input = {
                prefix = " ",
                height = 12, -- Height of the input window in vertical layout
            },
        },
        file_selector = {
            provider = "telescope",
        },
    },

    dependencies = {
        "nvim-treesitter/nvim-treesitter",
        "stevearc/dressing.nvim",
        "nvim-lua/plenary.nvim",
        "MunifTanjim/nui.nvim",
        "nvim-tree/nvim-web-devicons",
        "zbirenbaum/copilot.lua",
        {
            -- support for image pasting
            "HakonHarnes/img-clip.nvim",
            event = "VeryLazy",
            opts = {
                -- recommended settings
                default = {
                    embed_image_as_base64 = true,
                    prompt_for_file_name = true,
                    drag_and_drop = {
                        insert_mode = true,
                    },
                    -- required for Windows users
                    use_absolute_path = false,
                },
            },
        },
    },
}
