return {
    'lewis6991/hover.nvim',
    config = function ()
        local hover = require('hover')

        hover.config({
            providers = {
                'hover.providers.lsp'
            },
            preview_opts = {
              border = 'single'
            },
            preview_window = false,
            title = true,
            mouse_providers = {
              'LSP'
            },
        })

        -- Setup keymaps
        vim.keymap.set("n", "K", hover.open, {desc = "hover.nvim"})
        vim.keymap.set("n", "gK", hover.enter, {desc = "hover.nvim (select)"})
    end
}
