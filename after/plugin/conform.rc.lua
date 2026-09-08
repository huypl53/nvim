local status, conform = pcall(require, "conform")
if not status then
  return
end

-- Prefer the faster prettierd daemon and fall back to project-local Prettier.
-- Run only the first available formatter so files are never formatted twice.
local js_formatters = { "prettierd", "prettier", stop_after_first = true }

conform.setup({
  formatters_by_ft = {
    lua = { "stylua" },
    -- Conform will run multiple formatters sequentially
    python = { "ruff_fix", "ruff_format", "ruff_organize_imports" },
    -- Use a sub-list to run only the first available formatter
    javascript = js_formatters,
    javascriptreact = js_formatters,
    ["javascript.jsx"] = js_formatters,
    jsx = js_formatters,
    typescript = js_formatters,
    typescriptreact = js_formatters,
    ["typescript.tsx"] = js_formatters,
    json = { "jq" },
    sql = { "sql_formatter" },
  },
  format_on_save = function(bufnr)
    -- Disable with a global or buffer-local variable
    if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
      return
    end
    return { lsp_format = "never" }
  end,
})

vim.api.nvim_create_user_command("FormatDisable", function(args)
  if args.bang then
    -- FormatDisable! will disable formatting just for this buffer
    vim.b.disable_autoformat = true
  else
    vim.g.disable_autoformat = true
  end
end, {
  desc = "Disable autoformat-on-save",
  bang = true,
})
vim.api.nvim_create_user_command("FormatEnable", function()
  vim.b.disable_autoformat = false
  vim.g.disable_autoformat = false
end, {
  desc = "Re-enable autoformat-on-save",
})
