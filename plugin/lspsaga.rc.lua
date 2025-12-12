local status, saga = pcall(require, "lspsaga")
if (not status) then return end

saga.setup {
  -- server_filetype_map = {
  --   typescript = 'typescript'
  -- },
  code_action_icon = "",
  symbol_in_winbar = {
    enable = true,
    hide_keyword = false,
    separator = ' ',
    show_file = true,
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
  },
  outline = {
    auto_preview = false,
    detail = false
  },
  ui = {
    -- Ensure icons are used in other UI elements
    code_action = "💡",
    diagnostic = "",
  },
  diagnostic = {
    show_code_action = true,
    show_source = false,
    jump_diagnostic = true,
    diagnostic_only_current = false,
    -- Ensure lspsaga handles floating windows
    auto_preview = false, -- Show diagnostic window on hover
    -- max_height = 10,
    -- max_width = 80,
    signs = false, -- Let Neovim handle signs (already configured)
  },
}

local opts = { noremap = true, silent = true }
vim.keymap.set('n', '<C-j>', '<Cmd>Lspsaga diagnostic_jump_next<CR>', opts)
vim.keymap.set('n', '<C-k>', '<Cmd>Lspsaga show_cursor_diagnostics<CR>', opts)
vim.keymap.set('n', 'K', '<Cmd>Lspsaga hover_doc<CR>', opts)
vim.keymap.set('n', 'gD', '<Cmd>Lspsaga goto_type_definition <CR>', opts)
vim.keymap.set('n', 'gd', '<Cmd>Lspsaga goto_definition <CR>', opts)
-- vim.keymap.set('n', 'gf', '<Cmd>Lspsaga finder <CR>', opts)
vim.keymap.set('n', 'gp', '<Cmd>Lspsaga peek_definition<CR>', opts)
vim.keymap.set('n', 'gP', '<Cmd>Lspsaga peek_type_definition<CR>', opts)
-- vim.keymap.set('n', 'go', '<Cmd>Lspsaga outline<CR>', opts)
vim.keymap.set('n', 'gr', '<Cmd>Lspsaga rename<CR>', opts)
vim.keymap.set('n', 'ga', '<Cmd>Lspsaga code_action<CR>', opts)
