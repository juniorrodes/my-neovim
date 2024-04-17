local hover = require('hover')

hover.setup {
  init = function ()
    require('hover.providers.lsp')
  end,
  preview_opts = {
    border = 'single'
  },
  preview_window = false,
  title = true,
  mouse_providers = {
    'LSP'
  },
}

-- Setup keymaps
vim.keymap.set("n", "K", require("hover").hover, {desc = "hover.nvim"})
vim.keymap.set("n", "gK", require("hover").hover_select, {desc = "hover.nvim (select)"})
