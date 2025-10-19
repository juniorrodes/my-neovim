return {
    'neovim/nvim-lspconfig',
    config = function ()
        --local lspconfig = require('lspconfig')

        local capabilities = require('cmp_nvim_lsp').default_capabilities()

        vim.api.nvim_create_autocmd("BufWritePre", {
          pattern = "*.go",
          callback = function()
            local params = vim.lsp.util.make_range_params()
            params.context = {only = {"source.organizeImports"}}
            -- buf_request_sync defaults to a 1000ms timeout. Depending on your
            -- machine and codebase, you may want longer. Add an additional
            -- argument after params if you find that you have to write the file
            -- twice for changes to be saved.
            -- E.g., vim.lsp.buf_request_sync(0, "textDocument/codeAction", params, 3000)
            local result = vim.lsp.buf_request_sync(0, "textDocument/codeAction", params)
            for cid, res in pairs(result or {}) do
              for _, r in pairs(res.result or {}) do
                if r.edit then
                  local enc = (vim.lsp.get_client_by_id(cid) or {}).offset_encoding or "utf-16"
                  vim.lsp.util.apply_workspace_edit(r.edit, enc)
                end
              end
            end
            vim.lsp.buf.format({async = false})
          end
        })

        local on_attach = function(_, bufnr)
            vim.api.nvim_set_option_value('omnifunc', 'v:lua.vim.lsp.omnifunc', { buf = bufnr })
            --local opts = { buffer = bufnr, remap = false }
            --vim.keymap.set('n', '<leader>lf', custom_format, opts)
            --require('nvim-cmp').on_attach()
        end

        vim.filetype.add({ extension = { templ = 'templ' } })

        vim.lsp.config('gopls', {
            capabilities = capabilities,
            settings = {
                gopls = {
                    completeUnimported = true,
                },
            },
        })

        vim.lsp.config('templ', {
            on_attach = on_attach,
            capabilities = capabilities,
            filetypes = {
                'templ'
            },
            cmd = { 'templ', 'lsp', '-log', '/home/juniorrodes/templLsp.log' }
        })

        vim.lsp.config('lua_ls', {
            on_init = function(client)
                if client.workspace_folders then
                  local path = client.workspace_folders[1].name
                  if vim.uv.fs_stat(path..'/.luarc.json') or vim.uv.fs_stat(path..'/.luarc.jsonc') then
                    return
                  end
                end

                client.config.settings.Lua = vim.tbl_deep_extend('force', client.config.settings.Lua, {
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
                      -- Depending on the usage, you might want to add additional paths here.
                      -- "${3rd}/luv/library"
                      -- "${3rd}/busted/library",
                    }
                    -- or pull in all of 'runtimepath'. NOTE: this is a lot slower and will cause issues when working on your own configuration (see https://github.com/neovim/nvim-lspconfig/issues/3189)
                    -- library = vim.api.nvim_get_runtime_file("", true)
                  }
                })
            end,
            settings = {
                Lua = {}
            }
        })

        --vim.lsp.config.clangd.setup{
        --    filetypes = { "c", "cpp", "objc", "objcpp", "cuda" }, -- exclude proto
        --}

        vim.lsp.config('zls', {
          on_attach = function (_, bufnr)
            vim.api.nvim_set_option_value('omnifunc', 'v:lua.vim.lsp.omnifunc', { buf = bufnr })
            --require('completion').on_attach()
          end,
          capabilities = capabilities,
        })

        --vim.lsp.config.buf_ls.setup{}

        --vim.lsp.config.pylsp.setup {
        --    settings = {
        --        pylsp = {
        --            plugins = {
        --                pycodestyle = {
        --                    ignore = {'W391'},
        --                    maxLineLength = 100,
        --                },
        --            },
        --        },
        --    },
        --}

        local html_capabilities = vim.lsp.protocol.make_client_capabilities()
        html_capabilities.textDocument.completion.completionItem.snippetSupport = true

        --vim.lsp.config.html.setup {
        --    capabilities = html_capabilities,
        --}

        -- enabling servers
        vim.lsp.enable('tailwindcss')
        vim.lsp.enable('ts_ls')
        vim.lsp.enable('ocamllsp')
        vim.lsp.enable('glsl_analyzer')
        vim.lsp.enable('lua_ls')
        vim.lsp.enable('gopls')
        vim.lsp.enable('templ')
        vim.lsp.enable('zls')
        vim.lsp.enable('templ')
    end
}

