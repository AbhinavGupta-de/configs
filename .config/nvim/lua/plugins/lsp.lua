return {
	-- LSP config
	{
		"neovim/nvim-lspconfig",
		event = "BufReadPre",
		dependencies = {
			"mason.nvim",
			"williamboman/mason-lspconfig.nvim",
		},
		config = function()
			local lspconfig = require("lspconfig")
			local mason_lspconfig = require("mason-lspconfig")

			-- Keymaps on LSP attach
			vim.api.nvim_create_autocmd("LspAttach", {
				callback = function(args)
					local buf = args.buf
					local map = function(mode, lhs, rhs, desc)
						vim.keymap.set(mode, lhs, rhs, { buffer = buf, desc = desc })
					end

					map("n", "gd", vim.lsp.buf.definition, "Go to definition")
					map("n", "gr", vim.lsp.buf.references, "References")
					map("n", "gi", vim.lsp.buf.implementation, "Go to implementation")
					map("n", "K", vim.lsp.buf.hover, "Hover docs")
					map("n", "<leader>lr", vim.lsp.buf.rename, "Rename")
					map("n", "<leader>la", vim.lsp.buf.code_action, "Code action")
					map("n", "<leader>ld", vim.diagnostic.open_float, "Line diagnostics")
					map("n", "<leader>lf", function() vim.lsp.buf.format({ async = true }) end, "Format")
					map("n", "[d", vim.diagnostic.goto_prev, "Prev diagnostic")
					map("n", "]d", vim.diagnostic.goto_next, "Next diagnostic")
				end,
			})

			mason_lspconfig.setup_handlers({
				function(server_name)
					lspconfig[server_name].setup({})
				end,
				["lua_ls"] = function()
					lspconfig.lua_ls.setup({
						settings = {
							Lua = {
								workspace = { checkThirdParty = false },
								telemetry = { enable = false },
							},
						},
					})
				end,
			})
		end,
	},
	-- Mason (LSP installer)
	{
		"williamboman/mason.nvim",
		cmd = "Mason",
		opts = {},
	},
	{
		"williamboman/mason-lspconfig.nvim",
		opts = {
			ensure_installed = {
				"lua_ls",
				"gopls",
				"ts_ls",
				"pyright",
			},
		},
	},
}
