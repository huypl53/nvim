local status, ufo = pcall(require, "ufo")
if not status then
  return
end
local ftMap = {
  vim = 'indent',
  python = { 'indent' },
  git = ''
}
ufo.setup({
  open_fold_hl_timeout = 150,
  close_fold_kinds_for_ft = {
    default = { 'imports', 'comment' },
    json = { 'array' },
    c = { 'comment', 'region' }
  },
  close_fold_current_line_for_ft = {
    default = true,
    c = false
  },
  preview = {
    win_config = {
      border = { '', '─', '', '', '', '─', '', '' },
      winhighlight = 'Normal:Folded',
      winblend = 0
    },
    mappings = {
      scrollU = '<C-u>',
      scrollD = '<C-d>',
      jumpTop = '[',
      jumpBot = ']'
    }
  },
  provider_selector = function(bufnr, filetype, buftype)
    -- if you prefer treesitter provider rather than lsp,
    -- return ftMap[filetype] or {'treesitter', 'indent'}
    return ftMap[filetype]

    -- refer to ./doc/example.lua for detail
  end
})
vim.o.foldcolumn = '1' -- '0' is not bad
vim.o.foldlevel = 99   -- Using ufo provider need a large value, feel free to decrease the value
vim.o.foldlevelstart = 99
vim.o.foldenable = true

-- Using ufo provider need remap `zR` and `zM`. If Neovim is 0.6.1, remap yourself
vim.keymap.set('n', 'zR', require('ufo').openAllFolds)
vim.keymap.set('n', 'zM', require('ufo').closeAllFolds)
-- vim.keymap.set('n', 'zr', require('ufo').openFoldsExceptKinds)
-- vim.keymap.set('n', 'zm', require('ufo').closeFoldsWith) -- closeAllFolds == closeFoldsWith(0)
vim.keymap.set('n', 'zk', function()
  local winid = require('ufo').peekFoldedLinesUnderCursor()
  if not winid then
    -- choose one of coc.nvim and nvim lsp
    vim.fn.CocActionAsync('definitionHover') -- coc.nvim
    vim.lsp.buf.hover()
  end
end)

vim.cmd [[hi default link UfoPreviewSbar PmenuSbar ]]
vim.cmd [[hi default link UfoPreviewThumb PmenuThumb ]]
vim.cmd [[hi default link UfoPreviewWinBar UfoFoldedBg ]]
vim.cmd [[hi default link UfoPreviewCursorLine Visual ]]
vim.cmd [[hi default link UfoFoldedEllipsis Comment ]]
vim.cmd [[hi default link UfoCursorFoldedLine CursorLine ]]
