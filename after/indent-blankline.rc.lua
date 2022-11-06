local status, blankline = pcall(require, "indent-blankline")
if (not status) then return end

blankline.setup({
  "lukas-reineke/indent-blankline.nvim",
  event = "BufRead",
  setup = function()
    vim.g.indentLine_enabled = 1
    vim.g.indent_blankline_char = "▏"

    vim.g.indent_blankline_filetype_exclude = { "help", "terminal", "dashboard", "packer" }
    vim.g.indent_blankline_buftype_exclude = { "terminal" }

    vim.g.indent_blankline_show_trailing_blankline_indent = false
    vim.g.indent_blankline_show_first_indent_level = false
    vim.g.indent_blankline_char_highlight_list = {
      "Underlined",
      "Method",
      "Type",
      "Float",
      "Conditional",
      "String",
      "Debug",

      "Method",
      "Type",
      "Float",
      "Conditional",
      "String",
      "Debug",
      -- "SpecialComment"
    }
    vim.g.indent_blankline_show_current_context = true
    vim.g.indent_blankline_show_current_start = true
    vim.cmd("highlight IndentBlanklineContextStart guisp=#00FF00 gui=underline")
  end,
})
