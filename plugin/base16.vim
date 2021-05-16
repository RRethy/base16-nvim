function! base16#colorscheme(colorscheme)
  call v:lua.require('base16-colorscheme').setup(a:colorscheme)
endfunction

function! base16#available_colorschemes() abort
  let colorschemes = luaeval('require("base16-colorscheme").available_colorschemes()')
  return sort(colorschemes)
endfunction

command! -nargs=1 -complete=custom,s:complete_scheme Base16 :call base16#colorscheme('<args>')

function! s:complete_scheme(arg, line, pos) abort
  return join(base16#available_colorschemes(), "\n")
endfunction
