let g:vimspector_enable_mappings = 'HUMAN'
nmap <leader>dd :call vimspector#Launch()<CR>
nmap <leader>dx :VimspectorReset<CR>
nmap <leader>de :VimspectorEval
nmap <leader>dw :VimspectorWatch
nmap <leader>do :VimspectorShowOutput<CR>
nnoremap <Leader>dt :call vimspector#ToggleBreakpoint()<CR>
autocmd FileType dart nmap <leader>dd :CocCommand  <CR>

" mnemonic 'di' = 'debug inspect' (pick your own, if you prefer!)

 " for normal mode - the word under the cursor
 nmap <Leader>di <Plug>VimspectorBalloonEval
 " for visual mode, the visually selected text
 xmap <Leader>di <Plug>VimspectorBalloonEval
