-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here

vim.api.nvim_create_autocmd("BufWritePost", {
    pattern = { "*tmux.conf" },
    command = "execute 'silent !tmux source <afile> --silent'",
})

vim.api.nvim_create_autocmd("VimEnter", {
    callback = function()
        vim.cmd("NoNeckPain")
    end,
})

-- vim.api.nvim_create_autocmd({ "VimEnter" }, {
--     pattern = { "*.mdx", "*.md" },
--     callback = function()
--         vim.cmd("NoNeckPainToggleRightSide")
--     end,
-- })

-- vim.api.nvim_create_autocmd({ "VimEnter" }, {
--     pattern = "*",
--     callback = function()
--         vim.schedule(function()
--             local filetype = vim.api.nvim_buf_get_option(0, "filetype")
--             local enabled = _G.NoNeckPain.state ~= nil and _G.NoNeckPain.state.enabled
--
--             if (filetype == "markdown" and not enabled) or (filetype ~= "markdown" and enabled) then
--                 return vim.cmd("NoNeckPain")
--             end
--         end)
--     end,
-- })

vim.api.nvim_create_autocmd({ "BufNewFile", "BufFilePre", "BufRead" }, {
    pattern = { "*.mdx", "*.md" },
    callback = function()
        vim.cmd([[set filetype=markdown wrap linebreak nolist nospell]])
    end,
})

vim.api.nvim_create_autocmd({ "BufNewFile", "BufFilePre", "BufRead" }, {
    pattern = { "*.ex", "*.gleam", "*.nix", "*.tsx" },
    callback = function()
        -- vim.cmd([[set filetype=markdown wrap linebreak nolist nospell]])
        vim.opt.shiftwidth = 2
    end,
})

-- htmldjango is being set and is preventing rainbow delimiters
vim.api.nvim_create_autocmd({ "BufNewFile", "BufFilePre", "BufRead" }, {
    -- pattern = { "*.html" },
    pattern = { "*.html", "*.heex" },

    callback = function()
        vim.cmd([[set filetype=html]])
    end,
})

-- script to close all buffers that havent been "touched" source: https://www.reddit.com/r/neovim/comments/12c4ad8/closing_unused_buffers/
local id = vim.api.nvim_create_augroup("startup", {
    clear = false,
})

local persistbuffer = function(bufnr)
    bufnr = bufnr or vim.api.nvim_get_current_buf()
    vim.fn.setbufvar(bufnr, "bufpersist", 1)
end

vim.api.nvim_create_autocmd({ "BufRead" }, {
    group = id,
    pattern = { "*" },
    callback = function()
        vim.api.nvim_create_autocmd({ "InsertEnter", "BufModifiedSet" }, {
            buffer = 0,
            once = true,
            callback = function()
                persistbuffer()
            end,
        })
    end,
})

-- vim.keymap.set("n", "<Leader>bc", function()
--     local curbufnr = vim.api.nvim_get_current_buf()
--     local buflist = vim.api.nvim_list_bufs()
--     for _, bufnr in ipairs(buflist) do
--         if vim.bo[bufnr].buflisted and bufnr ~= curbufnr and (vim.fn.getbufvar(bufnr, "bufpersist") ~= 1) then
--             vim.cmd("bd " .. tostring(bufnr))
--         end
--     end
-- end, { silent = true, desc = "Close unused buffers" })

-- vim.api.nvim_create_autocmd("ColorScheme", {
--     pattern = "*",
--     callback = function()
--         vim.cmd([[ hi! link LazyGitFloat TelescopePreviewNormal ]])
--         vim.cmd([[ hi! link LazyGitBorder TelescopePreviewBorder ]])
--         vim.cmd([[ hi! link MiniFilesTitle TelescopeResultsTitle ]])
--         vim.cmd([[ hi! link MiniFilesTitleFocused TelescopePromptTitle ]])
--         vim.cmd([[ hi! link MiniFilesBorder TelescopePreviewBorder ]])
--         vim.cmd([[ hi! MatchParen guifg=NONE ]])
--     end,
-- })
