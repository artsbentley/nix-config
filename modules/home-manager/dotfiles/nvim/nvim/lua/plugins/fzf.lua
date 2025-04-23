return {
    "ibhagwan/fzf-lua",
    lazy = true,
    opts = {
        fzf = {
            ["ctrl-s"] = "select-all",
            ["ctrl-d"] = "preview-page-down",
            ["ctrl-u"] = "preview-page-up",
            -- ["ctrl-n"] = "toggle-mode",
        },
    },
    -- opts = function(_, opts)
    --     local config = require("fzf-lua.config")
    --
    --     -- Quickfix
    --     config.defaults.keymap.fzf["ctrl-q"] = "select-all+accept"
    --     config.defaults.keymap.fzf["ctrl-n"] = "jump"
    --     config.defaults.keymap.fzf["ctrl-d"] = "preview-page-down"
    --     config.defaults.keymap.fzf["ctrl-u"] = "preview-page-up"
    --     -- config.defaults.keymap.builtin["<c-f>"] = "preview-page-down"
    --     -- config.defaults.keymap.builtin["<c-b>"] = "preview-page-up"
    -- end,

    -- opts = {
    --     winopts = {
    --         -- split = "belowright 10new",
    --         -- border = "single",
    --         preview = {
    --             -- hidden = "hidden",
    --             -- border = "border",
    --             -- title = false,
    --             -- layout = "horizontal",
    --             -- horizontal = "right:50%",
    --         },
    --     },
    -- },
}
