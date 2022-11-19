local status, hop = pcall(require, "hop")
if (not status) then return end

hop.setup()

vim.api.nvim_set_keymap("n", "sc", ":HopChar1<CR>", { silent = true })
vim.api.nvim_set_keymap("n", "sw", ":HopWord<CR>", { silent = true })
