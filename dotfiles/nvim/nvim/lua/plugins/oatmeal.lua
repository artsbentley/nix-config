return {
    "dustinblackman/oatmeal.nvim",
    cmd = { "Oatmeal" },
    keys = {
        { "<leader>gpt", mode = "v", "<cmd>Oatmeal<cr>", desc = "Start Oatmeal session" },
        { "<leader>gpt", mode = "n", "<cmd>Oatmeal<cr>", desc = "Start Oatmeal session" },
    },
    opts = {
        backend = "ollama",
        model = "codellama:latest",
    },
}
