return {
	-- Flash (replaces easymotion + sneak)
	{
		"folke/flash.nvim",
		event = "VeryLazy",
		keys = {
			{ "<leader>f", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash jump" },
			{ "<leader>e", mode = { "n", "x", "o" }, function() require("flash").treesitter() end, desc = "Flash treesitter" },
			{ "<leader>j", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash jump" },
			{ "s", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash" },
			{ "S", mode = { "n", "x", "o" }, function() require("flash").treesitter() end, desc = "Flash treesitter" },
		},
		opts = {},
	},
}
