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
    setlocal errorformat=\ %#%f(%l)\ :\ %#%t%[A-z]%#\ %[A-Z\ ]%#%n:\ %m
    AsyncRun -program=make
    :normal p
endfunction

nmap <F7> :call MyCompile()<CR>
nmap <C-n> :cn<CR>
nmap <C-p> :cp<CR>
nmap <C-q> :cclose<CR>
nnoremap <C-e> :topleft copen<CR>
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
let @d = 'C#if DEBUG_MIDMESHo#endifP'
" Inserts a part variable 
let @p = '[[ohwDGFIPart *pPart = p_pMidMesher->GetPart();'
" Go to one of the places where current function is called
let @k = '[[?(b*``' 
" size_t loop
let @s = '"zdiwafor (size_t iterName = 0; iterName < z.size(); ++iterName){}kkf=b:call Input()*Nciwtn.n.jo= z[t];^iauto '
" iterator loop
let @i = '"zdiwafor (auto iterName = z.begin(); iterName != z.end(); ++iterName){}kkf=b:call Input()*Nciwtn.n.jo= *t;^iauto '
" camelCase to underscores
" let @c = 'viwomt"tywviw:s:\%V\(\u\):_\1:g`tguiw'
let @c = ':sp:set autoread:e command.tclG?readfile$F.yT/:q:set noautoreadO// case : p'
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

autocmd FileType cpp setlocal foldmarker=#if,#endif

augroup PreviewAutocmds
  autocmd!
  autocmd WinEnter * if &previewwindow | setlocal wrap | endif
augroup END

if has('win32')
    set directory=D:\vimfiles\swaps
    set backupdir=D:\vimfiles\backups
endif

" open the current Vim file in Visual Studio.
cabbrev vsedit :!start devenv /edit "%"

" Copy selection as html
function! CopyFormatted(line1, line2)
    execute a:line1 . "," . a:line2 . "TOhtml"
    %yank *
    !start /min powershell -noprofile "gcb | scb -as"
    bwipeout!
endfunction

command! -range=% HtmlClip silent call CopyFormatted(<line1>,<line2>)
