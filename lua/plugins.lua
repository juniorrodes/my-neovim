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

local plugins = {
    {
        'williamboman/mason.nvim',
        config = function()
            require('config.mason')
        end
    },
    {
        'nvim-treesitter/nvim-treesitter',
        config = function ()
            require('config.treesitter')
        end,
    },
    {
        'ziglang/zig.vim',
        ft = 'zig',
    },
    {
        'hrsh7th/nvim-cmp',
        dependencies = {
            'hrsh7th/cmp-nvim-lsp',
            'saadparwaiz1/cmp_luasnip',
            'L3MON4D3/LuaSnip',
        },
        config = function()
            require('config.nvim-cmp')
        end,
    },
    {
        'windwp/nvim-autopairs',
        config = function ()
            require('config.autopair')
        end
    },
    {
	    'neovim/nvim-lspconfig',
	    --event = { "BufRead", "BufNewFile" },
	    config = function()
	        require('config.lsp')
	    end,
    },
    {
        'lewis6991/hover.nvim',
        config = function ()
            require('config.hover')
        end
    },
    'rebelot/kanagawa.nvim',
    {
        'nvim-neo-tree/neo-tree.nvim',
        dependencies = {
            'nvim-lua/plenary.nvim',
            'nvim-tree/nvim-web-devicons',
            'MunifTanjim/nui.nvim'
        },
        config = function ()
            require('config.neo-tree')
        end,
        keys = {
            { '<Leader>tt', '<cmd>Neotree toggle<cr>' }
        }
    },
    {
        'nvim-telescope/telescope.nvim',
        cmd = 'Telescope',
        dependencies = {
            'nvim-telescope/telescope.nvim',
        },
        keys = {
            { '<Leader>ff', '<cmd>Telescope find_files<cr>' },
        },
        config = function ()
            require('config.telescope')
        end
    },
    {
        'nvim-lualine/lualine.nvim',
        dependencies = { 'nvim-tree/nvim-web-devicons' },
	    config = function ()
            require('config.lualine')
	    end
    },
    {
        'tikhomirov/vim-glsl',
        ft = 'glsl',
    },
    {
        'kevinhwang91/nvim-ufo',
        config = function ()
            require('config.ufo')
        end,
        dependencies = {
            'kevinhwang91/promise-async',
            'neovim/nvim-lspconfig'
        },
    },
    {
        'github/copilot.vim',
        enabled = isOSX,
    },
    {
        'ray-x/go.nvim',
        dependencies = {
            'ray-x/guihua.lua',
        },
	    ft = {"go", "gomod"},
        config = function ()
            require('go').setup{}
        end,
        event = { "CmdlineEnter" },
    },
    {
	    "kylechui/nvim-surround",
        event = "VeryLazy",
        config = function ()
            require('config.surround')
        end
    },
    {
        'folke/trouble.nvim',
        opts = {},
        cmd = 'Trouble',
        keys = {
            {
                '<leader>xx',
                '<cmd>Trouble diagnostics toggle<cr>',
                desc = 'Diagnostics (Trouble)',
            },
        },
    },
}

return require('lazy').setup(plugins)
