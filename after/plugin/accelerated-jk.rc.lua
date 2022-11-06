local status, jk = pcall(require, "accelerated-jk")
if (not status) then return end

jk.setup({
  vim.keymap.set('n', 'j', '<Plug>(accelerated_jk_gj)'),
  vim.keymap.set('n', 'k', '<Plug>(accelerated_jk_gk)'),
})
