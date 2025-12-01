local keymap = vim.keymap
vim.g.maplocalleader = "\\"
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
keymap.set("n", "<C-w><left>", "<C-w><")
keymap.set("n", "<C-w><right>", "<C-w>>")
keymap.set("n", "<C-w><up>", "<C-w>+")
keymap.set("n", "<C-w><down>", "<C-w>-")

-- Scroll bind
keymap.set("n", "sb", ":windo set scb!<CR>")

-- Fold method
keymap.set("n", "sgm", ":set fdm=manual<CR>")
keymap.set("n", "sgi", ":set fdm=indent<CR>")

-- yank current file path to clipboard
keymap.set("n", "yp", ':let @+=substitute(expand("%:p"), getcwd() .. "/", "", "g")<CR>')
keymap.set("n", "yP", ':let @+= expand("%:p")<CR>')

--terminal
keymap.set("t", "<C-[>", [[ <C-\><C-n> ]])

-- Copy relative file path with line number(s)
-- Usage: In normal mode copies current line, in visual mode copies line range

local function copy_path_with_lines()
  local absolute_filepath = vim.fn.expand("%:p")

  -- Get the current working directory (cwd)
  -- local cwd = vim.fn.getcwd()
  -- local path = vim.fn.expand('%')
  -- local path = vim.fn.fnamemodify(absolute_filepath, "relativename")
  -- local path = vim.fn.expand('%')
  local path = vim.fn.substitute(vim.fn.expand("%:p"), vim.fn.getcwd() .. "/", "", "g")
  local mode = vim.fn.mode()
  local line_info

  if mode == 'v' or mode == 'V' or mode == '\22' then
    -- Visual mode: get range
    local start_line = vim.fn.line('v')
    local end_line = vim.fn.line('.')
    if start_line > end_line then
      start_line, end_line = end_line, start_line
    end
    line_info = start_line == end_line and tostring(start_line) or string.format('%d-%d', start_line, end_line)
  else
    -- Normal mode: current line
    line_info = tostring(vim.fn.line('.'))
  end

  local result = string.format('@%s:%s', path, line_info)
  vim.fn.setreg('+', result)
  print('Copied: ' .. result)
end

-- Key mappings
vim.keymap.set('v', '<leader>yr', function()
  copy_path_with_lines()
  vim.cmd('normal! \27') -- ESC to exit visual mode
end, { desc = 'Copy path with line range' })
