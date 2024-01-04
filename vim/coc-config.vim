if has_key(g:plugs, 'vim-ccls')
    let g:ccls_levels = 1
endif

" For Tagbar related features - not essential
if has_key(g:plugs, 'vista.vim')
    let g:vista_executive_for = {
                \ 'cpp': 'coc',
                \ 'python': 'coc',
                \ }
endif

if has_key(g:plugs, 'coc-highlight')
    " Highlight symbol under cursor on CursorHold
    " highlight! link CocHighlightText PmenuSel
    autocmd! CursorHold * silent call CocActionAsync('highlight')
endif

" TextEdit might fail if hidden is not set.
set hidden

" Some servers have issues with backup files, see #649.
set nobackup
set nowritebackup

" Give more space for displaying messages.
set cmdheight=2

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
" set updatetime=300

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c


" Use <tab> and <S-tab> to navigate completion list: >

function! s:check_back_space() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~ '\s'
endfunction

" Insert <tab> when previous text is space, refresh completion if not.
inoremap <silent><expr> <TAB>
            \ coc#pum#visible() ? coc#pum#next(1):
            \ <SID>check_back_space() ? "\<Tab>" :
            \ coc#refresh()
inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"

" Use <CR> to confirm completion, use: >

inoremap <expr> <cr> coc#pum#visible() ? coc#_select_confirm() : "\<CR>"

let g:coc_snippet_next = '\'
let g:coc_snippet_prev = '|'

" inoremap <silent><expr> <TAB>
"             \ pumvisible() ? "\<C-n>" :
"             \ "\<TAB>"

" inoremap <expr><S-TAB> 
"             \ pumvisible() ? "\<C-p>" : 
"             \ "\<S-TAB>"

" function! s:check_back_space() abort
"   let col = col('.') - 1
"   return !col || getline('.')[col - 1]  =~# '\s'
" endfunction

" " Use <c-space> to trigger completion.
" if has('nvim')
"   inoremap <silent><expr> <c-space> coc#refresh()
" else
"   inoremap <silent><expr> <c-@> coc#refresh()
" endif

" " Make <CR> auto-select the first completion item and notify coc.nvim to
" " format on enter, <cr> could be remapped by other vim plugin
" " inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
" "                               \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"
" " inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

" inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm() : 
"             \"\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> [g <Plug>(coc-diagnostic-prev-error)
nmap <silent> ]g <Plug>(coc-diagnostic-next-error)
nmap <silent> [w <Plug>(coc-diagnostic-prev)
nmap <silent> ]w <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> K :call CocAction('doHover')<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)
nmap <leader>rr <Plug>(coc-refactor)
nnoremap <leader>rf <Plug>(coc-codeaction-refactor)

" Formatting selected code.
xmap <leader>gq  <Plug>(coc-format-selected)
nmap <leader>gq  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType cpp,python,typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder.
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Applying codeAction to the selected region.
" Example: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap keys for applying codeAction to the current buffer.
nmap <leader>ac  <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
nmap <leader>qf  <Plug>(coc-fix-current)

" Map function and class text objects
" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocAction('format')

" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Add (Neo)Vim's native statusline support.
" NOTE: Please see `:h coc-status` for integrations with external plugins that
" provide custom statusline: lightline.vim, vim-airline.
" set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Root detection
let g:rooter_patterns = ['compile_commands.json', '.git']

nnoremap <M-n> :CocCommand document.jumpToNextSymbol<CR>

nnoremap <silent><nowait> <leader>gd  :<C-u>CocList diagnostics<cr>
" Search workspace symbols.
nnoremap <silent><nowait> gs  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent><nowait> <leader>gj  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent><nowait> <leader>gk  :<C-u>CocPrev<CR>
" Resume latest coc list.
nnoremap <silent><nowait> <leader>gp  :<C-u>CocListResume<CR>

" bases
nn <silent> <leader>xb :call CocLocations('ccls','$ccls/inheritance')<cr>
" bases of up to 3 levels
nn <silent> <leader>xB :call CocLocations('ccls','$ccls/inheritance',{'levels':3})<cr>
" derived
nn <silent> <leader>xd :call CocLocations('ccls','$ccls/inheritance',{'derived':v:true})<cr>
" derived of up to 3 levels
nn <silent> <leader>xD :call CocLocations('ccls','$ccls/inheritance',{'derived':v:true,'levels':3})<cr>

" caller
nn <silent> <leader>xc :call CocLocations('ccls','$ccls/call')<cr>
" callee
nn <silent> <leader>xC :call CocLocations('ccls','$ccls/call',{'callee':v:true})<cr>

nn <silent> gj :call CocLocations('ccls','$ccls/navigate',{'direction':'D'})<cr>
nn <silent> gh :call CocLocations('ccls','$ccls/navigate',{'direction':'L'})<cr>
nn <silent> gl :call CocLocations('ccls','$ccls/navigate',{'direction':'R'})<cr>
nn <silent> gk :call CocLocations('ccls','$ccls/navigate',{'direction':'U'})<cr>

nmap  <Plug>(coc-float-jump)

inoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
inoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"

" lua require('ufo').setup()
