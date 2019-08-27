packadd termdebug
hi debugPC term=reverse ctermbg=darkgrey guibg=darkblue
hi debugBreakpoint term=reverse ctermbg=blue guibg=red

fun! GetGdbUntilCmd()
    let linenr = line('.')
    return 'until ' . linenr
endf

fun! AttachLastHmCmd()
    let lhmpid = system('pgrep -n -u $USER hmopengl')
    return 'attach ' . lhmpid
endf

fun! JumpAndBreak()
    let linenr = line('.')
    call TermDebugSendCommand('tbreak ' . linenr)
    call TermDebugSendCommand('jump ' . linenr)
endf

nnoremap <leader>gu :call TermDebugSendCommand(GetGdbUntilCmd())<CR>
nnoremap <leader>gj :call JumpAndBreak()<CR>
nnoremap <leader>n  :call TermDebugSendCommand('next')<CR>
nnoremap <C-Space>  :call TermDebugSendCommand('next')<CR>
nnoremap <leader>ga :call TermDebugSendCommand(AttachLastHmCmd())<CR>
