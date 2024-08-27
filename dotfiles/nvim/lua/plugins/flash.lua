return {
    "folke/flash.nvim",
    event = "VeryLazy",
    vscode = true,
    ---@type Flash.Config
    opts = {
        require("flash").toggle(false),
        jump = {
            autojump = true,
        },
        label = {
            style = "inline",
        },
        highlight = {
            backdrop = false,
            matches = false,
        },
        modes = {
            char = {
                enabled = false,
            },
        },
    },

    vim.keymap.set({ "n", "x", "o" }, "<leader>t", function()
        local win = vim.api.nvim_get_current_win()
        local view = vim.fn.winsaveview()
        require("flash").jump({
            action = function(match, state)
                state:hide()
                vim.api.nvim_set_current_win(match.win)
                vim.api.nvim_win_set_cursor(match.win, match.pos)
                require("flash").treesitter()
                vim.schedule(function()
                    vim.api.nvim_set_current_win(win)
                    vim.fn.winrestview(view)
                end)
            end,
        })
    end),
    keys = {
        {
            "s",
            mode = { "n", "x", "o" },
            function()
                require("flash").jump()
            end,
            desc = "Flash",
        },
        {
            "S",
            mode = { "n", "o", "x" },
            function()
                require("flash").treesitter()
            end,
            desc = "Flash Treesitter",
        },
        {
            "r",
            mode = "o",
            function()
                require("flash").remote()
            end,
            desc = "Remote Flash",
        },
    },
}
