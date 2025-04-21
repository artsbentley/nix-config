return {
	"neovim/nvim-lspconfig",
	opts = {
		servers = {
			pyright = {
				settings = {
					pyright = {
					inlay_hints = { enabled = false },
						disableOrganizeImports = true,
					},
					python = {
						analysis = {
							ignore = { "*" },
							typeCheckingMode = "off",
						},
					},
				},
			},
			ruff_lsp = {}, -- this tells LazyVim to load this server
		},
		setup = {
			ruff_lsp = function()
				require("lazyvim.util").lsp.on_attach(function(client, _)
					if client.name == "ruff_lsp" then
						client.server_capabilities.hoverProvider = false
					end
				end)
			end,
		},
	},
}

