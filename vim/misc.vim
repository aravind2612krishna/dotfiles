" Async Make stuff {{{

fun! NonIntrusiveGetMakeDir()
    " let fileDir = resolve(fileDir . "/..")
    let filemk = "makefile"
    let pathmk = expand("%:p:h")
    let depth = 1
    while depth < 10
        "return if we could find a makefile in current directory
        let makepath = resolve(pathmk . "/" . filemk)
        if filereadable(makepath)
            return pathmk
        endif
        let depth += 1
        let pathmk = resolve(pathmk . "/..")
    endwhile
    return expand("%:p:h")
endf

function! MyCompile()
    let makedir=NonIntrusiveGetMakeDir()
    let &makeprg = 'make -j4 -k -s -C' . makedir
    echom &makeprg
    set errorformat=\ %#%f(%l)\ :\ %#%t%[A-z]%#\ %[A-Z\ ]%#%n:\ %m
    AsyncRun -program=make
    :normal p
endfunction

nmap <F7> :call MyCompile()<CR>
"}}}

" Input macros {{{
function! Input()
    call inputsave()
    let text = input('iterName ? ')
    call inputrestore()
    let @t = text
endfunction
" }}}

" {{{ 12. macros
" DEBUG_MIDMESH
" let @d = 'DO#if DEBUG_MIDMESHo#endifP'
let @d = 'C#if DEBUG_SWEEPo#endifP'
" Inserts a # comment box
let @x = 'I// A //yyPVr/jpVr/'
let @y = 'I## A ##yyPVr#jpVr#'
" Go to one of the places where current function is called
let @k = '[[?(b*``' 
let @c = ':sp:set autoread:e command1.tclG?readfile$F.yT/:q:set noautoreadO// case : p'
let @e = ':!p4 edit %'
" }}}

