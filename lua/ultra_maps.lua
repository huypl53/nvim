-- Copy relative file path with line number(s)
-- Usage: In normal mode copies current line, in visual mode copies line range

local utils = require('utils')

local function copy_path_with_lines()
  local path = utils.get_relative_path()
  local line_info

  if utils.is_visual_mode() then
    -- Visual mode: get range
    local start_line, end_line = utils.get_visual_range()
    line_info = start_line == end_line and tostring(start_line) or string.format('%d-%d', start_line, end_line)
  else
    -- Normal mode: current line
    line_info = tostring(vim.fn.line('.'))
  end

  local result = string.format('@%s:%s', path, line_info)
  vim.fn.setreg('+', result)
  print('Copied: ' .. result)
end

vim.keymap.set("n", "yr", ':let @+="@" .. substitute(expand("%:p"), getcwd() .. "/", "", "g")<CR>')

-- Key mappings
vim.keymap.set('v', '<leader>yr', function()
  copy_path_with_lines()
  utils.exit_visual_mode()
end, { desc = 'Copy path with line range' })

local status, term_send = pcall(require, 'terminal-send')
if (not status) then return end

local function send_path_lines()
  copy_path_with_lines()
  utils.exit_visual_mode()
  term_send.send_clipboard()
end

vim.keymap.set('v', '<leader>l', function()
  send_path_lines()
end, { desc = 'copy path with lines then send to term' })
