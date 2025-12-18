local keymap = vim.keymap
vim.g.maplocalleader = ","
vim.g.mapleader = ";"
keymap.set("i", "kj", "<Esc>")
keymap.set("i", "jk", "<Esc>")
keymap.set("i", "<C-l>", "<Esc>Ea")
keymap.set("i", "<C-h>", "<Esc>Bi")

keymap.set("n", "x", '"_x')

-- Increment/decrement
keymap.set("n", "+", "<C-a>")
keymap.set("n", "-", "<C-x>")

-- Delete a word backwards
keymap.set("n", "dw", 'vb"_d')

-- Select all
keymap.set("n", "<C-a>", "gg<S-v>G")

-- Save with root permission (not working for now)
--vim.api.nvim_create_user_command('W', 'w !sudo tee > /dev/null %', {})

keymap.set("n", "se", ":edit ")
-- New tab
keymap.set("n", "te", ":tabedit ")

-- Tav Move
keymap.set("n", "th", ":tabm -1 <CR>")
keymap.set("n", "tl", ":tabm +1 <CR>")
-- Split window
keymap.set("n", "ss", ":split<Return><C-w>w")
keymap.set("n", "sv", ":vsplit<Return><C-w>w")
-- Move window
-- keymap.set('n', '<Space>', '<C-w>w')
keymap.set("", "sh", "<C-w>h")
keymap.set("", "sk", "<C-w>k")
keymap.set("", "sj", "<C-w>j")
keymap.set("", "sl", "<C-w>l")

-- Resize window
keymap.set("n", "<C-left>", "<cmd>vertical resize -2<CR>")
keymap.set("n", "<C-right>", "<cmd>vertical resize +2<CR>")
keymap.set("n", "<C-up>", "<cmd>resize +2<CR>")
keymap.set("n", "<C-down>", "<cmd>resize -2<CR>")

-- Scroll bind
keymap.set("n", "sb", ":windo set scb!<CR>")

-- Fold method
keymap.set("n", "sgm", ":set fdm=manual<CR>")
keymap.set("n", "sgi", ":set fdm=indent<CR>")

-- yank current file path to clipboard
keymap.set("n", "yp", ':let @+=substitute(expand("%:p"), getcwd() .. "/", "", "g")<CR>')
keymap.set("n", "yP", ':let @+= expand("%:p")<CR>')

--terminal
keymap.set("t", "<leader>q", '<C-\\><C-N>', { noremap = false, silent = true })


-- lsp
keymap.set("n", "grv", function()
  vim.cmd('vsplit')
  vim.lsp.buf.type_definition({ reuse_win = true })
end, { silent = true })

keymap.set("n", "grt", function()
  vim.cmd("tab split")
  vim.lsp.buf.type_definition({ reuse_win = false })
end)
