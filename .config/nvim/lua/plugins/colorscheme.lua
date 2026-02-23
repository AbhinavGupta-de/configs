return {
	{
		"catppuccin/nvim",
		name = "catppuccin",
		priority = 1000,
		opts = {
			flavour = "mocha",
			integrations = {
				gitsigns = true,
				treesitter = true,
				telescope = { enabled = true },
				which_key = true,
				flash = true,
				native_lsp = {
					enabled = true,
					underlines = {
						errors = { "undercurl" },
						warnings = { "undercurl" },
					},
				},
			},
		},
		config = function(_, opts)
			require("catppuccin").setup(opts)
			vim.cmd.colorscheme("catppuccin")
		end,
	},
}
