return {
    "andrewferrier/wrapping.nvim",
    config = function()
        require("wrapping").setup({
            notify_on_switch = true,
            auto_set_mode_filetype_allowlist = {
                "asciidoc",
                "gitcommit",
                "latex",
                "mail",
                "markdown",
                "rst",
                "tex",
                "text",
                "telekasten",
            },
        })
    end,
}
