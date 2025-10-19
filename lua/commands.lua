-- fcitx configuration
local fcitx_cmd = ''

if vim.fn.executable('fcitx-remote') == 1 then
    fcitx_cmd = 'fcitx-remote'
elseif vim.fn.executable('fcitx5-remote') == 1 then
    fcitx_cmd = 'fcitx5-remote'
end

function _Fcitx2en()
    local input_status = tonumber(vim.fn.system(fcitx_cmd))
    print('Input status is: ', input_status)
    if input_status == 2 then
        print('Setting input toggle to true')
        vim.b.input_toggle_flag = true
        vim.fn.system(fcitx_cmd .. ' -c')
    end
end

function _Fcitx2NonLatin()
    if vim.b.input_toggle_flag == nil then
        print('Setting input flag to false')
        vim.b.input_toggle_flag = false
    elseif vim.b.input_toggle_flag == true then
        vim.fn.system(fcitx_cmd .. ' -o')
        print('entrei aqui')
        vim.b.input_toggle_flag = false
    end
end

vim.cmd[[
    augroup fcitx
        au InsertEnter * :lua _Fcitx2NonLatin()
        au InsertLeave * :lua _Fcitx2en()
        au CmdLineEnter [/\?] :lua _Fcitx2NonLatin()
        au CmdLineLeave [/\?] :lua _Fcitx2en()
    augroup END
]]
--



vim.api.nvim_create_autocmd("VimLeavePre", {
    pattern = "*",
    callback = function ()
        if vim.g.savesession then
            vim.api.nvim_command("mks! .vim/Session.vim")
        end
    end
})
