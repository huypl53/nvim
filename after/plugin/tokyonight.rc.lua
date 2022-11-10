local status, tokyonight = pcall(require, "tokyonight")
if (not status) then return end

vim.g.tokyonight_style = "night"
vim.g.tokyonight_italic_functions = true
vim.g.tokyonight_transparent = true
vim.g.tokyonight_transparent_sidebar = true

tokyonight.setup({
  style = 'moon',
  light_style = 'night',
  transparent = true,
})

vim.cmd [[colorscheme tokyonight]]
