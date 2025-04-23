-- return {}
return {
    "L3MON4D3/LuaSnip",
    config = function()
        for _, ft_path in ipairs(vim.api.nvim_get_runtime_file("/snippets/*.lua", true)) do
            loadfile(ft_path)()
        end

        -- vim.keymap.set({ "i", "s" }, "<c-k>", function()
        --     return vim.snippet.active({ direction = 1 }) and vim.snippet.jump(1)
        -- end, { silent = true })
        --
        -- vim.keymap.set({ "i", "s" }, "<c-j>", function()
        --     return vim.snippet.active({ direction = -1 }) and vim.snippet.jump(-1)
        -- end, { silent = true })
    end,
}
