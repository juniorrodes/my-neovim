local ufo = require('ufo')
ufo.setup {
    close_fold_kinds_for_ft = {
        default = {'imports',},
    }
}

vim.keymap.set('n', 'zR', ufo.openAllFolds)
vim.o.foldlevel = 99
vim.o.foldlevelstart = 99
vim.o.foldcolumn = '1'
vim.opt.fillchars = {eob = ' ', fold = ' ', foldopen = '▾', foldsep = ' ', foldclose = '▸'}
--vim.o.fillchars = [[eob: ,fold: ,foldopen:▾, foldsep: , foldclose:▸]]
