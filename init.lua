require("base")
require("highlights")
require("maps")
require("grep")
require("ultra_maps")

local has = vim.fn.has
local is_wsl = has("unix") == 1 and vim.fn.environ().WSL_DISTRO_NAME ~= nil
local is_mac = has("macunix") == 1
local is_win = has("win32") == 1
local is_unix = has("unix") == 1 and not is_mac and not is_wsl

-- Universal clipboard integration (tmux, OSC 52, and system clipboard)
local function clipboard_copy(lines, regtype)
	if vim.fn.executable("tmux") == 1 then
		local cmd = vim.env.TMUX and { "tmux", "load-buffer", "-w", "-" } or { "tmux", "load-buffer", "-" }
		vim.fn.system(cmd, lines)
	end
	pcall(function()
		require("vim.ui.clipboard.osc52").copy("+")(lines, regtype)
	end)
	if vim.fn.has("mac") == 1 and vim.fn.executable("pbcopy") == 1 then
		vim.fn.system({ "pbcopy" }, lines)
	elseif vim.env.WAYLAND_DISPLAY and vim.fn.executable("wl-copy") == 1 then
		vim.fn.system({ "wl-copy" }, lines)
	elseif vim.env.DISPLAY and vim.fn.executable("xclip") == 1 then
		vim.fn.system({ "xclip", "-selection", "clipboard" }, lines)
	end
end

local function clipboard_paste()
	if vim.env.TMUX then
		local out = vim.fn.systemlist({ "tmux", "save-buffer", "-" })
		if vim.v.shell_error == 0 and #out > 0 then
			return { out, "v" }
		end
	end
	if vim.fn.has("mac") == 1 and vim.fn.executable("pbpaste") == 1 then
		return { vim.fn.systemlist({ "pbpaste" }), "v" }
	end
	if vim.fn.executable("tmux") == 1 then
		local out = vim.fn.systemlist({ "tmux", "save-buffer", "-" })
		if vim.v.shell_error == 0 and #out > 0 then
			return { out, "v" }
		end
	end
	return { { "" }, "v" }
end

vim.g.clipboard = {
	name = "universal-clipboard",
	copy = {
		["+"] = clipboard_copy,
		["*"] = clipboard_copy,
	},
	paste = {
		["+"] = clipboard_paste,
		["*"] = clipboard_paste,
	},
	cache_enabled = false,
}

if is_mac then
	require("macos")
elseif is_wsl or is_win then
	require("windows")
elseif is_unix then
	require("unix")
end

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	-- if not (vim.loop).fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end

vim.opt.rtp:prepend(lazypath)

require("plugins")
require("tmux-send")
require("terminal-send").setup()
require("window-send").setup()
