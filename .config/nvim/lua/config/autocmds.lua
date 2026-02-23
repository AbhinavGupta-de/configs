local autocmd = vim.api.nvim_create_autocmd

-- Highlight on yank (replaces vim-highlightedyank)
autocmd("TextYankPost", {
	callback = function()
		vim.highlight.on_yank({ higroup = "IncSearch", timeout = 300 })
	end,
})

-- Remove trailing whitespace on save
autocmd("BufWritePre", {
	pattern = "*",
	callback = function()
		local pos = vim.api.nvim_win_get_cursor(0)
		vim.cmd([[%s/\s\+$//e]])
		vim.api.nvim_win_set_cursor(0, pos)
	end,
})

-- Return to last edit position when opening files
autocmd("BufReadPost", {
	callback = function()
		local mark = vim.api.nvim_buf_get_mark(0, '"')
		local lcount = vim.api.nvim_buf_line_count(0)
		if mark[1] > 0 and mark[1] <= lcount then
			pcall(vim.api.nvim_win_set_cursor, 0, mark)
		end
	end,
})
