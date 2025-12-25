local status, marks = pcall(require, "marks")
if (not status) then return end

marks.setup {}

vim.keymap.set('n', '<leader>mlb', '<cmd>MarksQFListBuf<cr>', {})
vim.keymap.set('n', '<leader>mlg', '<cmd>MarksQFListGlobal<cr>', {})
