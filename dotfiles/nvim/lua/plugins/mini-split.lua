return {
    "echasnovski/mini.splitjoin",
    config = function()
        require("mini.splitjoin").setup({--[[ your config ]]
            -- use_default_keymaps = false,
            mappings = {
                toggle = "<leader>M",
            },
        })
    end,
}
