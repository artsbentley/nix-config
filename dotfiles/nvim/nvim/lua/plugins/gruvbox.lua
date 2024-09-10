-- return {}
return {
    -- add gruvbox
    { "sainnhe/gruvbox-material" },
    -- { "eddyekofo94/gruvbox-flat.nvim" },
    priority = 1000,
    -- config = function()
    -- require("gruvbox").setup({
    --     palette_overrides = {
    --         bright_green = "#52a260",
    --     },
    -- })
    -- end,

    {
        "LazyVim/LazyVim",
        opts = {
            vim.cmd([[let g:gruvbox_material_enable_bold=1]]),

            -- colorscheme
            vim.cmd([[let g:gruvbox_material_background="hard"]]),
            vim.cmd([[let g:gruvbox_material_foreground="mix"]]),

            -- vim.cmd([[let g:gruvbox_material_sign_column_background="grey"]]),
            vim.cmd([[let g:gruvbox_material_show_eob="0"]]),

            -- diagnostics
            vim.cmd([[let g:gruvbox_material_diagnostic_text_highlight="1"]]),
            vim.cmd([[let g:gruvbox_material_diagnostic_line_highlight="1"]]),
            vim.cmd([[let g:gruvbox_material_diagnostic_virtual_text="colored"]]),

            vim.cmd([[let g:gruvbox_material_statusline_style="mix"]]),
        },
    },
}
