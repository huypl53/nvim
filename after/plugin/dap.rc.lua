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
vim.keymap.set("n", "<F5>", function()
	dap.continue()
end)
vim.keymap.set("n", "<F10>", function()
	dap.step_over()
end)
vim.keymap.set("n", "<F11>", function()
	dap.step_into()
end)
vim.keymap.set("n", "<F12>", function()
	dap.step_out()
end)
vim.keymap.set("n", "<Leader>b", function()
	dap.toggle_breakpoint()
end)
vim.keymap.set("n", "<Leader>B", function()
	dap.set_breakpoint()
end)
vim.keymap.set("n", "<Leader>lp", function()
	dap.set_breakpoint(nil, nil, vim.fn.input("Log point message: "))
end)
vim.keymap.set("n", "<Leader>dr", function()
	dap.repl.open()
end)
vim.keymap.set("n", "<Leader>dl", function()
	dap.run_last()
end)
vim.keymap.set({ "n", "v" }, "<Leader>dh", function()
	dap_widgets.hover()
end)
vim.keymap.set({ "n", "v" }, "<Leader>dp", function()
	dap_widgets.preview()
end)
vim.keymap.set("n", "<Leader>df", function()
	dap_widgets.centered_float(dap_widgets.frames)
end)
vim.keymap.set("n", "<Leader>ds", function()
	dap_widgets.centered_float(dap_widgets.scopes)
end)

vim.keymap.set("n", "<Leader>de", function()
	local my_sidebar = dap_widgets.sidebar(dap_widgets.scopes, {}, "100vsplit")
	my_sidebar.open()
end)

local status, dap_python = pcall(require, "dap-python")
if not status then
	return
end

dap_python.setup()
