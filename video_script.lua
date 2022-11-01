local colors = {
    'base16-3024',
    'base16-apathy',
    'base16-apprentice',
    'base16-ashes',
    'base16-atelier-cave',
    'base16-atelier-dune',
    'base16-atelier-estuary',
    'base16-atelier-forest',
    'base16-atelier-heath',
    'base16-atelier-lakeside',
    'base16-atelier-plateau',
    'base16-atelier-savanna',
    'base16-atelier-seaside',
    'base16-atelier-sulphurpool',
    'base16-danqing',
    'base16-darcula',
    'base16-darkmoss',
    'base16-darkviolet',
    'base16-default-dark',
    'base16-dracula',
    'base16-eighties',
    'base16-espresso',
    'base16-gruvbox-dark-hard',
    'base16-gruvbox-dark-medium',
    'base16-gruvbox-dark-pale',
    'base16-gruvbox-dark-soft',
    'base16-materia',
    'base16-material',
    'base16-mocha',
    'base16-monokai',
    'base16-rose-pine-moon',
    'base16-sandcastle',
    'base16-solarized-dark',
    'base16-spaceduck',
    'base16-spacemacs',
    'base16-tokyo-night-dark',
    'base16-tokyodark',
    'base16-tomorrow-night-eighties',
}
local i = 1
local timer = vim.loop.new_timer()
timer:start(0, 300, vim.schedule_wrap(function()
    vim.cmd('colorscheme ' .. colors[i])
    i = i + 1
    if i > #colors then
        timer:close()
    end
end))
local augroup = 'lua_sandbox'
vim.api.nvim_create_augroup(augroup, { clear = true })
vim.api.nvim_create_autocmd({ 'VimLeave' }, {
    group = augroup,
    callback = function()
        timer:close()
    end,
})
