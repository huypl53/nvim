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
