vim.api.nvim_create_autocmd("VimLeavePre", {
    pattern = "*",
    callback = function ()
        if vim.g.savesession then
            vim.api.nvim_command("mks! .vim/Session.vim")
        end
    end
})
