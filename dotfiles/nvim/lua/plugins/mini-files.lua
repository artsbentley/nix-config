-- return {}
return {
    "echasnovski/mini.files",
    event = "VeryLazy",
    opts = {
        windows = {
            preview = false,
            width_focus = 30,
            width_preview = 100,
            -- -- Width of non-focused window
            -- width_nofocus = 15,
        },
        options = {
            -- Whether to use for editing directories
            -- Disabled by default in LazyVim because neo-tree is used for that
            use_as_default_explorer = false,
        },

        mappings = {
            close = "q",
            go_in = "l",
            go_in_plus = "L",
            go_out = "h",
            go_out_plus = "H",
            reset = "<BS>",
            show_help = "g?",
            synchronize = "<Esc>:w",
            trim_left = "<",
            trim_right = ">",
        },
    },
    keys = {
        {
            "<leader>ff",
            function()
                require("mini.files").open(vim.api.nvim_buf_get_name(0), true)
            end,
            desc = "Open mini.files (directory of current file)",
        },
        {
            "<leader>fF",
            function()
                require("mini.files").open(vim.loop.cwd(), true)
            end,
            desc = "Open mini.files (cwd)",
        },
    },
    config = function(_, opts)
        require("mini.files").setup(opts)

        local show_dotfiles = true
        local filter_show = function(fs_entry)
            return true
        end
        local filter_hide = function(fs_entry)
            return not vim.startswith(fs_entry.name, ".")
        end

        local toggle_dotfiles = function()
            show_dotfiles = not show_dotfiles
            local new_filter = show_dotfiles and filter_show or filter_hide
            require("mini.files").refresh({ content = { filter = new_filter } })
        end

        vim.api.nvim_create_autocmd("User", {
            pattern = "MiniFilesBufferCreate",
            callback = function(args)
                local buf_id = args.data.buf_id
                -- Tweak left-hand side of mapping to your liking
                vim.keymap.set("n", "g.", toggle_dotfiles, { buffer = buf_id })
            end,
        })

        -- additional mappings
        local go_in_plus = function()
            for _ = 1, vim.v.count1 - 1 do
                MiniFiles.go_in()
            end
            local fs_entry = MiniFiles.get_fs_entry()
            local is_at_file = fs_entry ~= nil and fs_entry.fs_type == "file"
            MiniFiles.go_in()
            if is_at_file then
                MiniFiles.close()
            end
        end

        vim.api.nvim_create_autocmd("User", {
            pattern = "MiniFilesBufferCreate",
            callback = function(args)
                local map_buf = function(lhs, rhs)
                    vim.keymap.set("n", lhs, rhs, { buffer = args.data.buf_id })
                end

                map_buf("<CR>", go_in_plus)
                map_buf("<Right>", go_in_plus)

                map_buf("<BS>", MiniFiles.go_out)
                map_buf("<Left>", MiniFiles.go_out)

                map_buf("<Right>", MiniFiles.go_in)

                map_buf("<Esc>", MiniFiles.close)
                map_buf("<leader>e", MiniFiles.close)
                map_buf("<C-s>", MiniFiles.synchronize)
            end,
        })
        -- Add extra mappings from *MiniFiles-examples*
    end,
}
