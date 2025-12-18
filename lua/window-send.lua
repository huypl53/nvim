-- Window Send Plugin for Neovim
-- Send clipboard or selected lines to the last visited window

local M = {}
local utils = require('utils')

-- Track windows so we know where to send text
local state = {
  current = nil,
  last = nil,
}

local function is_normal_window(win)
  if not (win and vim.api.nvim_win_is_valid(win)) then
    return false
  end

  local cfg = vim.api.nvim_win_get_config(win)
  return cfg.relative == ''
end

-- Update last/current window on every window enter
local tracking_group = vim.api.nvim_create_augroup('WindowSendTracking', { clear = true })
vim.api.nvim_create_autocmd('WinEnter', {
  group = tracking_group,
  callback = function()
    local win = vim.api.nvim_get_current_win()
    if not is_normal_window(win) then
      return
    end

    if state.current and is_normal_window(state.current) and win ~= state.current then
      state.last = state.current
    end

    state.current = win
  end,
})

local function split_lines_preserve(text)
  local lines = {}
  -- Append newline so gmatch captures trailing empty line when text ends with \n
  for line in (text .. '\n'):gmatch('(.-)\n') do
    table.insert(lines, line)
  end
  return lines
end

local function resolve_target_window(explicit_win)
  if is_normal_window(explicit_win) then
    return explicit_win
  end

  if is_normal_window(state.last) then
    return state.last
  end

  -- Fallback: pick another normal window if one exists
  for _, win in ipairs(vim.api.nvim_list_wins()) do
    if win ~= state.current and is_normal_window(win) then
      return win
    end
  end
end

-- Insert text into target window without disturbing the current window
local function insert_text(target_win, text, opts)
  opts = opts or {}
  local buf = vim.api.nvim_win_get_buf(target_win)
  if not vim.api.nvim_buf_is_loaded(buf) then
    pcall(vim.fn.bufload, buf)
  end

  local cursor = vim.api.nvim_win_get_cursor(target_win)
  local row = cursor[1] - 1 -- zero-indexed for nvim_buf_set_text
  local col = cursor[2]

  local line = vim.api.nvim_buf_get_lines(buf, row, row + 1, true)[1] or ''
  col = math.min(col, #line)

  if opts.pad_left and col > 0 then
    local prev_char = line:sub(col, col)
    if prev_char ~= '' and not prev_char:match('%s') then
      text = ' ' .. text
    end
  end

  local lines = split_lines_preserve(text)
  vim.api.nvim_buf_set_text(buf, row, col, row, col, lines)

  local new_row = row + #lines - 1
  local new_col
  if #lines == 1 then
    new_col = col + #lines[1]
  else
    new_col = #lines[#lines]
  end

  return new_row, new_col
end

-- Send text to the last visited window
-- opts = {
--   win = <window id>, -- optional explicit target window
--   switch = true|false, -- whether to jump to the target window after sending (default true)
-- }
function M.send_text(text, opts)
  opts = opts or {}
  if not text or text == '' then
    return
  end

  local target_win = resolve_target_window(opts.win)
  if not target_win then
    vim.notify('WindowSend: no target window to send text', vim.log.levels.WARN)
    return
  end

  local should_switch = opts.switch ~= false
  local payload = (should_switch and text) or (text .. ' ')
  local new_row, new_col = insert_text(target_win, payload, { pad_left = should_switch == false })

  local function place_cursor()
    if not is_normal_window(target_win) then
      return
    end
    pcall(vim.api.nvim_win_set_cursor, target_win, { new_row + 1, new_col })
  end

  if should_switch then
    vim.schedule(function()
      if is_normal_window(target_win) then
        vim.api.nvim_set_current_win(target_win)
        place_cursor()
      end
    end)
  else
    -- Keep cursor in the target window progressing so future sends append
    place_cursor()
  end
end

-- Send clipboard
function M.send_clipboard(opts)
  local clipboard = vim.fn.getreg('+')
  M.send_text(clipboard, opts)
end

-- Send selected lines
function M.send_selection(opts)
  local start_pos, end_pos = utils.get_visual_positions()
  local lines = vim.api.nvim_buf_get_lines(0, start_pos[2] - 1, end_pos[2], false)

  if #lines == 0 then return end

  if #lines == 1 then
    lines[1] = string.sub(lines[1], start_pos[3], end_pos[3])
  else
    lines[1] = string.sub(lines[1], start_pos[3])
    lines[#lines] = string.sub(lines[#lines], 1, end_pos[3])
  end

  local text = table.concat(lines, '\n')
  M.send_text(text, opts)
end

function M.setup(opts)
  opts = opts or {}

  local keymaps = opts.keymaps or {
    send_clipboard = '<localleader>wc',
    send_selection = '<localleader>ws',
  }

  vim.keymap.set('n', keymaps.send_clipboard, function()
    M.send_clipboard({ switch = opts.switch })
  end, { desc = 'Send clipboard to last window' })

  vim.keymap.set('v', keymaps.send_selection, function()
    M.send_selection({ switch = opts.switch })
    utils.exit_visual_mode()
  end, { desc = 'Send selection to last window' })
end

return M
