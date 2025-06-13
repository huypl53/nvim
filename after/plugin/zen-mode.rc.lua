local status, zenMode = pcall(require, "zen-mode")
if (not status) then return end


local status_vista, vista = pcall(require, "zen-mode")
if (not status_vista) then return end

zenMode.setup {
  plugins = {
    twilight = { enabled = false }
  },
  on_open = function()
    if status_vista then
      vim.cmd("Vista!") -- Close vista when entering Zen mode
    end
  end,
  on_close = function()
    if status_vista then
      vim.cmd("Vista") -- Reopen vista when exiting Zen mode
    end
  end,
}

vim.keymap.set('n', 'sz', '<cmd>ZenMode<cr>', { silent = true })
