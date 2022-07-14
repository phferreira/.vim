" GIT commands
nmap <leader>gs :G<CR>
" Diff
"nmap <leader>gd :Git diff<CR>
"nmap <leader>dv "Diff
"conflict resolve left side
nmap <leader>gf :diffget //2<CR>
"conflict resolve right side
nmap <leader>gj :diffget //3<CR>
"Add changes
nmap <C-h> :diffput
nmap <C-l> :diffget
