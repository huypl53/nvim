vim.opt.cursorline = true
vim.opt.cursorcolumn = true
vim.opt.termguicolors = true
vim.opt.winblend = 0
vim.opt.wildoptions = 'pum'
vim.opt.pumblend = 5
vim.opt.background = 'dark'

vim.diagnostic.config({
  signs = {
    active = true,
    priority = 100,
    text = {
      -- [vim.diagnostic.severity.ERROR] = " ",
      -- [vim.diagnostic.severity.WARN]  = " ",
      -- [vim.diagnostic.severity.HINT]  = " ",
      -- [vim.diagnostic.severity.INFO]  = " ",
      [vim.diagnostic.severity.ERROR] = " ",
      [vim.diagnostic.severity.WARN] = " ",
      [vim.diagnostic.severity.HINT] = " ",
      [vim.diagnostic.severity.INFO] = " ",
    }
  },

  -- virtual_text = {
  --   prefix = "●",
  -- },
  virtual_text = true,
  update_in_insert = false,
  serverity_sort = true,
  float = {
    source = "if_many", -- Or "if_many"
  },
  severity_sort = true

})
