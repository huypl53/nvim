local status, bqf = pcall(require, "nvim-bqf")
if (not status) then return end

-- vim.cmd("hi BqfPreviewBorder guifg=#50a14f ctermfg=71")
-- vim.cmd("hi link BqfPreviewRange Search")
-- vim.cmd("hi default link BqfPreviewFloat Normal")
-- vim.cmd("hi default link BqfPreviewBorder Normal")
-- vim.cmd("hi default link BqfPreviewCursor Cursor")
-- vim.cmd("hi default link BqfPreviewRange IncSearch")
-- vim.cmd("hi default BqfSign ctermfg=14 guifg=Cyan")

bqf.setup({
  auto_enable = true,
  auto_resize_height = true, -- highly recommended enable
  preview = {
    win_height = 12,
    win_vheight = 12,
    delay_syntax = 80,
    border = { '┏', '━', '┓', '┃', '┛', '━', '┗', '┃' },
    show_title = false,
    should_preview_cb = function(bufnr, qwinid)
      local ret = true
      local bufname = vim.api.nvim_buf_get_name(bufnr)
      local fsize = vim.fn.getfsize(bufname)
      if fsize > 100 * 1024 then
        -- skip file size greater than 100k
        ret = false
      elseif bufname:match('^fugitive://') then
        -- skip fugitive buffer
        ret = false
      end
      return ret
    end
  },
  -- make `drop` and `tab drop` to become preferred
  func_map = {
    drop        = 'o',
    openc       = 'O',
    -- split = '<C-s>',
    tabdrop     = '<C-t>',
    -- set to empty string to disable
    tab         = 't',
    tabb        = 'T',
    tabc        = '<C-t>',
    split       = '<C-x>',
    vsplit      = '<C-v>',
    prevfile    = '<C-p>',
    nextfile    = '<C-n>',
    prevhist    = '<',
    nexthist    = '>',
    lastleave   = "'\"",
    stoggleup   = '<S-Tab>',
    stoggledown = '<Tab>',
    stogglevm   = '<Tab>',
    stogglebuf  = "'<Tab>",
    sclear      = 'z<Tab>',
    pscrollup   = '<C-b>',
    pscrolldown = '<C-f>',
    pscrollorig = 'zo',
    ptogglemode = 'zp',
    ptoggleitem = 'p',
    ptoggleauto = 'P',
    filter      = 'zn',
    filterr     = 'zN',
    fzffilter   = 'zf',
  },
  filter = {
    fzf = {
      action_for = { ['ctrl-s'] = 'split', ['ctrl-t'] = 'tab drop' },
      extra_opts = { '--bind', 'ctrl-o:toggle-all', '--prompt', '> ' }
    }
  }
})

vim.cmd([[
    hi BqfPreviewBorder guifg=#3e8e2d ctermfg=71
    hi BqfPreviewTitle guifg=#3e8e2d ctermfg=71
    hi BqfPreviewThumb guibg=#3e8e2d ctermbg=71
    hi link BqfPreviewRange Search
]])
