-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- source: https://www.reddit.com/r/neovim/comments/udx0fi/telescopebuiltinlive_grep_and_operator/
-- TELESCOPE NEEDS TO BE IN THIS DIRECTORY TO MAKE PROPER ADJUSTMENTS OVER
-- LAZYVIM PREFERENCES
require("telescope").setup({
    pickers = {
        live_grep = {
            on_input_filter_cb = function(prompt)
                -- AND operator for live_grep like how fzf handles spaces with wildcards in rg
                return { prompt = prompt:gsub("%s", ".*") }
            end,
        },
        find_files = {
            theme = "dropdown",
            preview = {
                hide_on_startup = true, -- hide previewer when picker starts
            },
            sorting_strategy = "ascending",
            find_command = { "rg", "--files", "--glob", "!**/.git/*", "-L" },
        },
        git_files = {
            theme = "dropdown",
            layout_config = {
                height = 0.63,
            },
            preview = {
                hide_on_startup = true, -- hide previewer when picker starts
            },
            sorting_strategy = "ascending",
        },
    },
    defaults = {
        file_ignore_patterns = {
            ".git/",
            "node_modules",
            -- Files
            "%.a",
            "%.class",
            "%.mkv",
            "%.mp4",
            "%.o",
            "%.out",
            "%.pdf",
            "%.zip",
            -- Directories
            ".cache",
            ".git/",
            ".github/",
            ".node_modules/",
        },
        mappings = {
            i = {
                ["<C-p>"] = require("telescope.actions.layout").toggle_preview,
            },
        },
        layout_strategy = "flex",
        pickers = {
            find_files = {
                theme = "dropdown",
            },
        },
    },
})

vim.keymap.set({ "i", "s" }, "<c-k>", function()
    return vim.snippet.active({ direction = 1 }) and vim.snippet.jump(1)
end, { silent = true })

-- vim.keymap.set("i", "<C-k>", function()
--     vim.lsp.buf.signature_help()
-- end)

local trouble = require("trouble")
trouble.setup(vim.keymap.set("n", "<S-x>", "<cmd>TroubleToggle document_diagnostics<cr>"))

-- REMAP C-D and C-U to scroll only n lines at a time
vim.keymap.set("n", "<C-d>", "11<C-d>zz")
vim.keymap.set("n", "<C-u>", "11<C-u>zz")

-- REMAP next and previous search to center screen
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

vim.keymap.set("n", "<C-e>", "<cmd>cnext<CR>zz")
vim.keymap.set("n", "<C-n>", "<cmd>cprev<CR>zz")

vim.keymap.set("n", "<leader>k", "<cmd>lnext<CR>zz")
vim.keymap.set("n", "<leader>j", "<cmd>lprev<CR>zz")

-- TMUX NAVIGATOR
local nvim_tmux_nav = require("nvim-tmux-navigation")

nvim_tmux_nav.setup({
    disable_when_zoomed = true, -- defaults to false
})

vim.keymap.set("n", "<C-Left>", nvim_tmux_nav.NvimTmuxNavigateLeft)
vim.keymap.set("n", "<C-h>", nvim_tmux_nav.NvimTmuxNavigateLeft)
vim.keymap.set("i", "<C-Left>", nvim_tmux_nav.NvimTmuxNavigateLeft)
vim.keymap.set("i", "<C-h>", nvim_tmux_nav.NvimTmuxNavigateLeft)

vim.keymap.set("n", "<C-Down>", nvim_tmux_nav.NvimTmuxNavigateDown)
vim.keymap.set("n", "<C-j>", nvim_tmux_nav.NvimTmuxNavigateDown)
vim.keymap.set("i", "<C-Down>", nvim_tmux_nav.NvimTmuxNavigateDown)
vim.keymap.set("i", "<C-j>", nvim_tmux_nav.NvimTmuxNavigateDown)

vim.keymap.set("n", "<C-Up>", nvim_tmux_nav.NvimTmuxNavigateUp)
vim.keymap.set("n", "<C-k>", nvim_tmux_nav.NvimTmuxNavigateUp)
vim.keymap.set("i", "<C-Up>", nvim_tmux_nav.NvimTmuxNavigateUp)
vim.keymap.set("i", "<C-k>", nvim_tmux_nav.NvimTmuxNavigateUp)

vim.keymap.set("n", "<C-l>", nvim_tmux_nav.NvimTmuxNavigateRight)
vim.keymap.set("n", "<C-Right>", nvim_tmux_nav.NvimTmuxNavigateRight)
vim.keymap.set("i", "<C-l>", nvim_tmux_nav.NvimTmuxNavigateRight)
vim.keymap.set("i", "<C-Right>", nvim_tmux_nav.NvimTmuxNavigateRight)

vim.keymap.set("n", "<C-\\>", nvim_tmux_nav.NvimTmuxNavigateLastActive)
vim.keymap.set("n", "<C-Space>", nvim_tmux_nav.NvimTmuxNavigateNext)
vim.keymap.set("i", "<C-\\>", nvim_tmux_nav.NvimTmuxNavigateLastActive)
vim.keymap.set("i", "<C-Space>", nvim_tmux_nav.NvimTmuxNavigateNext)

-- harpoon
-- vim.keymap.set("n", "<leader>a", "<cmd>HarpoonAddFile<cr>", { desc = "Add to Harpoon" })
-- vim.keymap.set("n", "<leader>A", "<cmd>HarpoonShowMenu<cr>", { desc = "Show Harpoon" })

