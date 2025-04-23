return {
    "yetone/avante.nvim",
    lazy = true,
    event = "VeryLazy",
    enabled = true,
    -- version = false, -- set this if you want to always pull the latest change

    opts = {
        vim.api.nvim_create_autocmd("FileType", {
            pattern = "avante",
            callback = function()
                -- Map <Esc> to quit after ensuring we're in normal mode
                vim.keymap.set({ "n" }, "<Esc>", "<Cmd>stopinsert | bd!<CR>", { buffer = true })
            end,
        }),
        build = "make",
        -- provider = "deepseek",
        provider = "openai",
        cursor_applying_provider = "openai",
        openai = {
            endpoint = "https://api.openai.com/v1",
            -- model = "gpt-4.1",
            model = "gpt-4o",
            timeout = 30000, -- Timeout in milliseconds, increase this for reasoning models
            temperature = 0,
            -- max_completion_tokens = 8192, -- Increase this to include reasoning tokens (for reasoning models)
            --reasoning_effort = "medium", -- low|medium|high, only used for reasoning models
        },
        vendors = {
            deepseek = {
                __inherited_from = "openai",
                api_key_name = "DEEPSEEK_API_KEY",
                endpoint = "https://api.deepseek.com",
                model = "deepseek-coder",
                -- max_tokens = 8192,
            },
        },
        behaviour = {
            auto_suggestions = false, -- Experimental stage
            auto_set_highlight_group = true,
            auto_set_keymaps = true,
            auto_apply_diff_after_generation = false,
            support_paste_from_clipboard = false,
            minimize_diff = true, -- Whether to remove unchanged lines when applying a code block
            enable_token_counting = true, -- Whether to enable token counting. Default to true.
            enable_cursor_planning_mode = true, -- Whether to enable Cursor Planning Mode. Default to false.
        },
        mappings = {
            --- @class AvanteConflictMappings
            diff = {
                ours = "co",
                theirs = "ct",
                all_theirs = "ca",
                both = "cb",
                cursor = "cc",
                next = "]x",
                prev = "[x",
            },
            suggestion = {
                accept = "<M-l>",
                next = "<M-]>",
                prev = "<M-[>",
                dismiss = "<C-]>",
            },
            jump = {
                next = "]]",
                prev = "[[",
            },
            submit = {
                normal = "<CR>",
                insert = "<C-s>",
            },
            sidebar = {
                apply_all = "A",
                apply_cursor = "a",
                retry_user_request = "r",
                edit_user_request = "e",
                switch_windows = "<Tab>",
                reverse_switch_windows = "<S-Tab>",
                remove_file = "d",
                add_file = "a",
                close = { "<Esc>", "q" },
                close_from_input = nil, -- e.g., { normal = "<Esc>", insert = "<C-d>" }
            },
        },
        hints = { enabled = false },
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
            provider = "snacks",
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
