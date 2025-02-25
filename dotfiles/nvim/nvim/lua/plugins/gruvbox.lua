return {
    -- Add gruvbox-material plugin
    {
        "sainnhe/gruvbox-material",
        priority = 1000, -- Ensures it loads first
        config = function()
            -- Global variables for gruvbox-material
            vim.g.gruvbox_material_enable_bold = 1
            vim.g.gruvbox_material_background = "hard"
            vim.g.gruvbox_material_foreground = "mix"
            -- vim.g.gruvbox_material_sign_column_background = "grey"
            vim.g.gruvbox_material_show_eob = 0
            vim.g.gruvbox_material_diagnostic_text_highlight = 1
            vim.g.gruvbox_material_diagnostic_line_highlight = 1
            vim.g.gruvbox_material_diagnostic_virtual_text = "colored"
            vim.g.gruvbox_material_statusline_style = "mix"

            vim.g.gruvbox_material_colors_override = {
                markbg1 = { "#3a2424", "60" },
                markbg2 = { "#3e301e", "100" },
                markbg3 = { "#443828", "110" },
                markbg4 = { "#2d3d20", "30" },
                markbg5 = { "#24332f", "31" },
                markbg6 = { "#3a2428", "60" },
            }

            -- Autocommand for setting highlights
            vim.api.nvim_create_autocmd("ColorScheme", {
                group = vim.api.nvim_create_augroup("custom_highlights_gruvboxmaterial", {}),
                pattern = "gruvbox-material",
                callback = function()
                    local config = vim.fn["gruvbox_material#get_configuration"]()
                    local palette = vim.fn["gruvbox_material#get_palette"](config.background, config.foreground, config.colors_override)
                    local set_hl = vim.fn["gruvbox_material#highlight"]
                    local setHl = function(...)
                        vim.api.nvim_set_hl(0, ...)
                    end
                    local hlCmd = vim.cmd.highlight
                    set_hl("RenderMarkdownH1Bg", palette.none, palette.markbg1)
                    set_hl("RenderMarkdownH2Bg", palette.none, palette.markbg2)
                    set_hl("RenderMarkdownH3Bg", palette.none, palette.markbg3)
                    set_hl("RenderMarkdownH4Bg", palette.none, palette.markbg4)
                    set_hl("RenderMarkdownH5Bg", palette.none, palette.markbg5)
                    set_hl("RenderMarkdownH6Bg", palette.none, palette.markbg6)

                    --  General
                    -- setHl("TSParameter", { fg = "#83a598" })
                    -- setHl("TSConstant", { fg = "#d3869b" })
                    setHl("@character.printf", { link = "yellow" })
                    setHl("@string.documentation.python", { link = "Comment" })
                    setHl("@keyword.return", { bold = true, fg = "#f6843a" })
                    setHl("TSPunctBracket", { fg = "#af7e5d" })
                    vim.defer_fn(function()
                        setHl("@constructor.lua", { fg = "#9b97a8" })
                    end, 1)

                    -- cursorword
                    setHl("LspReferenceWrite", { underdashed = true })
                    setHl("LspReferenceRead", { underdotted = true })
                    setHl("LspReferenceText", {})

                    -- avante
                    setHl("AvanteConflictIncoming", { bg = "#4a5a2a" })
                    setHl("AvanteConflictCurrent", { bg = "#5c2f2e" })

                    -- : no undercurls
                    hlCmd("DiagnosticUnderlineError gui=underline")
                    hlCmd("DiagnosticUnderlineWarn gui=underline")
                    hlCmd("DiagnosticUnderlineInfo gui=underline")
                    hlCmd("DiagnosticUnderlineHint gui=underline")
                    hlCmd("SpellBad gui=underdotted")
                    hlCmd("SpellError gui=underdotted")
                    hlCmd("SpellCap gui=underdotted")
                    hlCmd("SpellLocal gui=underdotted")

                    -- no overly excessive underlines/bold
                    hlCmd("ErrorMsg gui=none")
                    hlCmd("WarningMsg gui=none")

                    -- missing snacks.nvim highlights for trace
                    setHl("SnacksNotifierTitleTrace", { link = "NotifyTraceTitle" })
                    setHl("SnacksNotifierTitleIcon", { link = "NotifyTraceIcon" })
                    setHl("SnacksNotifierTitleBorder", { link = "NotifyTraceBorder" })
                    setHl("SnacksNotifierTitleFooter", { link = "NotifyTraceBorder" })

                    -- lazy.nvim,
                    setHl("Bold", { bold = true })
                    setHl("LazyReasonRequire", { link = "@variable.parameter" })
                end,
            })

            -- Apply the colorscheme
            vim.cmd.colorscheme("gruvbox-material")
        end,
    },

    -- LazyVim configuration
    {
        "LazyVim/LazyVim",
        opts = {
            colorscheme = "gruvbox-material",
        },
    },
}
