local lspconfig = require('lspconfig')

local capabilities = require('cmp_nvim_lsp').default_capabilities()

local on_attach = function(client, bufnr)
    vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
    --local opts = { buffer = bufnr, remap = false }
    --vim.keymap.set('n', '<leader>lf', custom_format, opts)
    require('nvim-cmp').on_attach()
end

vim.filetype.add({ extension = { templ = 'templ' } })

lspconfig.gopls.setup {
    capabilities = capabilities,
    settings = {
        gopls = {
            completeUnimported = true,
        },
    },
}

lspconfig.templ.setup {
    on_attach = on_attach,
    capabilities = capabilities,
    filetypes = {
        'templ'
    },
    cmd = { 'templ', 'lsp', '-log', '/home/juniorrodes/templLsp.log' }
}


lspconfig.lua_ls.setup {
  on_init = function(client)
    local path = client.workspace_folders[1].name
    if not vim.loop.fs_stat(path..'/.luarc.json') and not vim.loop.fs_stat(path..'/.luarc.jsonc') then
      client.config.settings = vim.tbl_deep_extend('force', client.config.settings, {
        Lua = {
          runtime = {
            -- Tell the language server which version of Lua you're using
            -- (most likely LuaJIT in the case of Neovim)
            version = 'LuaJIT'
          },
          -- Make the server aware of Neovim runtime files
          workspace = {
            checkThirdParty = false,
            library = {
              vim.env.VIMRUNTIME
            }
            -- or pull in all of 'runtimepath'. NOTE: this is a lot slower
            -- library = vim.api.nvim_get_runtime_file("", true)
          }
        }
      })

      client.notify("workspace/didChangeConfiguration", { settings = client.config.settings })
    end
    return true
  end,
  settings = {
      Lua = {
          diagnostics = {
              globals = { "vim" },
          },
      },
  },
}

--lspconfig.ccls.setup {}

lspconfig.zls.setup {
  on_attach = function (_, bufnr)
    vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
  end,
  capabilities = capabilities,
}

--lspconfig.glsl_analyzer.setup {}
--
--lspconfig.sqlls.setup {}
