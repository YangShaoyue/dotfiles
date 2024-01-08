vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

local keymap = vim.keymap
keymap.set('n', '<leader>q', '<cmd>q<cr>')

keymap.set('n', '<leader>w', '<cmd>w<cr>')

keymap.set('n', '<c-a>', 'gg<S-v>G')

keymap.set('n', 'H', '^')
keymap.set('n', 'L', '$')

-- move line down & up
keymap.set("n", "<SA-j>", "<Esc>:m .+1<CR>==")
keymap.set("n", "<SA-k>", "<Esc>:m .-2<CR>==")

-- move line down & up in Visual mode
keymap.set("v", "<A-j>", ":m '>+1<CR>gv=gv")
keymap.set("v", "<A-k>", ":m '<-2<CR>gv=gv")

-- window navigation
keymap.set("n", "<A-h>", "<C-w>h")
keymap.set("n", "<A-j>", "<C-w>j")
keymap.set("n", "<A-l>", "<C-w>l")
keymap.set("n", "<A-k>", "<C-w>k")

keymap.set("n", "<leader>nh", ":nohl<CR>")
