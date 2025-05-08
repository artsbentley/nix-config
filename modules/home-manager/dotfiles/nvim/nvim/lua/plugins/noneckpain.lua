-- return {}
return {
    "shortcuts/no-neck-pain.nvim",
	priority = 1000, -- Ensures it loads first
    keys = { { "<leader>wr", "<cmd>NoNeckPain<cr>", desc = "NoNeckPain: center buffer"} },
	lazy = false,
	config = {
		width = 140,
		colors = {
			blend = 0.2
		},
		buffers = {
			right = {
	           enabled = false,
	},

        wo = {
            fillchars = "eob: ",
        },
    },

	}
}


