require('base')
require('highlights')
require('maps')

local has = vim.fn.has
local is_mac = has "macunix"
local is_win = has "win32"
local is_unix = has "unix"

if is_mac then
  require('macos')
end
if is_win then
  require('windows')
end

if is_unix then
  require('unix')
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

require('plugins')

