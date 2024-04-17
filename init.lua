require('plugins')
require('colorscheme')

local vim_options_path = string.format("%s/core/options.vim", vim.fn.stdpath("config"))
local vim_options_cmd = "source " .. vim_options_path
vim.cmd(vim_options_cmd)