" visual selection search {{{
function! VisualSelection(direction, extra_filter) range
    let l:saved_reg = @"
    execute "normal! vgvy"

    let l:pattern = escape(@", '\\/.*$^~[]')
    let l:pattern = substitute(l:pattern, "\n$", "", "")

    if a:direction == 'gv'
        call CmdLine("Ag \"" . l:pattern . "\" " )
    elseif a:direction == 'replace'
        call CmdLine("%s" . '/'. l:pattern . '/')
    endif

    let @/ = l:pattern
    let @" = l:saved_reg
endfunction 
vnoremap <silent> * :<C-u>call VisualSelection('', '')<CR>/<C-R>=@/<CR><CR>
vnoremap <silent> # :<C-u>call VisualSelection('', '')<CR>?<C-R>=@/<CR><CR> 
" }}}

" Search in function C++ {{{
" Search within a scope (a {...} program block).
" Version 2010-02-28 from http://vim.wikia.com/wiki/VimTip1530
" Return a pattern to search within a specified scope, or
" return a backslash to cancel search if scope not found.
" navigator: a command to jump to the beginning of the desired scope
" mode: 0=scope only; 1=scope+current word; 2=scope+visual selection
function! s:ScopeSearch(navigator, mode)
  if a:mode == 0
    let pattern = ''
  elseif a:mode == 1
    let pattern = '\<' . expand('<cword>') . '\>'
  else
    let old_reg = getreg('@')
    let old_regtype = getregtype('@')
    normal! gvy
    let pattern = escape(@@, '/\.*$^~[')
    call setreg('@', old_reg, old_regtype)
  endif
  let saveview = winsaveview()
  execute 'normal! ' . a:navigator
  let first = line('.')
  normal %
  let last = line('.')
  normal %
  call winrestview(saveview)
  if first < last
    return printf('\%%>%dl\%%<%dl%s', first-1, last+1, pattern)
  endif
  return "\b"
endfunction
" Search within top-level block for word at cursor, or selected text.
nnoremap <Leader>[ /<C-R>=<SID>ScopeSearch('[[', 1)<CR><CR>
vnoremap <Leader>[ <Esc>/<C-R>=<SID>ScopeSearch('[[', 2)<CR><CR>gV
" Search within current block for word at cursor, or selected text.
nnoremap <Leader>{ /<C-R>=<SID>ScopeSearch('[{', 1)<CR><CR>
vnoremap <Leader>{ <Esc>/<C-R>=<SID>ScopeSearch('[{', 2)<CR><CR>gV
" Search within current top-level block for user-entered text.
nnoremap <Leader>/ /<C-R>=<SID>ScopeSearch('[[', 0)<CR>
vnoremap <Leader>/ <Esc>/<C-R>=<SID>ScopeSearch('[[', 2)<CR><CR>
" }}}

" session
nnoremap <C-s> :exe 'mks! ~\' . $P4CLIENT . '.vim'<CR>

set fillchars+=vert:│

" Foldtext
" highlight! link Folded FoldColumn
set foldmethod=marker
if !has_key(g:plugs, 'nvim-treesitter')
    " autocmd FileType cpp setlocal foldmethod=marker foldmarker=#if,#endif
    autocmd FileType cpp,python setlocal foldmethod=indent
    " set fillchars+=fold:╍
    " set fillchars+=fold:─
    " set fillchars+=fold:\ 
else
    autocmd FileType cpp if line('$') < 5000 && line ('$') > 10 | setlocal foldmethod=expr foldexpr=nvim_treesitter#foldexpr() | endif
endif
set fillchars+=fold:┈
" set fillchars+=fold:⸱
" set fillchars+=fold:.
" set fillchars+=fold:─
" set fillchars+=fold:━
function! NeatFold()
    " set the max number of nested fold levels + 1
    let fnum = 3
    " set the max number of digits in the number folded lines
    let nnum = 5

    let fillchar = matchstr(&fillchars, 'fold:\zs.')
    let foldstartline = v:foldstart
    let foldendline = v:foldend
    let indent_level = indent(foldstartline)
    let lnum = foldendline - foldstartline + 1
    " let plus = repeat('┫', fnum - v:foldlevel)
    " let minus = repeat('┣', fnum - v:foldlevel)
    " let plus = repeat('❱', fnum - v:foldlevel)
    " let minus = repeat('❰', fnum - v:foldlevel)
    " let plus = '┤' . v:foldlevel . '├'
    " let plus = '┤' . v:foldlevel . '├'
    let plus = '┤' . lnum . '├'
    let dash = repeat(fillchar, indent_level - strlen(lnum) - 4)
    " echom 'strlen(lnum) = ' . strlen(lnum)
    let spac = repeat(' ', nnum - len(lnum))

    " let txta = foldstartline . ' ⇋ ' . foldendline
    " let txta = '' . trim(getline(foldstartline), &commentstring.&foldmarker) . ''
    " let txta = '' . getline(foldstartline) . ''
    let txta = '┤' . trim(getline(foldstartline), " ") . '├'
    let txtb = ''
    " let txtb = '┤' . spac . lnum . ' ├'
    " let txta = '┫' . trim(getline(foldstartline), " ") . '┣'
    " let txtb = '┫' . spac . lnum . ' ┣'
    let fill = repeat(fillchar, winwidth(0) - fnum - len(txta . txtb) - &foldcolumn - (&number ? &numberwidth : 0))

    " echom indent_level - strlen(plus) - 1 
    return plus . dash . txta . fill . txtb
endfunction
set foldtext=NeatFold()

augroup PreviewAutocmds
  autocmd!
  autocmd WinEnter * if &previewwindow | setlocal wrap | endif
augroup END
autocmd QuickFixCmdPost * top copen 8 | wincmd p

if has('win32')
    set directory=D:\vimfiles\swaps
    set backupdir=D:\vimfiles\backups
endif

" open the current Vim file in Visual Studio.
cabbrev vsedit :!start /min devenv /edit "%"

" Copy selection as html
" let g:html_dynamic_folds=1
" let g:html_prevent_copy = "n"
function! Fmtcp(line1, line2)
    let oldclipopt = &clipboard
    set clipboard=
    execute a:line1 . "," . a:line2 . "TOhtml"
    execute "g:<body"
    execute "normal oFile : "
    execute "normal \"#p"
    execute "normal a<br>"
    execute "silent %write !xclip -i -t 'text/html' -selection clipboard"
    bwipeout!
    let &clipboard=oldclipopt
endfunction

command! -range=% HtmlClip silent call Fmtcp(<line1>,<line2>)

function! ProfileStart()
    exec('profile start profile.log')
    exec('profile func *')
    exec('profile file *')
endfunction

function! ProfileEnd()
    exec('profile pause')
    exec('qall')
endfunction

function! NeovideToggleFullScreen()
    if exists('g:neovide')
        if exists('g:neovide_fullscreen') && g:neovide_fullscreen
            let g:neovide_fullscreen = v:false
        else
            let g:neovide_fullscreen = v:true
        endif
    endif
endfunction
nnoremap <M-Enter> <cmd>call NeovideToggleFullScreen()<CR>
