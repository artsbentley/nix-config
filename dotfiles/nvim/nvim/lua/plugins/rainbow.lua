return {
    "HiPhish/rainbow-delimiters.nvim",
    config = function()
        local highlight = {
            "RainbowDelimiterRed",
            "RainbowDelimiterViolet",
            "RainbowDelimiterYellow",
            "RainbowDelimiterBlue",
            "RainbowDelimiterOrange",
            "RainbowDelimiterGreen",
            "RainbowDelimiterCyan",
        }
        -- original order:
        -- 'RainbowDelimiterRed',
        --       'RainbowDelimiterYellow',
        --       'RainbowDelimiterBlue',
        --       'RainbowDelimiterOrange',
        --       'RainbowDelimiterGreen',
        --       'RainbowDelimiterViolet',
        --       'RainbowDelimiterCyan',

        vim.g.rainbow_delimiters = { highlight = highlight }
    end,
}
