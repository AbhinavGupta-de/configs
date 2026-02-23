return {
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		event = "BufReadPost",
		opts = {
			ensure_installed = {
				"lua",
				"vim",
				"vimdoc",
				"go",
				"gomod",
				"gosum",
				"javascript",
				"typescript",
				"tsx",
				"json",
				"yaml",
				"toml",
				"html",
				"css",
				"bash",
				"markdown",
				"markdown_inline",
				"python",
				"rust",
				"dockerfile",
			},
			highlight = { enable = true },
			indent = { enable = true },
			incremental_selection = {
				enable = true,
				keymaps = {
					init_selection = "<C-space>",
					node_incremental = "<C-space>",
					scope_incremental = false,
					node_decremental = "<bs>",
				},
			},
		},
		config = function(_, opts)
			require("nvim-treesitter.configs").setup(opts)
		end,
	},
}
