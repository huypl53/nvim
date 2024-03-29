local status, saga = pcall(require, "lspsaga")
if (not status) then return end

saga.setup {
  -- server_filetype_map = {
  --   typescript = 'typescript'
  -- },
  code_action_icon = "",
  ui = {
    code_action = "",
  },
  symbol_in_winbar = {
    in_custom = false,
    enable = true,
    separator = ' ',
    show_file = true,
    -- define how to customize filename, eg: %:., %
    -- if not set, use default value `%:t`
    -- more information see `vim.fn.expand` or `expand`
    -- ## only valid after set `show_file = true`
    file_formatter = "",
    click_support = false,
  },
  finder = {
    max_height = 0.5,
    -- min_width = 30,
    -- force_max_height = false,
    keys = {
      shuttle        = 'p',
      toggle_or_open = 'o',
      vsplit         = 'v',
      split          = 'i',
      tabe           = 't',
      tabnew         = 'r',
      quit           = { 'q', '<ESC>' },
      close          = '<ESC>',
    },
  },
  definition = {
    edit = "<C-c>o",
    vsplit = "<C-c>v",
    split = "<C-c>i",
    tabe = "<C-c>t",
    quit = "q",
  }
}

local opts = { noremap = true, silent = true }
vim.keymap.set('n', '<C-j>', '<Cmd>Lspsaga diagnostic_jump_next<CR>', opts)
vim.keymap.set('n', '<C-k>', '<Cmd>Lspsaga show_cursor_diagnostics<CR>', opts)
vim.keymap.set('n', 'K', '<Cmd>Lspsaga hover_doc<CR>', opts)
vim.keymap.set('n', 'gd', '<Cmd>Lspsaga finder <CR>', opts)
vim.keymap.set('i', '<C-k>', '<Cmd>Lspsaga signature_help<CR>', opts)
vim.keymap.set('n', 'gp', '<Cmd>Lspsaga peek_definition<CR>', opts)
vim.keymap.set('n', 'go', '<Cmd>Lspsaga outline<CR>', opts)
vim.keymap.set('n', 'gr', '<Cmd>Lspsaga rename<CR>', opts)
vim.keymap.set('n', 'ga', '<Cmd>Lspsaga code_action<CR>', opts)
