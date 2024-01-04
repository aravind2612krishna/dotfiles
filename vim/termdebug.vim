packadd termdebug
hi debugPC term=reverse ctermbg=darkgrey guibg=darkblue
hi debugBreakpoint term=reverse ctermbg=blue guibg=red

fun! GetGdbUntilCmd()
    let linenr = line('.')
    return 'until ' . linenr
endf

fun! AttachLastHmCmd()
    let lhmpid = system('pgrep -n -u $USER hwx$')
    return 'attach ' . lhmpid
endf

fun! JumpAndBreak()
    let linenr = line('.')
    call TermDebugSendCommand('tbreak ' . linenr)
    call TermDebugSendCommand('jump ' . linenr)
endf

nnoremap <leader>gu <cmd>call TermDebugSendCommand(GetGdbUntilCmd())<CR>
nnoremap <leader>jb <cmd>call JumpAndBreak()<CR>
nnoremap <leader>gc  <cmd>Continue<CR>
nnoremap <CR>  <cmd>Over<CR>
nnoremap <PageUp> <cmd>call TermDebugSendCommand('up')<CR>
nnoremap <PageDown> <cmd>call TermDebugSendCommand('down')<CR>
nnoremap <leader>] <cmd>Step<CR>
nnoremap <leader>[ <cmd>Finish<CR>
nnoremap <leader>k <cmd>call TermDebugSendCommand('p ' . expand("<cword>"))<CR>
" nnoremap | <cmd>call TermDebugSendCommand('p ' . expand("<cword>"))<CR>
nnoremap \ <cmd>Evaluate<CR>
vnoremap \ :'<,'>Evaluate<CR>
nnoremap <leader>p <cmd>call TermDebugSendCommand('p hwDGFIDebugDrawTcl::IDrawConn(pPart, ' . expand("<cword>") . ', "Draws")')<CR>
" nnoremap <leader>p <cmd>call TermDebugSendCommand('elemPrintDetailed ' . expand("<cword>"))<CR>
" nnoremap <leader>pe <cmd>call TermDebugSendCommand('edgePrintDetailed ' . expand("<cword>"))<CR>
" nnoremap <C-Space>  :call TermDebugSendCommand('next')<CR>
nnoremap <leader>ga :call TermDebugSendCommand(AttachLastHmCmd())<CR>

if !exists("g:termdebug_config")
    let g:termdebug_config = {}
endif
let g:termdebug_config['map_K'] = 0
