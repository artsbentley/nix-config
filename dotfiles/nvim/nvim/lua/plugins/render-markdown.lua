return {
    "MeanderingProgrammer/render-markdown.nvim",
    opts = {
        indent = {
            -- Turn on / off org-indent-mode
            enabled = true,
            -- Amount of additional padding added for each heading level
            per_level = 2,
            -- Heading levcls <= this value will not be indented
            -- Use 0 to begin indenting from the very first level
            skip_level = 1,
            -- Do not indent heading titles, only the body
            skip_heading = false,
        },
        heading = {
            enabled = true,
            sign = true,
            position = "overlay",
            -- icons = { "󰲡 ", "󰲣 ", "󰲥 ", "󰲧 ", "󰲩 ", "󰲫 " },
            signs = { "󰫎 " },
            width = "level",
            left_margin = 0,
            left_pad = 0,
            right_pad = 0,
            min_width = 1,
            border = false,
            border_virtual = false,
            border_prefix = false,
            above = "▄",
            below = "▀",
            backgrounds = {
                "CursorLine",
                "nothing",
                -- "RenderMarkdownH1Bg",
                -- "RenderMarkdownH2Bg",
                -- "RenderMarkdownH3Bg",
                -- "RenderMarkdownH4Bg",
                -- "RenderMarkdownH5Bg",
                -- "RenderMarkdownH6Bg",
            },
            foregrounds = {
                "RenderMarkdownH1",
                "RenderMarkdownH2",
                "RenderMarkdownH3",
                "RenderMarkdownH4",
                "RenderMarkdownH5",
                "RenderMarkdownH6",
            },
        },
    },
}
