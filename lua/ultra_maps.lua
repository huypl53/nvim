-- Copy relative file path with line number(s)
-- Usage: In normal mode copies current line, in visual mode copies line range

local function copy_path_with_lines()
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

vim.keymap.set("n", "yr", ':let @+="@" .. substitute(expand("%:p"), getcwd() .. "/", "", "g")<CR>')

-- Key mappings
vim.keymap.set('v', '<leader>yr', function()
  copy_path_with_lines()
  vim.cmd('normal! \27') -- ESC to exit visual mode
end, { desc = 'Copy path with line range' })

status, term_send = pcall(require, 'terminal-send')
if (not status) then return end

local function send_path_lines()
  copy_path_with_lines()
  vim.cmd('normal! \27') -- ESC to exit visual mode
  term_send.send_clipboard()
end

vim.keymap.set('v', '<leader>tr', function()
  send_path_lines()
end, { desc = 'copy path with lines then send to term' })
