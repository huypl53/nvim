local keymap = vim.keymap

vim.g.mapleader = ';'
keymap.set('i', 'kj', '<Esc>')
keymap.set('i', 'jk', '<Esc>')
keymap.set('i', '<C-l>', '<Esc>A')

keymap.set('n', 'x', '"_x')

-- Increment/decrement
keymap.set('n', '+', '<C-a>')
keymap.set('n', '-', '<C-x>')

-- Delete a word backwards
keymap.set('n', 'dw', 'vb"_d')

-- Select all
keymap.set('n', '<C-a>', 'gg<S-v>G')

-- Save with root permission (not working for now)
--vim.api.nvim_create_user_command('W', 'w !sudo tee > /dev/null %', {})


keymap.set('n', 'se', ':edit ')
-- New tab
keymap.set('n', 'te', ':tabedit ')
-- Split window
keymap.set('n', 'ss', ':split<Return><C-w>w')
keymap.set('n', 'sv', ':vsplit<Return><C-w>w')
-- Move window
-- keymap.set('n', '<Space>', '<C-w>w')
keymap.set('', 'sh', '<C-w>h')
keymap.set('', 'sk', '<C-w>k')
keymap.set('', 'sj', '<C-w>j')
keymap.set('', 'sl', '<C-w>l')

-- Resize window
keymap.set('n', '<C-w><left>', '<C-w><')
keymap.set('n', '<C-w><right>', '<C-w>>')
keymap.set('n', '<C-w><up>', '<C-w>+')
keymap.set('n', '<C-w><down>', '<C-w>-')

-- Scroll bind
keymap.set('n', 'sb', ':windo set scb!<CR>')

-- Fold method
keymap.set('n', 'sgm', ':set fdm=manual<CR>')
keymap.set('n', 'sgi', ':set fdm=indent<CR>')

-- yank current file path to clipboard
keymap.set('n', 'yp', ':let @+=substitute(expand("%"), getcwd(), "", "g")<CR>')
