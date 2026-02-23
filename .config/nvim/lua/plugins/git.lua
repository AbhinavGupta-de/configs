return {
	-- Gitsigns (replaces vim-gitgutter)
	{
		"lewis6991/gitsigns.nvim",
		event = "BufReadPre",
		opts = {
			signs = {
				add = { text = "+" },
				change = { text = "~" },
				delete = { text = "_" },
				topdelete = { text = "-" },
				changedelete = { text = "~" },
			},
		},
	},
	-- Fugitive (keeping it, it's great)
	{
		"tpope/vim-fugitive",
		cmd = "Git",
		keys = {
			{ "<leader>gs", "<cmd>Git<CR>", desc = "Git status" },
			{ "<leader>gc", "<cmd>Git commit<CR>", desc = "Git commit" },
			{ "<leader>gp", "<cmd>Git push<CR>", desc = "Git push" },
			{ "<leader>gl", "<cmd>Git log<CR>", desc = "Git log" },
			{ "<leader>gb", "<cmd>Git blame<CR>", desc = "Git blame" },
			{ "<leader>gd", "<cmd>Gdiffsplit<CR>", desc = "Git diff" },
		},
	},
}
