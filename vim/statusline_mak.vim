" Multibyte fillchars not supported
" set fillchars+=stl:┈
" set fillchars+=stlnc:┈
let g:mode_str = {
       \ 'n'  : 'NORMAL',
       \ 'v'  : 'VISUAL',
       \ 'V'  : 'V·Line',
       \ '' : 'V·Block',
       \ 'i'  : 'INSERT',
       \ 'R'  : 'R',
       \ 'Rv' : 'V·Replace',
       \ 'c'  : 'Command',
       \ 't'  : 'Terminal',
       \}

function Status_line_generator()
    let l:is_mod = &modified ? '+' : ''
    let l:is_ro = &readonly ? '' : ''
    let l:curr_mode = mode()
    if has_key(g:mode_str, l:curr_mode)
        let l:curr_mode = toupper(g:mode_str[l:curr_mode])
    endif
    let l:fname = expand('%:t')
    let l:curr_line = line('.')
    let l:last_line = line('$')
    let l:left='─' . l:curr_mode . '─' . l:fname . '─'
    let l:right='─' . l:curr_line . ':' . l:last_line . ' ' . col('.') . '─'

    let l:fill_width = winwidth(0) - strchars(l:left) - strchars(l:right)
    " echom len(l:left) . '..' . l:fill_width . '..' . len(l:right)
    let l:filler = repeat('─', l:fill_width)

    return l:left . l:filler . l:right
endfunction

set statusline=%{Status_line_generator()}
" set statusline =ha
" set statusline+=┈
" set statusline+=Insert┈
" set statusline+=%f┈
" set statusline+=%=
" set statusline+=┈
" set statusline+=%l\ %p%%┈
