-- Shared utility functions for Neovim configuration
local M = {}

-- Exit visual mode
function M.exit_visual_mode()
	vim.cmd("normal! \27") -- ESC to exit visual mode
end

-- Get visual selection range (line numbers)
-- Returns: start_line, end_line (sorted so start <= end)
function M.get_visual_range()
	local start_line = vim.fn.line("v")
	local end_line = vim.fn.line(".")

	if start_line > end_line then
		start_line, end_line = end_line, start_line
	end

	return start_line, end_line
end

-- Get visual selection positions (for character-level selection)
-- Returns: start_pos, end_pos
function M.get_visual_positions()
	return vim.fn.getpos("'<"), vim.fn.getpos("'>")
end

-- Check if currently in visual mode
function M.is_visual_mode()
	local mode = vim.fn.mode()
	return mode == "v" or mode == "V" or mode == "\22"
end

-- Get relative file path from current working directory
function M.get_relative_path()
	return vim.fn.substitute(vim.fn.expand("%:p"), vim.fn.getcwd() .. "/", "", "g")
end

-- Copy relative path (prefixed with @) to system clipboard
function M.copy_relative_path(not_clipboard)
	local path = M.get_relative_path()
	local result = "@" .. path
	if not_clipboard then
		vim.fn.setreg("+", result)
	end
	print("Copied: " .. result)
	return result
end

function M.copy_path_with_lines(not_clipboard)
	local path = M.get_relative_path()
	local line_info

	if M.is_visual_mode() then
		-- Visual mode: get range
		local start_line, end_line = M.get_visual_range()
		line_info = start_line == end_line and tostring(start_line) or string.format("%d-%d", start_line, end_line)
	else
		-- Normal mode: current line
		line_info = tostring(vim.fn.line("."))
	end

	local result = string.format(" @%s#%s", path, line_info)
	if not_clipboard == nil then
		vim.fn.setreg("+", result)
	end
	print("Copied: " .. result)
	return result
end

return M
