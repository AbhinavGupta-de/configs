return {
	-- Lualine (replaces vim-airline)
	{
		"nvim-lualine/lualine.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		opts = {
			options = {
				theme = "catppuccin",
				component_separators = { left = "", right = "" },
				section_separators = { left = "", right = "" },
			},
		},
	},
	-- Which-key (replaces vim-which-key)
	{
		"folke/which-key.nvim",
		event = "VeryLazy",
		opts = {
			spec = {
				{ "<leader>f", group = "find" },
				{ "<leader>g", group = "git" },
				{ "<leader>w", group = "window" },
				{ "<leader>b", group = "buffer" },
				{ "<leader>z", group = "fold" },
				{ "<leader>l", group = "lsp" },
			},
		},
	},
	-- Indent guides
	{
		"lukas-reineke/indent-blankline.nvim",
		main = "ibl",
		event = "BufReadPost",
		opts = {},
	},
}
