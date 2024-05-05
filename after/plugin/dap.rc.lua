local status, dap = pcall(require, "dap")
if not status then
	return
end

local status, dap_python = pcall(require, "dap-python")
if not status then
	return
end

dap_python.setup()
