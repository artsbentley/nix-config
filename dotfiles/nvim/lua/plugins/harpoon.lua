return {
    "ThePrimeagen/harpoon",
    dependencies = "nvim-lua/plenary.nvim",
    lazy = true,
    opts = {
        global_settings = { mark_branch = true },
        width = vim.api.nvim_win_get_width(0) - 4,
    },
}
--     config = function()
--         require("harpoon").setup({
--             -- vim.keymap.set("n", "<leader>a", "<cmd>lua require('harpoon.mark').add_file()<cr>", { desc = "Add to Harpoon" }),
--             vim.keymap.set("n", "<leader>a", function()
--                 require("harpoon.mark").add_file()
--             end, { desc = "Add to Harpoon" }),
--             vim.keymap.set("n", "<leader>0", "<cmd>lua require('harpoon.ui').toggle_quick_menu()<cr>", { desc = "Show Harpoon" }),
--
--             -- vim.keymap.set("n", "<leader>1", "<cmd>lua require('harpoon.ui').nav_file(1)<cr>", { desc = "Harpoon Buffer 1" })
--             vim.keymap.set("n", "<C-1>", function()
--                 require("harpoon.mark").nav_file(1)
--             end, { desc = "Harpoon Buffer 1" }),
--
--             -- vim.keymap.set("n", "<leader>2", "<cmd>lua require('harpoon.ui').nav_file(2)<cr>", { desc = "Harpoon Buffer 2" })
--             vim.keymap.set("n", "<C-2>", "<cmd>lua require('harpoon.ui').nav_file(2)<cr>", { desc = "Harpoon Buffer 2" }),
--
--             vim.keymap.set("n", "<leader>3", "<cmd>lua require('harpoon.ui').nav_file(3)<cr>", { desc = "Harpoon Buffer 3" }),
--             vim.keymap.set("n", "<C-3>", "<cmd>lua require('harpoon.ui').nav_file(3)<cr>", { desc = "Harpoon Buffer 3" }),
--
--             vim.keymap.set("n", "<leader>4", "<cmd>lua require('harpoon.ui').nav_file(4)<cr>", { desc = "Harpoon Buffer 4" }),
--             vim.keymap.set("n", "<leader>5", "<cmd>lua require('harpoon.ui').nav_file(5)<cr>", { desc = "Harpoon Buffer 5" }),
--         })
--     end,
-- }
