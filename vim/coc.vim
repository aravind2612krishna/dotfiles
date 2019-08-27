Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'neoclide/coc-snippets'

" For Tagbar related features - not essential
Plug 'liuchengxu/vista.vim'

" For highlighting references
Plug 'neoclide/coc-highlight'
highlight! link CocHighlightText PmenuSel
" highlight! link CocHighlightText CocListBlackWhite
" highlight! link CocHighlightText LightlineMiddle_terminal
set updatetime=500

" For semantic coloring {{{
Plug 'jackguo380/vim-lsp-cxx-highlight', {'for' : 'cpp'}
if !has('nvim')
    let g:lsp_cxx_hl_use_text_props = 1 " Without this scrolling slow
endif
" }}}

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
autocmd! CursorHoldI * silent! call CocAction('showSignatureHelp')

" Highlight symbol under cursor on CursorHold
autocmd! CursorHold * silent call CocActionAsync('highlight')

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
