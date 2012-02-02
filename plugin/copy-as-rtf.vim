" Vim plugin for copying syntax highlighted code as RTF on OS X systems
" Last Change: 2011-07-24
" Maintainer:	Nathan Witmer <nwitmer@gmail.com>
" License: WTFPL

if exists('g:loaded_copy_as_rtf')
  finish
endif
let g:loaded_copy_as_rtf = 1

if !has('macunix')
    finish " probably we are under Linux
endif

if !executable('pbcopy') 
  echomsg 'copy-as-rtf plugin: can not load dependency: pbcopy'
  finish
endif

if !executable('textutil')
  echomsg 'copy-as-rtf plugin: can not load dependency: textutil'
  finish
endif

" copy the current buffer or selected text as RTF
function! s:CopyRTF(line1,line2)

  if !exists(':TOhtml')
    echoerr 'TOhtml command not found, is the plugin enabled and available?'
    return
  endif

  call tohtml#Convert2HTML(a:line1, a:line2)
  silent exe "%!textutil -convert rtf -stdin -stdout | pbcopy"
  silent bd!
  echomsg "RTF copied to clipboard"
endfunction

command! -range=% CopyRTF :call s:CopyRTF(<line1>,<line2>)
