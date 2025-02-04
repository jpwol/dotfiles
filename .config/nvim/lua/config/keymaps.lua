vim.g.mapleader = " "

local keymap = vim.keymap.set

-- Exit insert mode!!!
keymap("i", "jk", "<esc>")

-- Cancel search highlighting
keymap("n", "<leader>nh", "<cmd>nohl<CR>")

-- Do splits
keymap("n", "<leader>sv", "<C-w>v", { desc = "Split window vertically" })
keymap("n", "<leader>sh", "<C-w>s", { desc = "Split window horizontally" })
keymap("n", "<leader>sp", "<C-w>x", { desc = "Swap current window with the next" })
keymap("n", "<leader>se", "<C-w>=", { desc = "Make splits equal size" })
keymap("n", "<leader>sx", "<cmd>close<CR>", { desc = "Close current split" })
keymap("n", ".", "<C-w>>", { desc = "Increase vertical split size" })
keymap("n", ",", "<C-w><", { desc = "Increase vertical split size" })

-- Do tabs
keymap("n", "<leader>to", "<cmd>tabnew<CR>", { desc = "Open new tab" })
keymap("n", "<leader>tx", "<cmd>tabclose<CR>", { desc = "Close current tab" })
keymap("n", "<leader>tn", "<cmd>tabn<CR>", { desc = "Go to next tab" })
keymap("n", "<leader>tp", "<cmd>tabp<CR>", { desc = "Go to previous tab" })
keymap("n", "<leader>tf", "<cmd>tabnew %<CR>", { desc = "Open current buffer in new tab" })

-- Moving around buffers
keymap("n", "<leader>h", "<C-w>h", { desc = "Move to left window" })
keymap("n", "<leader>l", "<C-w>l", { desc = "Move to right window" })
keymap("n", "<leader>j", "<C-w>j", { desc = "Move to window above" })
keymap("n", "<leader>k", "<C-w>k", { desc = "Move to window below" })
keymap("n", "<leader>w", "<C-w>w", { desc = "Move to next window" })

-- Exit terminal mode
keymap("t", "<C-space>", "<C-\\><C-n>")

-- MOVE THINGS
keymap("v", "J", ":m '>+1<CR>gv=gv")
keymap("v", "K", ":m '<-2<CR>gv=gv")

-- Paste without losing current register
keymap("x", "<leader>p", '"_dP')
