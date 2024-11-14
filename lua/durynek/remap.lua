vim.g.mapleader = " "

vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)

vim.keymap.set("n", "<leader>fl", vim.lsp.buf.format)
vim.keymap.set("i", "<C-space>", vim.lsp.buf.signature_help)
vim.keymap.set("n", "<C-space>", vim.lsp.buf.signature_help)
vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action)
vim.keymap.set("n", "<leader>gl", "<cmd>silent !golines -w %<cr>")

-- terminal remaps
vim.keymap.set("t", "<Esc>", "<C-\\><C-n>")
vim.keymap.set("n", "<C-t>", "<cmd>ToggleTerm<cr>")
vim.keymap.set("t", "<C-t>", "<cmd>ToggleTerm<cr>")

-- neotree remaps
vim.keymap.set("n", "<leader>fs", "<cmd>Neotree toggle<cr>")

-- navigation in insert mode
vim.keymap.set("i", "<C-h>", "<Left>")
vim.keymap.set("i", "<C-j>", "<Down>")
vim.keymap.set("i", "<C-k>", "<Up>")
vim.keymap.set("i", "<C-l>", "<Right>")
vim.keymap.set("i", "<C-i>", "<Esc>")

vim.keymap.set("n", "<C-j>", "<cmd>m .+1<CR>==")
vim.keymap.set("n", "<C-k>", "<cmd>m .-2<CR>==")

vim.keymap.set("n", "[h", ":Gitsigns prev_hunk<CR>", {})
vim.keymap.set("n", "]h", ":Gitsigns next_hunk<CR>", {})
vim.keymap.set("n", "<leader>hp", ":Gitsigns preview_hunk<CR>", {})
vim.keymap.set("n", "<leader>hr", ":Gitsigns reset_hunk<CR>", {})

vim.keymap.set("i", "jj", "<Esc>")
vim.keymap.set("n", "<leader>q", ":q<CR>", {})
vim.keymap.set("n", "<leader>wf", ":w<CR>", {})
vim.keymap.set("n", "<leader>wq", ":wq<CR>", {})

vim.keymap.set("n", "<leader>gits", ":Git<CR>", {})
vim.keymap.set("n", "<leader>gitc", ":Git commit<CR>", {})

vim.keymap.set("n", "<leader>hh", "_", {})
vim.keymap.set("n", "<leader>ll", "$", {})

vim.keymap.set("n", "<leader>cd", vim.diagnostic.open_float)
