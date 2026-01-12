local map = vim.keymap.set

map("n", "<leader>qq", vim.cmd.Ex)
map("n", "<leader>qb", ":bd<CR>")

map("n", "<leader>wh", "<C-w><C-s>")
map("n", "<leader>wv", "<C-w><C-v>")
map("n", "<leader>wq", "<C-w><C-q>")
map("n", "<C-k>", "<C-w><C-k>")
map("n", "<C-l>", "<C-w><C-l>")
map("n", "<C-j>", "<C-w><C-j>")
map("n", "<C-h>", "<C-w><C-h>")


map("v", "<", "<gv")
map("v", ">", ">gv")
map("n", ">", ">>")
map("n", "<", "<<")
map("v", "p", "_dp")
map("n", "<C-n>", ":nohlsearch<Bar>:echo<CR>")
map("n", "J", "m`o<Esc>``")
map("n", "K", "m`O<Esc>``", { noremap = true, silent = true })
map("v", "J", ":m '>+1<CR>gv=gv")
map("v", "K", ":m '<-2<CR>gv=gv")

map("n", "<C-p>", '"*p')
map("v", "<C-y>", '"+y')
