local status, lazy = pcall(require, "lazy")
if not status then
  print("lazy is not installed")
  return
end

-- vim.cmd [[packadd lazy.nvim]]

lazy.setup({
  {
    import = "plugins.user.always",
    cond = true,
  },
  { import = "plugins.user.notvscode", cond = (function() return not vim.g.vscode end) },
  { import = "plugins.user.vscode",    cond = (function() return vim.g.vscode end) },
})
