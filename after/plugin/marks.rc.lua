local status, marks = pcall(require, "marks")
if (not status) then return end

marks.setup {}

vim.keymap.set('n', '<leader>ml', '<cmd>MarksQFListBuf<cr>', {})
vim.keymap.set('n', '<leader>mL', '<cmd>MarksQFListGlobal<cr>', {})
