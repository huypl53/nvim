-- Terminal Send Plugin for Neovim
-- Send clipboard or selected lines to terminal and switch to it

local M = {}

-- Find any existing terminal window
function M.find_terminal()
  -- Look through all windows for a terminal
  for _, win in ipairs(vim.api.nvim_list_wins()) do
    local buf = vim.api.nvim_win_get_buf(win)
    local bufname = vim.api.nvim_buf_get_name(buf)

    -- Check if it's a terminal buffer
    if bufname:match('^term://') then
      return buf, win
    end
  end

  -- No terminal window found, look for terminal buffer
  for _, buf in ipairs(vim.api.nvim_list_bufs()) do
    if vim.api.nvim_buf_is_valid(buf) then
      local bufname = vim.api.nvim_buf_get_name(buf)
      if bufname:match('^term://') then
        -- Found terminal buffer, open it in a split
        vim.cmd('vsplit')
        local win = vim.api.nvim_get_current_win()
        vim.api.nvim_win_set_buf(win, buf)
        vim.cmd('wincmd p')
        return buf, win
      end
    end
  end

  -- No terminal exists, create one
  vim.cmd('vsplit')
  local win = vim.api.nvim_get_current_win()
  vim.cmd('terminal')
  local buf = vim.api.nvim_get_current_buf()
  vim.cmd('wincmd p')

  return buf, win
end

-- Send text and switch to terminal in insert mode
function M.send_and_switch(text)
  local bufnr, win = M.find_terminal()
  local chan = vim.api.nvim_buf_get_var(bufnr, 'terminal_job_id')

  -- Send text without newline
  vim.api.nvim_chan_send(chan, text)

  -- Switch to terminal window and enter insert mode
  vim.api.nvim_set_current_win(win)
  vim.cmd('startinsert!')
end

-- Send clipboard
function M.send_clipboard()
  local clipboard = vim.fn.getreg('+')
  M.send_and_switch(clipboard)
end

-- Send selected lines
function M.send_selection()
  local start_pos = vim.fn.getpos("'<")
  local end_pos = vim.fn.getpos("'>")
  local lines = vim.api.nvim_buf_get_lines(0, start_pos[2] - 1, end_pos[2], false)

  if #lines == 0 then return end

  -- Handle single line selection
  if #lines == 1 then
    lines[1] = string.sub(lines[1], start_pos[3], end_pos[3])
  else
    lines[1] = string.sub(lines[1], start_pos[3])
    lines[#lines] = string.sub(lines[#lines], 1, end_pos[3])
  end

  local text = table.concat(lines, '\n')
  M.send_and_switch(text)
end

-- Debug function to check terminal state
function M.debug()
  print('=== Terminal Debug Info ===')

  -- List all terminal buffers
  print('All Terminal Buffers:')
  for _, buf in ipairs(vim.api.nvim_list_bufs()) do
    if vim.api.nvim_buf_is_valid(buf) then
      local bufname = vim.api.nvim_buf_get_name(buf)
      if bufname:match('^term://') then
        print('  Buffer', buf, ':', bufname)
      end
    end
  end

  -- List terminal windows
  print('\nTerminal Windows:')
  for _, win in ipairs(vim.api.nvim_list_wins()) do
    local buf = vim.api.nvim_win_get_buf(win)
    local bufname = vim.api.nvim_buf_get_name(buf)
    if bufname:match('^term://') then
      print('  Window', win, 'showing buffer', buf)
    end
  end

  local buf, win = M.find_terminal()
  print('\nWould use:')
  print('  Buffer:', buf)
  print('  Window:', win)
end

-- Setup keymaps
function M.setup(opts)
  opts = opts or {}

  local keymaps = opts.keymaps or {
    send_clipboard = '<leader>tc',
    send_selection = '<leader>ts',
  }

  vim.keymap.set('n', keymaps.send_clipboard, M.send_clipboard, { desc = 'Send clipboard to terminal' })
  vim.keymap.set('v', keymaps.send_selection, function()
    M.send_selection()
    vim.cmd('normal! \27') -- Exit visual mode
  end, { desc = 'Send selection to terminal' })
end

return M