vim.keymap.set("n", "<S,l>", "<cmd>:b#<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<f1>", "<cmd>:b#<cr>", { desc = "Switch to last buffer", noremap = true, silent = true })
vim.keymap.set("i", "<f1>", "<cmd>:b#<cr>", { desc = "Switch to last buffer", noremap = true, silent = true })
vim.keymap.set("n", "<f2>", "<cmd>HarpoonNav1<cr>", { desc = "Harpoon Buffer 1" })
vim.keymap.set("i", "<f2>", "<cmd>HarpoonNav1<cr>", { desc = "Harpoon Buffer 1" })
vim.keymap.set("n", "<f3>", "<cmd>HarpoonNav2<cr>", { desc = "Harpoon Buffer 2" })
vim.keymap.set("i", "<f3>", "<cmd>HarpoonNav2<cr>", { desc = "Harpoon Buffer 2" })
vim.keymap.set("n", "<f4>", "<cmd>HarpoonNav3<cr>", { desc = "Harpoon Buffer 3" })
vim.keymap.set("i", "<f4>", "<cmd>HarpoonNav3<cr>", { desc = "Harpoon Buffer 3" })
vim.keymap.set("n", "<f5>", "<cmd>HarpoonNav4<cr>", { desc = "Harpoon Buffer 4" })
vim.keymap.set("i", "<f5>", "<cmd>HarpoonNav4<cr>", { desc = "Harpoon Buffer 4" })

-- LSP RESTART
vim.keymap.set("n", "<leader>cc", "<cmd>LspRestart<CR>", { desc = "Start LSP" })

-- recenter after going back and forth from position
-- vim.keymap.set("n", "<C-o>", "<C-o>zz")
-- vim.keymap.set("n", "<C-e>", "<C-e>zz")

-- YAZI
vim.keymap.set("n", "<leader>e", "<cmd>Yazi<cr>", { desc = "Open Yazi (directory of current file)" })
vim.keymap.set("n", "<leader>E", "<cmd>Yazi toggle<cr>", { desc = "Open Yazi (current work directory)" })

-- spider
-- vim.keymap.set({ "n", "o", "x" }, "w", "<cmd>lua require('spider').motion('w')<CR>", { desc = "Spider-w" })
-- vim.keymap.set({ "n", "o", "x" }, "e", "<cmd>lua require('spider').motion('e')<CR>", { desc = "Spider-w" })
vim.keymap.set({ "n", "o", "x" }, "e", "<cmd>lua require('spider').motion('w')<CR>", { desc = "Spider-w" })
vim.keymap.set({ "n", "o", "x" }, "<S-e>", "<cmd>lua require('spider').motion('b')<CR>", { desc = "Spider-b" })
-- vim.keymap.set({ "n", "o", "x" }, "b", "<cmd>lua require('spider').motion('b')<CR>", { desc = "Spider-b" })
vim.keymap.set({ "n", "o", "x" }, "ge", "<cmd>lua require('spider').motion('ge')<CR>", { desc = "Spider-ge" })

-- window split
vim.keymap.set("n", "<leader>we", "<cmd>vsplit<CR>", { desc = "Split window" })
vim.keymap.set("n", "<leader>w<S-e>", "<cmd>split<CR>", { desc = "Split window horizontal" })

-- special paste commands
vim.keymap.set("n", "<leader>pq", 'Vi"p', { desc = "paste inner quote" })
vim.keymap.set("n", "<leader>pw", "Viwp", { desc = "paste inner word" })

-- redo
vim.keymap.set("n", "U", "<C-r>")

--replace
vim.keymap.set("n", "<leader>re", ":%s/\\<<C-r><C-w>\\>/<C-r><C-w>/gcI<Left><Left><Left><Left>")

-- CIW easy
vim.keymap.set("n", "<BS>e", "l<cmd>lua require('spider').motion('b')<CR>cw")
vim.keymap.set("n", "<BS>w", "ciw")
vim.keymap.set("v", "<BS>w", "ciw")
vim.keymap.set("n", "<BS>q", 'ci"')
vim.keymap.set("v", "<BS>q", 'ci"')

-- Maintain the cursor position when yanking a visual selection
-- http://ddrscott.github.io/blog/2016/yank-without-jank/
vim.keymap.set("v", "y", "myy`hay")
vim.keymap.set("v", "Y", "myY`y")

-- clipboard
vim.keymap.set("v", "<leader>y", '"+y', { desc = "Yank to clipboard" })
vim.keymap.set("n", "y", '"+y', { noremap = true })
vim.keymap.set("v", "y", '"+y', { noremap = true })

vim.keymap.set("i", "<A-BS>", "<c-w>")
vim.keymap.set("n", "<A-BS>", "i<c-w><Esc>")

-- fold
vim.keymap.set("n", "<CR>", "za", { noremap = true, silent = true })

-- diagnostics
vim.keymap.set("n", "L", function()
    diagnostic_virtual_lines = not diagnostic_virtual_lines
    if diagnostic_virtual_lines then
        vim.diagnostic.config({
            virtual_lines = {
                enabled = true,
                severity = {
                    min = "ERROR",
                },
            },
            virtual_text = false, -- disable virtual_text when virtual_lines is enabled
        })
    else
        vim.diagnostic.config({
            virtual_lines = false,
            virtual_text = true, -- enable virtual_text when virtual_lines is disabled
        })
    end
    -- print("diagnostic virtual_lines set to " .. tostring(diagnostic_virtual_lines))
end, { desc = "Toggle diagnostic virtual_lines (disable virtual_text when enabled)" })

-- line numbers
vim.keymap.set("n", "<leader>ul", function()
    vim.opt.number = not vim.opt.number:get()
end, { desc = "Toggle Line Numbers" })

-- notes
-- vim.keymap.set("n", "<c-n><c-n>", "':e <c-r><c-w>.md'", { expr = true })

-- Map the function to a key combination (for example: <leader>wl)
