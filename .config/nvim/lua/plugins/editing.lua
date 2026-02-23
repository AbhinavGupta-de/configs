return {
	-- Comment (replaces vim-commentary)
	{
		"numToStr/Comment.nvim",
		keys = {
			{ "<leader>c", "<Plug>(comment_toggle_linewise_current)", desc = "Toggle comment" },
			{ "<leader>c", "<Plug>(comment_toggle_linewise_visual)", mode = "v", desc = "Toggle comment" },
			{ "gcc", mode = "n" },
			{ "gc", mode = "v" },
		},
		opts = {},
	},
	-- Surround (replaces vim-surround)
	{
		"kylechui/nvim-surround",
		event = "VeryLazy",
		opts = {},
	},
	-- Autopairs (replaces auto-pairs)
	{
		"windwp/nvim-autopairs",
		event = "InsertEnter",
		opts = {},
	},
	-- Replace with register
	{
		"vim-scripts/ReplaceWithRegister",
		event = "VeryLazy",
	},
}
