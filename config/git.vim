" GIT commands
nmap <leader>gs :G<CR>
" Commit  
nmap <leader>gc :Git commit<CR>
" Stage current file
nmap <leader>ga :Git add %<CR>
" Unstage current file
nmap <leader>gr :Git restore --staged %<CR>
" Diff
nmap <leader>gd :Gdiffsplit<CR>
" Log 
nmap <leader>gl :Git log %<CR>
" Blame
nmap <leader>gb :Git Blame<CR>
"nmap <leader>dv "Diff
"conflict resolve left side
nmap <leader>gf :diffget //2<CR>
"conflict resolve right side
nmap <leader>gj :diffget //3<CR>
"Add changes
nmap <C-h> :diffput
nmap <C-l> :diffget

"Apply changes
nmap <leader>gw :Gwrite<CR>

" Push  
nmap <leader>gp :Git push<CR>
" Pull 
nmap <leader>gu :Git pull<CR>

" Go to next change
"[c
"]c

" In Git view
" ce => Append
" cw => Append and rewrite message
