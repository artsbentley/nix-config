return {
    "MagicDuck/grug-far.nvim",
    --- Ensure existing keymaps and opts remain unaffected
    config = function(_, opts)
        require("grug-far").setup(opts)
        vim.api.nvim_create_autocmd("FileType", {
            pattern = "grug-far",
            callback = function()
                -- Map <Esc> to quit after ensuring we're in normal mode
                vim.keymap.set({ "n" }, "<Esc>", "<Cmd>stopinsert | bd!<CR>", { buffer = true })
            end,
        })
    end,
    keys = {
        -- replace = { n = "<localleader>r" },
        -- qflist = { n = "<localleader>q" },
        -- syncLocations = { n = "<localleader>s" },
        -- syncLine = { n = "<localleader>l" },
        -- close = { n = "<localleader>c" },
        -- historyOpen = { n = "<localleader>t" },
        -- historyAdd = { n = "<localleader>a" },
        -- refresh = { n = "<localleader>f" },
        -- openLocation = { n = "<localleader>o" },
        -- openNextLocation = { n = "<C-u>" },
        -- openPrevLocation = { n = "<C-d>" },
        -- gotoLocation = { n = "<enter>" },
        -- pickHistoryEntry = { n = "<enter>" },
        -- abort = { n = "<localleader>b" },
        -- help = { n = "g?" },
        -- toggleShowCommand = { n = "<localleader>p" },
        -- swapEngine = { n = "<localleader>e" },
        -- previewLocation = { n = "<localleader>i" },
        -- swapReplacementInterpreter = { n = "<localleader>x" },
        -- applyNext = { n = "<localleader>j" },
        {
            "<leader>sr",
            function()
                local grug = require("grug-far")
                local ext = vim.bo.buftype == "" and vim.fn.expand("%:e")
                grug.open({
                    transient = true,
                    prefills = {
                        filesFilter = ext and ext ~= "" and "*." .. ext or nil,
                    },
                })
            end,
            mode = { "n", "v" },
            desc = "Search and Replace",
        },
    },
}
