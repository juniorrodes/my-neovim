return {
    {
        'nvim-treesitter/nvim-treesitter',
        config = function ()
            local treesitter = require('nvim-treesitter.configs')

            treesitter.setup {
                ensure_installed = { 'lua', 'go', 'templ', 'c', 'rust', 'zig', 'typescript', 'javascript' },
                sync_install = false,
                ident = true,
                highlight = {
                    enable = true,
                },
                auto_install = true,
                ignore_install = {},
                modules = {},
            }
        end,
    },
}
