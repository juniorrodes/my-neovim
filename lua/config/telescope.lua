return {
    'nvim-telescope/telescope.nvim',
    config = function()
        local builtin = require('telescope.builtin')
        local telescope = require('telescope')
        telescope.setup({
            pickers = {
                find_files = {
                    hidden = true,
                },
            }
        })
        vim.keymap.set('n', '<Leader>ff', builtin.find_files, {})
        vim.keymap.set('n', '<Leader>fg', builtin.live_grep, {})
    end,
    keys = {
        { '<Leader>ff', '<cmd>Telescope find_files<cr>', desc = 'Find files' },
        { '<Leader>fg', '<cmd>Telescope live_grep<cr>', desc = 'Live grep' },
    },
}
