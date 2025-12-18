-- Copy relative file path with line number(s)
-- Usage: In normal mode copies current line, in visual mode copies line range

local utils = require('utils')


vim.keymap.set("n", "yr", function()
  utils.copy_relative_path()
end)

-- Key mappings
vim.keymap.set('v', '<leader>yr', function()
  utils.copy_path_with_lines()
  utils.exit_visual_mode()
end, { desc = 'Copy path with line range' })

local status, term_send = pcall(require, 'terminal-send')
if (not status) then return end

local function send_path_lines(opts)
  utils.copy_path_with_lines()
  if utils.is_visual_mode() then
    utils.exit_visual_mode()
  end
  term_send.send_clipboard(opts)
end

vim.keymap.set('v', '<localleader>l', function()
  send_path_lines()
end, { desc = 'copy path with lines then send to term' })

vim.keymap.set('n', '<localleader>l', function()
  send_path_lines()
end, { desc = 'copy path with lines then send to term' })

vim.keymap.set('v', '<localleader>L', function()
  send_path_lines({ switch = false })
end, { desc = 'copy path with lines then send to term (stay)' })

vim.keymap.set('n', '<localleader>L', function()
  send_path_lines({ switch = false })
end, { desc = 'copy path with lines then send to term (stay)' })

-- Send to last window instead of terminal
local win_status, win_send = pcall(require, 'window-send')
if win_status then
  local function send_path_lines_window(opts)
    utils.copy_path_with_lines()
    if utils.is_visual_mode() then
      utils.exit_visual_mode()
    end
    win_send.send_clipboard(opts)
  end

  vim.keymap.set('v', '<localleader>k', function()
    send_path_lines_window()
  end, { desc = 'copy path with lines then send to window' })

  vim.keymap.set('n', '<localleader>k', function()
    send_path_lines_window()
  end, { desc = 'copy path with lines then send to window' })

  vim.keymap.set('v', '<localleader>K', function()
    send_path_lines_window({ switch = false })
  end, { desc = 'copy path with lines then send to window (stay)' })

  vim.keymap.set('n', '<localleader>K', function()
    send_path_lines_window({ switch = false })
  end, { desc = 'copy path with lines then send to window (stay)' })
end
