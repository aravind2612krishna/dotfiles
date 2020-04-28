" file finding
" LeaderF/FZF {{{

" FZF {{{
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'pbogut/fzf-mru.vim'
" }}}

" floating fzf window with borders {{{
function! CreateCenteredFloatingWindow()
    let width = min([&columns - 4, max([80, &columns - 20])])
    let height = min([&lines - 4, max([20, &lines - 10])])
    let top = ((&lines - height) / 2) - 1
    let left = (&columns - width) / 2
    let opts = {'relative': 'editor', 'row': top, 'col': left, 'width': width, 'height': height, 'style': 'minimal'}

    let top = "╭" . repeat("─", width - 2) . "╮"
    let mid = "│" . repeat(" ", width - 2) . "│"
    let bot = "╰" . repeat("─", width - 2) . "╯"
    let lines = [top] + repeat([mid], height - 2) + [bot]
    let s:buf = nvim_create_buf(v:false, v:true)
    call nvim_buf_set_lines(s:buf, 0, -1, v:true, lines)
    call nvim_open_win(s:buf, v:true, opts)
    set winhl=Normal:Floating
    let opts.row += 1
    let opts.height -= 2
    let opts.col += 2
    let opts.width -= 4
    call nvim_open_win(nvim_create_buf(v:false, v:true), v:true, opts)
    au BufWipeout <buffer> exe 'bw '.s:buf
endfunction

" Files + devicons + floating fzf
function! Fzf_dev()
    let l:fzf_files_options = '--preview "bat --line-range :'.&lines.' --theme="OneHalfDark" --style=numbers,changes --color always {2..-1}"'
    function! s:files()
        let l:files = split(system($FZF_DEFAULT_COMMAND), '\n')
        return s:prepend_icon(l:files)
    endfunction

    function! s:prepend_icon(candidates)
        let l:result = []
        for l:candidate in a:candidates
            let l:filename = fnamemodify(l:candidate, ':p:t')
            let l:icon = WebDevIconsGetFileTypeSymbol(l:filename, isdirectory(l:filename))
            call add(l:result, printf('%s %s', l:icon, l:candidate))
        endfor

        return l:result
    endfunction

    function! s:edit_file(item)
        let l:pos = stridx(a:item, ' ')
        let l:file_path = a:item[pos+1:-1]
        execute 'silent e' l:file_path
    endfunction

    call fzf#run({
                \ 'source': <sid>files(),
                \ 'sink':   function('s:edit_file'),
                \ 'options': '-m --reverse ' . l:fzf_files_options,
                \ 'down':    '40%',
                \ 'window': 'call CreateCenteredFloatingWindow()'})

endfunction
" }}}

let useLeaderF = v:false
let useClap = v:false

if has('nvim') && has('win32')
    let useLeaderF = v:true
    let useClap = v:false
endif

if useLeaderF
    Plug 'Yggdroot/LeaderF'
    let g:Lf_WindowPosition = 'popup'
    nnoremap <leader>m :LeaderfMru<CR>
    nnoremap <leader>f :LeaderfFile<CR>
    nnoremap <leader>b :LeaderfBuffer<CR>
elseif useClap
    Plug 'liuchengxu/vim-clap', { 'do': ':Clap install-binary' }
    nnoremap <leader>m :Clap history<CR>
    nnoremap <leader>f :Clap files<CR>
    nnoremap <leader>b :Clap buffers<CR>
else
    nnoremap <leader>m :FZFMru<CR>
    nnoremap <leader>f :FZF<CR>
    nnoremap <leader>b :Buffers<CR>
    " general
    " let g:fzf_layout = { 'window': 'call CreateCenteredFloatingWindow()' }
    " let $FZF_DEFAULT_OPTS="--reverse " " top to bottom
endif
" }}}

" in-file searching
Plug 'skywind3000/asyncrun.vim'
let g:asyncrun_open = 8

if executable('rg')
    map <leader>r :AsyncRun rg -in <C-R><C-W> <C-R>=expand("%:.:h") <CR>
else
    if executable('grep')
        map <leader>r :AsyncRun grep -Rn <C-R><C-W> <C-R>=expand("%:p:h") . "/*" <CR>
    endif
endif
