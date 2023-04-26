" GIT commands
nmap <leader>gs :G<CR>
" Status
nmap <leader>gS :G status<CR>
" Checkout 
"nmap <leader>gC :Git checkout 
nmap <leader>gC :Gbranch <CR>
" Commit  
nmap <leader>gc :Git commit<CR>
" Stage current file
nmap <leader>ga :Git add %<CR>
" Unstage current file
nmap <leader>gr :Git restore --staged %<CR>
" Diff
nmap <leader>gd :Gdiffsplit<CR>
" Log current file
nmap <leader>gl :Git log %<CR>
"nmap <leader>gl :Git log origin/develop %<CR>
" List remote branchs 
nmap <leader>gB :Git branch -a<CR>
" Blame current file
nmap <leader>gb :Git Blame %<CR>

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

" Delete branch remotly
" git push origin --delete feature/branch

" Delete branch local
" git branch -d feature/branch
" git branch -D feature/branch

" Clean remote refs
" Only check what is be clean
" git remote prune origin --dry-run
" Clean at all  
" git remote prune origin 

" Pull 
"function! PushToCurrentBranch()
"  let branch = trim(system('git branch --show-current'))
"  exe ':Git pull origin ' .  branch . ' --recurse-submodules'
"endfunction
let branch = trim(system('git branch --show-current'))
command! -bar -nargs=* Gpull execute 'Git pull ' <q-args> ' origin ' .  branch . ' --recurse-submodules' 
nmap <leader>gu :Gpull <CR>

" Go to next change
"[c
"]c

" In Git view
" ce => Append
" cw => Append and rewrite message
"
"

function! s:changebranch(branch) 
      if stridx(trim(a:branch), 'origin') >= 0
        execute 'Git checkout --track ' . trim(a:branch) . ' --recurse-submodules'
      else
        execute 'Git checkout ' . trim(a:branch) . ' --recurse-submodules'
      endif
         call feedkeys("i")
endfunction

command! -bang Gbranch call fzf#run({
              \ 'source': 'git branch -a --no-color | grep -v "^\* " ', 
              \ 'sink': function('s:changebranch')
            \ })
