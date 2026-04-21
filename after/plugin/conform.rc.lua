local status, conform = pcall(require, "conform")
if not status then
  return
end

local js_formatters = { "prettierd", "prettier" }
if vim.fn.executable("deno") == 1 then
  table.insert(js_formatters, 1, "deno_fmt")
end

conform.setup({
  formatters_by_ft = {
    lua = { "stylua" },
    -- Conform will run multiple formatters sequentially
    python = { "ruff_fix", "ruff_format", "ruff_organize_imports" },
    -- Use a sub-list to run only the first available formatter
    javascript = js_formatters,
    javascriptreact = js_formatters,
    typescript = js_formatters,
    typescriptreact = js_formatters,
    json = { "jq" },
    sql = { "sql_formatter" },
  },
  -- format_on_save = function(bufnr)
  format_after_save = function(bufnr)
    -- Disable with a global or buffer-local variable
    if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
      return
    end
    return { lsp_format = "fallback", async = true }
  end,
})

conform.formatters.prettier = {
  prepend_args = { "--prose-wrap", "always" },
}

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
