Plug 'neoclide/coc.nvim', {'branch': 'release'}
" Plug 'neoclide/coc.nvim', {'branch': 'master', 'do': 'yarn install --frozen-lockfile'}
" Plug 'neoclide/coc-snippets'
Plug 'honza/vim-snippets'
" Plug 'neoclide/coc-python'
" Plug 'clangd/coc-clangd'

Plug 'm-pilia/vim-ccls'
let g:ccls_levels = 1

" For Tagbar related features - not essential
let g:vista_executive_for = {
  \ 'cpp': 'coc',
  \ 'python': 'coc',
  \ }

" For highlighting references
Plug 'neoclide/coc-highlight'
" set updatetime=500
" Highlight symbol under cursor on CursorHold
autocmd! CursorHold * silent call CocActionAsync('highlight')

" if hidden not set, TextEdit might fail.
set hidden

" Better display for messages
set cmdheight=2

" Use <cr> for confirm completion.
" Coc only does snippet and additional edit on confirm.
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

" Use `[c` and `]c` for navigate diagnostics
nmap <silent> [d <Plug>(coc-diagnostic-prev)
nmap <silent> ]d <Plug>(coc-diagnostic-next)

" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K for show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if &filetype == 'vim'
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Show signature help while editing
" autocmd! CursorHoldI * silent! call CocAction('showSignatureHelp')

" Remap for rename current word
nmap <leader>rn <Plug>(coc-rename)

" Remap for format selected region
vmap <leader>gq <Plug>(coc-format-selected)
nmap <leader>gq <Plug>(coc-format-selected)

" Remap for do codeAction of selected region, ex: `<leader>aap` for current paragraph
vmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Fix autofix problem of current line
nmap <leader>qf  <Plug>(coc-fix-current)

" Remap for do codeAction of current line
nmap <leader>ac  <Plug>(coc-codeaction)

" Root detection
let g:rooter_patterns = ['compile_commands.json', '.git']

" resume coclist
nnoremap <silent> <leader>p  :<C-u>CocListResume<CR>

nn <silent><buffer> <leader>u :call CocLocations('ccls','$ccls/navigate',{'direction':'U'})<CR>

nnoremap <M-n> :CocCommand document.jumpToNextSymbol<CR>

" bases
nn <silent> xb :call CocLocations('ccls','$ccls/inheritance')<cr>
" bases of up to 3 levels
nn <silent> xB :call CocLocations('ccls','$ccls/inheritance',{'levels':3})<cr>
" derived
nn <silent> xd :call CocLocations('ccls','$ccls/inheritance',{'derived':v:true})<cr>
" derived of up to 3 levels
nn <silent> xD :call CocLocations('ccls','$ccls/inheritance',{'derived':v:true,'levels':3})<cr>

" caller
nn <silent> xc :call CocLocations('ccls','$ccls/call')<cr>
" callee
nn <silent> xC :call CocLocations('ccls','$ccls/call',{'callee':v:true})<cr>

" $ccls/member
" member variables / variables in a namespace
nn <silent> gxm :call CocLocations('ccls','$ccls/member')<cr>
" member functions / functions in a namespace
nn <silent> gxf :call CocLocations('ccls','$ccls/member',{'kind':3})<cr>
" nested classes / types in a namespace
nn <silent> gxs :call CocLocations('ccls','$ccls/member',{'kind':2})<cr>

nmap <silent> gxt <Plug>(coc-type-definition)<cr>
nn <silent> gxv :call CocLocations('ccls','$ccls/vars')<cr>
nn <silent> gxV :call CocLocations('ccls','$ccls/vars',{'kind':1})<cr>

nn <silent> gj :call CocLocations('ccls','$ccls/navigate',{'direction':'D'})<cr>
nn <silent> gh :call CocLocations('ccls','$ccls/navigate',{'direction':'L'})<cr>
nn <silent> gl :call CocLocations('ccls','$ccls/navigate',{'direction':'R'})<cr>
nn <silent> gk :call CocLocations('ccls','$ccls/navigate',{'direction':'U'})<cr>

nn xx x
