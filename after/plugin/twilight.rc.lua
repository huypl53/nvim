local status, twilight = pcall(require, "zen-mode")
if (not status) then return end

twilight.setup {
}

vim.keymap.set('n', 'st', '<cmd>Twilight<cr>')
