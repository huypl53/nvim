local status, bqf = pcall(require, "nvim-bqf")
if (not status) then return end

bqf.setup({
  config = function()
    require("bqf").setup({
      auto_enable = true,
      preview = {
        win_height = 12,
        win_vheight = 12,
        delay_syntax = 80,
        border_chars = { "┃", "┃", "━", "━", "┏", "┓", "┗", "┛", "█" },
      },
      func_map = {
        vsplit = "",
        ptogglemode = "z,",
        stoggleup = "",
      },
      filter = {
        fzf = {
          action_for = { ["ctrl-s"] = "split" },
          extra_opts = { "--bind", "ctrl-o:toggle-all", "--prompt", "> " },
        },
      },
    })
    vim.cmd("hi BqfPreviewBorder guifg=#50a14f ctermfg=71")
    vim.cmd("hi link BqfPreviewRange Search")
    vim.cmd("hi default link BqfPreviewFloat Normal")
    vim.cmd("hi default link BqfPreviewBorder Normal")
    vim.cmd("hi default link BqfPreviewCursor Cursor")
    vim.cmd("hi default link BqfPreviewRange IncSearch")
    vim.cmd("hi default BqfSign ctermfg=14 guifg=Cyan")
  end
})
