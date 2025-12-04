local status, tg_term = pcall(require, 'toggleterm.terminal')
if not status then return end

local Terminal = tg_term.Terminal

local term_status, toggleterm = pcall(require, 'toggleterm')
if not term_status then return end
toggleterm.setup({
  size = function(term)
    if term.direction == "horizontal" then
      return 15
    elseif term.direction == "vertical" then
      return vim.o.columns * 0.3
    end
  end,
})

local lazygit = Terminal:new({
  cmd = "lazygit",
  dir = "git_dir",
  direction = "float",
  float_opts = {
    border = "double",
  },
  -- function to run on opening the terminal
  on_open = function(term)
    vim.cmd("startinsert!")
    vim.api.nvim_buf_set_keymap(term.bufnr, "n", "q", "<cmd>close<CR>", { noremap = true, silent = true })
    -- Reduce timeout to prevent double Esc press
    vim.keymap.set('t', '<Esc>', '<Esc>', { buffer = term.bufnr, nowait = true })
  end,
  -- function to run on closing the terminal
  on_close = function(term)
    vim.cmd("startinsert!")
  end,
})

function _term_lazygit_toggle()
  lazygit:toggle()
end

vim.api.nvim_set_keymap("n", "<leader>tg", "<cmd>lua _term_lazygit_toggle()<CR>", { noremap = true, silent = true })

--#region
local toggle_float_term = Terminal:new({
  -- cmd = "lazygit",
  dir = "git_dir",
  direction = "float",
  float_opts = {
    border = "double",
  },
  -- function to run on opening the terminal
  on_open = function(term)
    vim.cmd("startinsert!")
    vim.api.nvim_buf_set_keymap(term.bufnr, "n", "q", "<cmd>close<CR>", { noremap = true, silent = true })
  end,
  -- function to run on closing the terminal
  on_close = function(term)
    vim.cmd("startinsert!")
  end,
  insert_mappings = true,
  terminal_mappings = true
})

function _float_term_toggle()
  toggle_float_term:toggle()
end

vim.api.nvim_set_keymap("n", "<leader>tf", "<cmd>lua _float_term_toggle()<CR>", { noremap = true, silent = true })

local toggle_vertical_term = Terminal:new({
  -- cmd = "lazygit",
  dir = "git_dir",
  direction = "vertical", -- "float",
  float_opts = {
    border = "double",
  },
  -- function to run on opening the terminal
  on_open = function(term)
    vim.cmd("startinsert!")
    vim.api.nvim_buf_set_keymap(term.bufnr, "n", "q", "<cmd>close<CR>", { noremap = true, silent = true })
  end,
  -- function to run on closing the terminal
  on_close = function(term)
    vim.cmd("startinsert!")
  end,
  insert_mappings = true,
  terminal_mappings = true
})

function _vertical_term_toggle()
  toggle_vertical_term:toggle()
end

vim.api.nvim_set_keymap("n", "<leader>tv", "<cmd>lua _vertical_term_toggle()<CR>", { noremap = true, silent = true })
--#endregion
