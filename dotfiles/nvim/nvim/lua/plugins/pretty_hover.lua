return {
    "Fildo7525/pretty_hover",
    config = function()
        require("pretty_hover").setup({
            line = { "@brief" },
            word = { "@param", "@tparam", "@see" },
            header = { "@class" },
            stylers = { line = "**", word = "`", header = "###" },
            border = "rounded",
        })
    end,
}
