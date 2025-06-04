return {
    'nvim-neorg/neorg',
    lazy = false,
    ft = "norg",
    version = "*",
    config = function ()
        require('neorg').setup{
            load = {
                ["core.defaults"] = {},
                ["core.concealer"] = {},
                ["core.export"] = {},
                ["core.export.markdown"] = {},
                ["core.dirman"] = {
                      config = {
                        workspaces = {
                          notes = "~/notes",
                        },
                        default_workspace = "notes",
                      },
                },
            }
        }
        vim.wo.foldlevel = 99
        vim.wo.conceallevel = 2
    end
}
