local status, todo = pcall(require, "todo-comments")
if (not status) then return end

todo.setup {
}

-- vim.keymap.set('n', 'sz', '<cmd>ZenMode<cr>', { silent = true })
