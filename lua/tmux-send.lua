local utils = require('utils')

vim.keymap.set({ 'n', 'v' }, '<leader>l', function()
  local path_lines = utils.copy_path_with_lines(true)
  utils.exit_visual_mode()
  path_lines = ' ' .. path_lines .. ' '
  local tmux_cmd = 'tmux send-key -t ! "' .. path_lines .. '" && tmux last-pane'
  local send_cmd = 'call system(\'' .. tmux_cmd .. '\')'
  print(send_cmd)
  vim.cmd(send_cmd)
end)

vim.keymap.set({ 'n', 'v' }, '<leader>L', function()
  local path_lines = utils.copy_path_with_lines(true)
  utils.exit_visual_mode()
  path_lines = ' ' .. path_lines .. ' '
  local tmux_cmd = 'tmux send-key -t ! "' .. path_lines .. '"'
  local send_cmd = 'call system(\'' .. tmux_cmd .. '\')'
  print(send_cmd)
  vim.cmd(send_cmd)
end)



vim.keymap.set({ 'n', 'v' }, '<leader>k', function()
  local path_lines = utils.copy_relative_path(true)
  utils.exit_visual_mode()
  path_lines = ' ' .. path_lines .. ' '
  local tmux_cmd = 'tmux send-key -t ! "' .. path_lines .. '" && tmux last-pane'
  local send_cmd = 'call system(\'' .. tmux_cmd .. '\')'
  print(send_cmd)
  vim.cmd(send_cmd)
end)

vim.keymap.set({ 'n', 'v' }, '<leader>K', function()
  local path_lines = utils.copy_relative_path(true)
  utils.exit_visual_mode()
  path_lines = ' ' .. path_lines .. ' '
  local tmux_cmd = 'tmux send-key -t ! "' .. path_lines .. '"'
  local send_cmd = 'call system(\'' .. tmux_cmd .. '\')'
  print(send_cmd)
  vim.cmd(send_cmd)
end)
