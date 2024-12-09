return {
    "HiPhish/rainbow-delimiters.nvim",
    config = function()
        local rainbow_delimiters = require("rainbow-delimiters")

        -- Define the highlight order
        local highlight = {
            "RainbowDelimiterYellow",
            "RainbowDelimiterViolet",
            "RainbowDelimiterBlue",
            "RainbowDelimiterOrange",
            "RainbowDelimiterGreen",
            "RainbowDelimiterCyan",
            "RainbowDelimiterRed",
        }
        -- original order:
        -- 'RainbowDelimiterRed',
        --       'RainbowDelimiterYellow',
        --       'RainbowDelimiterBlue',
        --       'RainbowDelimiterOrange',
        --       'RainbowDelimiterGreen',
        --       'RainbowDelimiterViolet',
        --       'RainbowDelimiterCyan',

        -- Set up the rainbow delimiters configuration
        vim.g.rainbow_delimiters = {
            strategy = {
                [""] = rainbow_delimiters.strategy["global"],
            },
            highlight = highlight,
        }
    end,
}
