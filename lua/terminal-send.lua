-- Terminal Send Plugin for Neovim
-- Send clipboard or selected lines to terminal and switch to it

local M = {}
local utils = require('utils')

local last_terminal = {
  buf = nil,
  win = nil,
}

local function remember_terminal(buf, win)
  if not (buf and vim.api.nvim_buf_is_valid(buf)) then
    return
  end

  local name = vim.api.nvim_buf_get_name(buf)
  if not name:match('^term://') then
    return
  end

  last_terminal.buf = buf
  if win and vim.api.nvim_win_is_valid(win) and vim.api.nvim_win_get_buf(win) == buf then
    last_terminal.win = win
  else
    last_terminal.win = nil
  end
end

-- Track the most recently visited terminal
local tracking_group = vim.api.nvim_create_augroup('TerminalSendTracking', { clear = true })
vim.api.nvim_create_autocmd({ 'TermOpen', 'TermEnter', 'BufEnter' }, {
  group = tracking_group,
  pattern = 'term://*',
  callback = function(args)
    remember_terminal(args.buf, vim.api.nvim_get_current_win())
  end,
})

-- Find any existing terminal window
function M.find_terminal()
  -- Prefer the last visited terminal if it still exists
  if last_terminal.buf and vim.api.nvim_buf_is_valid(last_terminal.buf) then
    local bufname = vim.api.nvim_buf_get_name(last_terminal.buf)
    if bufname:match('^term://') then
      if last_terminal.win and vim.api.nvim_win_is_valid(last_terminal.win) and vim.api.nvim_win_get_buf(last_terminal.win) == last_terminal.buf then
        return last_terminal.buf, last_terminal.win
      end

      -- Buffer exists but window closed; reopen in a split
      vim.cmd('vsplit')
      local win = vim.api.nvim_get_current_win()
      vim.api.nvim_win_set_buf(win, last_terminal.buf)
      vim.cmd('wincmd p')
      remember_terminal(last_terminal.buf, win)
      return last_terminal.buf, win
    end
  end

  -- Look through all windows for a terminal
  for _, win in ipairs(vim.api.nvim_list_wins()) do
    local buf = vim.api.nvim_win_get_buf(win)
    local bufname = vim.api.nvim_buf_get_name(buf)

    -- Check if it's a terminal buffer
    if bufname:match('^term://') then
      remember_terminal(buf, win)
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
        remember_terminal(buf, win)
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

  remember_terminal(buf, win)

  return buf, win
end

-- Send text to a terminal with optional focus/insert behavior
-- opts = {
--   win = <window id>, -- target terminal window (optional)
--   switch = true|false, -- whether to jump to the terminal window (default true)
--   insert = true|false, -- when switching, enter insert/terminal mode (default true)
-- }
function M.send_and_switch(text, opts)
  opts = opts or {}

  local bufnr, win

  -- If a target window is provided and valid, use it
  if opts.win and vim.api.nvim_win_is_valid(opts.win) then
    local buf = vim.api.nvim_win_get_buf(opts.win)
    if vim.api.nvim_buf_is_valid(buf) and vim.api.nvim_buf_get_name(buf):match('^term://') then
      bufnr, win = buf, opts.win
      remember_terminal(bufnr, win)
    end
  end

  -- Fallback to last/any terminal
  if not bufnr then
    bufnr, win = M.find_terminal()
  end

  local chan = vim.api.nvim_buf_get_var(bufnr, 'terminal_job_id')

  -- If we stay in place, append a trailing space to keep prompt separation
  local payload = (opts.switch == false) and (text .. ' ') or text

  -- Send text without newline
  vim.api.nvim_chan_send(chan, payload)

  local should_switch = opts.switch ~= false
  local enter_insert = opts.insert ~= false

  if should_switch then
    -- Switch to terminal window and optionally enter insert mode after this mapping finishes
    vim.schedule(function()
      if vim.api.nvim_win_is_valid(win) then
        vim.api.nvim_set_current_win(win)
        if enter_insert then
          local keys = vim.api.nvim_replace_termcodes('i', true, false, true)
          -- Use feedkeys in terminal-mode context so we reliably end in terminal insert
          vim.api.nvim_feedkeys(keys, 't', false)
        end
      end
    end)
  end
end

-- Send clipboard
function M.send_clipboard(opts)
  local clipboard = vim.fn.getreg('+')
  M.send_and_switch(clipboard, opts)
end

-- Send selected lines
function M.send_selection(opts)
  local start_pos, end_pos = utils.get_visual_positions()
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
  M.send_and_switch(text, opts)
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
    utils.exit_visual_mode()
  end, { desc = 'Send selection to terminal' })
end

return M
