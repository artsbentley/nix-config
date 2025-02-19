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

        code = {
            border = "thick",
            right_pad = 0.4,
        },

        checkbox = {
            enabled = true,
            position = "inline",
            unchecked = {
                icon = "  󰄱 ",
                highlight = "RenderMarkdownUnchecked",
                scope_highlight = nil,
            },
            checked = {
                icon = "  󰱒 ",
                highlight = "RenderMarkdownChecked",
                scope_highlight = nil,
            },
            checkbox = {
                checked = { scope_highlight = "@markup.strikethrough" },
            },

            custom = {
                todo = { raw = "[-]", rendered = "󰥔 ", highlight = "RenderMarkdownTodo", scope_highlight = nil },
            },
        },

        pipe_table = { preset = "heavy", style = "normal" },

        heading = {
            enabled = true,
            sign = true,
            position = "overlay",
            icons = { "󰲡  ", "󰲣  ", "󰲥  ", "󰲧  ", "󰲩  ", "󰲫  " },
            -- signs = { "󰫎 " },
            signs = { "" },
            -- width = "block",
            width = "level",
            left_margin = 0,
            left_pad = 0,
            -- right_pad = 0.6,
            min_width = 1,
            border = false,
            border_virtual = true,
            border_prefix = false,
            above = "_",
            -- above = "",
            -- below = "",
            -- below = "-",
            backgrounds = {
                "RenderMarkdownH1Bg",
                "RenderMarkdownH2Bg",
                "RenderMarkdownH3Bg",
                "RenderMarkdownH4Bg",
                "RenderMarkdownInfo",
                "RenderMarkdownH6Bg",
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
