-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

-- setup local leader
-- vim.g.maplocalleader = ","

-- Turn off backups
vim.opt.backup = false -- Disable backup files
vim.opt.writebackup = false -- Do not backup the file while editing
vim.opt.swapfile = false -- Do not create swap files for new buffers
vim.opt.updatecount = 0 -- Do not write swap files after a certain number of updates

vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- Colors
vim.opt.termguicolors = true -- Enable true color support

-- Column width
-- vim.opt.colorcolumn = "81"
vim.opt.textwidth = 80 -- Set the maximum text width to 80 characters

-- Leader
vim.g.mapleader = " " -- Set the global leader key to space
vim.g.maplocalleader = " " -- Set the local leader key to space

-- Default position
vim.opt.scrolloff = 12 -- Number of lines to keep in view above and below the cursor

-- Ex line
vim.o.ls = 0 -- Disable line splitting for Ex commands
vim.o.ch = 0 -- Disable command line history

-- Preview of snippets
vim.opt.completeopt = { "menuone", "noselect", "noinsert" } -- Set the completion options
vim.opt.pumblend = 0 -- Popup menu transparency level

-- Search
vim.opt.hlsearch = false -- Disable highlight search results
vim.opt.incsearch = true -- Incremental search
vim.opt.ignorecase = true -- Ignore case when searching

-- Gutter
vim.opt.number = false -- Show line numbers
vim.opt.relativenumber = false -- Show relative line numbers
vim.opt.cursorline = true -- Enable highlighting of the current line

-- Set up indentation options
vim.opt.expandtab = false -- Use spaces instead of tabs for indentation
vim.opt.tabstop = 4 -- Set the number of spaces a tab character represents
vim.opt.softtabstop = 4 -- Set the number of spaces for each step of indentation
vim.opt.shiftwidth = 4 -- Set the number of spaces used for indentation
vim.opt.smartindent = true -- Enable smart indentation based on code syntax
vim.opt.autoindent = true -- Enable automatic indentation of new lines

-- Backup
-- vim.opt.backup = false
-- vim.opt.swapfile = false
-- vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
-- vim.opt.undofile = true

-- Spelling
vim.opt.spell = false -- Disable spell checking
vim.opt.spelllang = { "en_us" } -- Set the spelling language to US English

-- Misc
-- vim.opt.guicursor = ""
vim.opt.guicursor = "n-v-c-sm:block,i-ci-ve:ver25-Cursor,r-cr-o:hor20" -- Set the cursor shape and blink style
vim.opt.isfname:append("@-@") -- Allow filenames with special characters
vim.opt.signcolumn = "yes" -- Always show the sign column
vim.opt.updatetime = 50 -- Set the time interval for writing swap files and updating changes
vim.opt.wrap = false -- Disable line wrapping

-- Set to "basedpyright" to use basedpyright instead of pyright.
-- vim.g.lazyvim_python_lsp = "basedpyright"

-- clipboard
vim.opt.clipboard = ""
