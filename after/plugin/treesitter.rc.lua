local status, ts = pcall(require, "nvim-treesitter.configs")
if not status then
  return
end

ts.setup({
  highlight = {
    enable = true,
    disable = {},
  },
  indent = {
    enable = true,
    disable = {},
  },
  ensure_installed = {
    "vim",
    "tsx",
    "toml",
    "php",
    "json",
    "yaml",
    "css",
    "html",
    "lua",
    "dart",
    "python",
    "typescript",
    "javascript",
  },
  auto_install = false,
})

local parser_config = require("nvim-treesitter.parsers").get_parser_configs()
parser_config.tsx.filetype_to_parsername = { "javascript", "typescript.tsx" }

local context_comment = require("ts_context_commentstring").setup({})
vim.g.skip_ts_context_commentstring_module = true
