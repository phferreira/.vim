let g:dart_format_on_save = 1
let g:flutter_show_log_on_run='tab'
let g:flutter_use_last_run_option=1
let g:flutter_autoscroll=1
let g:dartfmt_options = ['--fix', '--line-length 180']

" Check fzf maps for conflicts
nnoremap <leader>fr :call FlutterRun()<cr>
nnoremap <leader>fq :FlutterQuit<cr>
nnoremap <leader>fh :FlutterHotReload<cr>
nnoremap <leader>fR :FlutterHotRestart<cr>
nnoremap <leader>fD :FlutterVisualDebug<cr>
nnoremap <leader>fa :call FlutterAnalyze()<cr>
nnoremap <leader>ft :call FlutterTest()<cr>
nnoremap <leader>fct :call FlutterCreateTest()<cr>
nnoremap <leader>fta :call FlutterTestAll()<cr>
