-- setup local leader
vim.g.maplocalleader = ","
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  -- bootstrap lazy.nvim
  -- stylua: ignore
  vim.fn.system({ "git", "clone", "--filter=blob:none", "https://github.com/folke/lazy.nvim.git", "--branch=stable", lazypath })
end
vim.opt.rtp:prepend(vim.env.LAZY or lazypath)

-- CUSTOM COMMANDS
--telescope
vim.api.nvim_create_autocmd("VimEnter", {
    callback = function()
        vim.cmd("NoNeckPain")
    end,
})
vim.cmd([[command! -nargs=0 GoToFile :Telescope find_files hidden=true]])
vim.cmd([[command! -nargs=0 GoToGitFile :Telescope git_files hidden=true]])
vim.cmd([[command! -nargs=0 TelescopeBuffers :lua require("telescope.builtin").buffers({ layout_strategy='vertical', layout_config={width=0.3, height=0.8}, sort_lastused = true })]])

--  Telekasten
-- vim.cmd([[command! -nargs=0 CreateNewNote :Telekasten new_note]])
-- vim.cmd([[command! -nargs=0 FindNote :Telekasten find_notes]])
-- vim.cmd([[command! -nargs=0 LiveGrepNote :Telescope live_grep cwd=$WIKI_DIR search_dirs={'$WIKI_DIR'}]])

vim.cmd([[command! -nargs=0 OpenOilCwd :Oil --float]])

-- harpoon
vim.cmd([[command! -nargs=0 HarpoonNav1 :lua require("harpoon.ui").nav_file(1)]])
vim.cmd([[command! -nargs=0 HarpoonNav2 :lua require("harpoon.ui").nav_file(2)]])
vim.cmd([[command! -nargs=0 HarpoonNav3 :lua require("harpoon.ui").nav_file(3)]])
vim.cmd([[command! -nargs=0 HarpoonNav4 :lua require("harpoon.ui").nav_file(4)]])
vim.cmd([[command! -nargs=0 HarpoonNav5 :lua require("harpoon.ui").nav_file(5)]])
vim.cmd([[command! -nargs=0 HarpoonAddFile :lua require("harpoon.mark").add_file()]])
vim.cmd([[command! -nargs=0 HarpoonShowMenu :lua require("harpoon.ui").toggle_quick_menu()]])
-- :lua require('telescope.builtin').find_files({layout_strategy='vertical',layout_config={width=0.5}})
-- vim.cmd([[command! -nargs=0 OpenOilProjectDir :Oil ]])
--

vim.api.nvim_create_autocmd("VimEnter", {
    callback = function()
        vim.cmd("NoNeckPain")
    end,
})

require("lazy").setup({
    spec = {
        -- add LazyVim and import its plugins
        { "LazyVim/LazyVim", import = "lazyvim.plugins" },
        -- import any extras modules here
        -- { import = "lazyvim.plugins.extras.lang.typescript" },
        --
        -- LANGS
        { import = "lazyvim.plugins.extras.lang.go" },
        { import = "lazyvim.plugins.extras.lang.rust" },
        { import = "lazyvim.plugins.extras.lang.python" },
        { import = "lazyvim.plugins.extras.lang.elixir" },
        { import = "lazyvim.plugins.extras.lang.gleam" },
        -- { import = "lazyvim.plugins.extras.lang.scala" },
        { import = "lazyvim.plugins.extras.lang.yaml" },
        { import = "lazyvim.plugins.extras.lang.docker" },
        { import = "lazyvim.plugins.extras.lang.toml" },
        { import = "lazyvim.plugins.extras.lang.sql" },
        { import = "lazyvim.plugins.extras.lang.git" },
        { import = "lazyvim.plugins.extras.lang.markdown" },
        { import = "lazyvim.plugins.extras.lang.json" },
        -- OTHER
        { import = "lazyvim.plugins.extras.util.octo" },
        { import = "lazyvim.plugins.extras.coding.luasnip" },
        -- FORMATTING
        -- { import = "lazyvim.plugins.extras.formatting.black" },
        -- { import = "lazyvim.plugins.extras.dap.core" },
        { import = "lazyvim.plugins.extras.coding.yanky" },
        { import = "lazyvim.plugins.extras.lsp.none-ls" },

        -- import/override with your plugins
        { import = "plugins" },
    },
    defaults = {
        -- By default, only LazyVim plugins will be lazy-loaded. Your custom plugins will load during startup.
        -- If you know what you're doing, you can set this to `true` to have all your custom plugins lazy-loaded by default.
        lazy = false,
        -- It's recommended to leave version=false for now, since a lot the plugin that support versioning,
        -- have outdated releases, which may break your Neovim install.
        version = false, -- always use the latest git commit
        -- version = "*", -- try installing the latest stable version for plugins that support semver
    },
    install = { colorscheme = { "tokyonight", "habamax" } },
    checker = { enabled = true }, -- automatically check for plugin updates
    performance = {
        rtp = {
            -- disable some rtp plugins
            disabled_plugins = {
                "gzip",
                -- "matchit",
                -- "matchparen",
                -- "netrwPlugin",
                "tarPlugin",
                "tohtml",
                "tutor",
                "zipPlugin",
            },
        },
    },
})
