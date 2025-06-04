local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
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
vim.g.mapleader = " "

local isOSX = false
if vim.loop.os_uname().sysname == 'Darwin' then
    isOSX = true
end

require('lazy').setup({ import = 'config' })

require('colorscheme')
require('mappings')
require('commands')

local vim_options_path = string.format("%s/core/options.vim", vim.fn.stdpath("config"))
local vim_options_cmd = "source " .. vim_options_path
vim.cmd(vim_options_cmd)
