return {
    'github/copilot.vim',
    enabled = vim.loop.os_uname().sysname == 'Darwin', -- Only enable on macOS
}
