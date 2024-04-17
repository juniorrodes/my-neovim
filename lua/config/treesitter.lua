local treesitter = require('nvim-treesitter.configs')

treesitter.setup {
    ensure_installed = { 'lua', 'go', 'templ', 'c', 'rust', 'zig', 'glsl', 'svelte', 'typescript', 'javascript' },
    highlight = {
        enable = true,
    },
    auto_install = true,
    disable = function(_, buf)
        local max_filesize = 100 * 1024
        local ok, stats = pcall(vim.loop.fs_start, vim.api.nvim_buf_get_name(buf))
        if ok and stats and stats.size > max_filesize then
          return true
        end
    end
}
