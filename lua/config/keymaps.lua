local map = vim.keymap.set

map("n", "<leader>qq", vim.cmd.Ex)
map("n", "<leader>qb", ":bp|bd #<CR>")

map("n", "<leader>w-", "<C-w><C-s>")
map("n", "<leader>w\\", "<C-w><C-v>")
map("n", "<leader>wq", "<C-w><C-q>")
map("n", "<leader>wk", "<C-w><C-k>")
map("n", "<leader>wl", "<C-w><C-l>")
map("n", "<leader>wj", "<C-w><C-j>")
map("n", "<leader>wh", "<C-w><C-h>")

map("v", "<", "<gv")
map("v", ">", ">gv")
map("n", ">", ">>")
map("n", "<", "<<")
map("v", "p", "P")
map("n", "<C-n>", ":nohlsearch<Bar>:echo<CR>")
map("n", "J", "m`o<Esc>``")
map("n", "K", "m`O<Esc>``", { noremap = true, silent = true })
map("v", "J", ":m '>+1<CR>gv=gv")
map("v", "K", ":m '<-2<CR>gv=gv")

map("n", "<C-p>", '"*p')
map("v", "<leader>y", '"+y')

map("n", "<leader>m", ":Mason<CR>")
map("n", "<leader>l", ":Lazy<CR>")
