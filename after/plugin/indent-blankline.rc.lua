local status, blankline = pcall(require, "ibl")
if (not status) then return end

vim.opt.termguicolors = true
vim.cmd [[highlight IndentBlanklineIndent guifg=#E06C75 gui=nocombine]]
vim.opt.list = true
vim.opt.listchars:append "eol:↴"

blankline.setup {
  scope = {
    enabled = true
  }
}
