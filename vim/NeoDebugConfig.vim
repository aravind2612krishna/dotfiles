
fun! GetGdbUntilCmd()
    let linenr = line('.')
    return 'until ' . linenr
endf

fun! AttachLastHmCmd()
    let lhmpid = system('pgrep -n -u $USER hw')
    return 'attach ' . lhmpid
endf

fun! JumpAndBreak()
    let linenr = line('.')
    call TermDebugSendCommand('tbreak ' . linenr)
    call TermDebugSendCommand('jump ' . linenr)
endf

" let g:neodbg_keymap_toggle_breakpoint  = '<F12>'         " toggle breakpoint on current line
" let g:neodbg_keymap_next               = '<leader>j'        " next
" let g:neodbg_keymap_run_to_cursor      = '<leader>gu'      " run to cursor (tb and c)
" let g:neodbg_keymap_jump               = '<leader>jb'    " set next statement (tb and jump)
" let g:neodbg_keymap_step_into          = '<leader><CR>'        " step into
" let g:neodbg_keymap_step_out           = '<BS>'      " step out
" " let g:neodbg_keymap_continue           = '<leader>gc'         " run or continue
" let g:neodbg_keymap_print_variable     = 'K'        " view variable under the cursor
" let g:neodbg_keymap_stop_debugging     = '<S-F5>'       " stop debugging (kill)
" let g:neodbg_keymap_toggle_console_win = '<F6>'         " toggle console window
" let g:neodbg_keymap_terminate_debugger = '<leader>q'        " terminate debugger

nnoremap <leader>gc <cmd>call NeoDebug("continue")<CR>
nnoremap <PageUp> <cmd>call NeoDebug("up")<CR>
nnoremap <PageDown> <cmd>call NeoDebug("down")<CR>
nnoremap <leader>ga <cmd>call NeoDebug("pattach hw")<CR>
nnoremap <leader>p <cmd>call NeoDebug("elemPrintDetailed " . expand("<cword>"))<CR>
nnoremap <leader>pe <cmd>call NeoDebug("edgePrintDetailed " . expand("<cword>"))<CR>
