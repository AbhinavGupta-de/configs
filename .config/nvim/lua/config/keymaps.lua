local map = vim.keymap.set

-- Escape
map("i", "jk", "<Esc>", { desc = "Exit insert mode" })

-- Don't use Ex mode
map("n", "Q", "gq")

-- Keep selection when indenting
map("v", "<", "<gv")
map("v", ">", ">gv")

-- Clear search highlight
map("n", "<leader><Space>", ":nohlsearch<CR>", { desc = "Clear search highlight", silent = true })

-- Window navigation (Alt-based, matching your vimrc)
map("n", "<A-h>", "<C-w>h", { desc = "Window left" })
map("n", "<A-l>", "<C-w>l", { desc = "Window right" })
map("n", "<A-k>", "<C-w>k", { desc = "Window up" })
map("n", "<A-j>", "<C-w>j", { desc = "Window down" })

-- Tab navigation
map("n", "<A-n>", ":tabnext<CR>", { desc = "Next tab", silent = true })
map("n", "<A-p>", ":tabprev<CR>", { desc = "Prev tab", silent = true })

-- Splits
map("n", "<leader>wv", "<cmd>vsplit<CR>", { desc = "Vertical split" })
map("n", "<leader>ws", "<cmd>split<CR>", { desc = "Horizontal split" })
map("n", "<leader>wh", "<C-w>h", { desc = "Go to left split" })
map("n", "<leader>wl", "<C-w>l", { desc = "Go to right split" })
map("n", "<leader>wk", "<C-w>k", { desc = "Go to upper split" })
map("n", "<leader>wj", "<C-w>j", { desc = "Go to lower split" })

-- Save / Quit
map("n", "<leader>s", "<cmd>w<CR>", { desc = "Save" })
map("n", "<leader>q", "<cmd>q<CR>", { desc = "Quit" })
map("n", "<leader>qa", "<cmd>qa<CR>", { desc = "Quit all" })

-- Buffers
map("n", "<leader>bd", "<cmd>bd<CR>", { desc = "Delete buffer" })
map("n", "<leader>bn", "<cmd>bnext<CR>", { desc = "Next buffer" })
map("n", "<leader>bp", "<cmd>bprev<CR>", { desc = "Prev buffer" })

-- Folds
map("n", "<leader>zo", "zR", { desc = "Open all folds" })
map("n", "<leader>zc", "zM", { desc = "Close all folds" })

-- Move lines up/down
map("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move selection down", silent = true })
map("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move selection up", silent = true })
