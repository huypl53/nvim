local status, dap = pcall(require, "dap")
if not status then
  return
end

dap.defaults.fallback.terminal_win_cmd = "belowright 5split new"

local status, dap_widgets = pcall(require, "dap.ui.widgets")
if not status then
  return
end

-- dap_widgets = dap.ui.widgets
vim.keymap.set("n", "<Leader>dq", function()
  dap.terminate()
end, { desc = "Terminate dap session" })
vim.keymap.set("n", "<F5>", function()
  dap.continue()
end, { desc = "Debugger continue" })
vim.keymap.set("n", "<F10>", function()
  dap.step_over()
end, { desc = "Debugger step over" })
vim.keymap.set("n", "<F11>", function()
  dap.step_into()
end, { desc = "Debugger step into" })
vim.keymap.set("n", "<F12>", function()
  dap.step_out()
end, { desc = "Debugger step out" })
vim.keymap.set("n", "<Leader>da", function()
  dap.list_breakpoints()
  vim.cmd [[copen]]
end, { desc = "Lists all breakpoints and log points in quickfix window." })
vim.keymap.set("n", "<Leader>db", function()
  dap.toggle_breakpoint()
end, { desc = "Debugger toggle toggle breakpoint" })
vim.keymap.set("n", "<Leader>dB", function()
  dap.set_breakpoint()
end, { desc = "Debugger set breakpoint" })
-- vim.keymap.set("n", "<Leader>lp", function()
--   dap.set_breakpoint(nil, nil, vim.fn.input("Log point message: "))
-- end)
vim.keymap.set("n", "<Leader>dr", function()
  dap.repl.open()
end, { desc = "Debugger REPL open" })
vim.keymap.set("n", "<Leader>dl", function()
  dap.run_last()
end, { desc = "Debugger run last" })

vim.keymap.set("n", "<Leader>dj", function()
  dap.focus_frame()
end, { desc = "Jump to current frame" })

vim.keymap.set({ "n", "v" }, "<Leader>dh", function()
  dap_widgets.hover()
end, { desc = "Debugger hover" })
vim.keymap.set({ "n", "v" }, "<Leader>dp", function()
  dap_widgets.preview()
end, { desc = "Debugger preview" })
vim.keymap.set("n", "<Leader>df", function()
  dap_widgets.centered_float(dap_widgets.frames)
end, { desc = "Debugger center float frame" })
vim.keymap.set("n", "<Leader>ds", function()
  dap_widgets.centered_float(dap_widgets.scopes)
end, { desc = "Debugger center float scope" })

vim.keymap.set("n", "<Leader>de", function()
  local my_sidebar = dap_widgets.sidebar(dap_widgets.scopes, {}, "100vsplit")
  my_sidebar.open()
end)

local status, dap_python = pcall(require, "dap-python")
if not status then
  return
end

dap_python.setup('uv')
