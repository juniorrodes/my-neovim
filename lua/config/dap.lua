return {
    'mfussenegger/nvim-dap',
    dependencies = {
        'rcarriga/nvim-dap-ui',
        --'theHamsta/nvim-dap-virtual-text',
        'williamboman/mason.nvim',
    },
    config = function ()
        local dap = require('dap')

        vim.keymap.set('n', '<F5>', function() dap.continue() end)
        vim.keymap.set('n', '<F10>', function() dap.step_over() end)
        vim.keymap.set('n', '<F11>', function() dap.step_into() end)
        vim.keymap.set('n', '<F12>', function() dap.step_out() end)
        vim.keymap.set('n', '<leader>b', function() dap.toggle_breakpoint() end)
        vim.keymap.set('n', '<leader>B', function() dap.set_breakpoint() end)
        vim.keymap.set({'n', 'v'}, '<Leader>dh', function()
            require('dap.ui.widgets').hover()
        end)
        vim.keymap.set({'n', 'v'}, '<Leader>de', function()
            local widgets = require('dap.ui.widgets')
            local sidebar = widgets.sidebar(widgets.expression)
            sidebar.open()
        end)
        vim.keymap.set({'n', 'v'}, '<Leader>ds', function()
            local widgets = require('dap.ui.widgets')
            local sidebar = widgets.sidebar(widgets.scopes)
            sidebar.open()
        end)
        vim.keymap.set('n', '<Leader>du', function ()
            require('dapui').open({})
        end)

        dap.adapters.codelldb = {
            type = 'executable',
            command = '/home/juniorrodes/.local/share/nvim/mason/packages/codelldb/codelldb'
        }

        dap.configurations.zig = {
            {
                name = "Launch file",
                type = "codelldb",
                request = "launch",
                program = function()
                  return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
                end,
                cwd = '${workspaceFolder}',
                stopOnEntry = false,
            },
        }
    end
}
