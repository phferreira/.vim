" Enable to copy to clipboard with "+y
" need install vim-gtk3
set clipboard=unnamedplus
" listen line number
set number relativenumber
" enable mouse click
"set mouse=r
set cursorline
" set UTF-8 encoding
set enc=utf-8
set fenc=utf-8
set termencoding=utf-8
" disable vi compatibility (emulation of old bugs)
set nocompatible
" use indentation of previous line
set autoindent
" use intelligent indentation for C
set smartindent
" Open new buffers in botton
set splitbelow
" Set terminal size
set termwinsize=15x0 
" can undo after quit a buffer
set hidden

" configure tabwidth and insert spaces instead of tabs
set tabstop=2        " tab width is 2 spaces
set shiftwidth=2     " indent also with 2 spaces
set expandtab        " expand tabs to spaces
" show space and tab
"set listchars=tab:>\ ,trail:.
" turn syntax highlighting on
set t_co=256
syntax on
" highlight matching braces
set showmatch
" intelligent comments
"set comments=sl:/*,mb:\ *,elx:\ */

set hlsearch     " highlight matches
set incsearch    " incremental searching
"set ignorecase   " searches are case insensitive...
set smartcase    " ... unless they contain at least one capital letter

" <leader> is space
let mapleader=" "
colorscheme codedark
set laststatus=2

" Enable  toggles
" za => Open/close single
" zo zc => Open/close single
" zM zR => Open/Close all
"set foldmethod=indent

" Line break at the end of screen
set nowrap " Without line break
" set wrap   " With line break 

" Buffers navigation
"nnoremap <c-x> :bp\|bd #<cr>
"nnoremap <c-x> :bd<cr> " This conflict with decrement
"nnoremap <M-BS> :bd<cr>
nnoremap <M-Right> :bn<cr>
nnoremap <M-Left> :bp<cr>
nmap <Space><Space> i<Space><ESC>

" Tab navigation, use to compatibility with tmux
nnoremap <C-M-Right> :tabnext<cr>
nnoremap <C-M-Left> :tabprevious<cr>
nnoremap <C-M-Up> :tabnew<cr>
nnoremap <C-M-Down> :tabclose<cr>

nnoremap <C-j> i<CR><ESC>

" Insert line
nnoremap <C-k> O<ESC> 

"wget https://github.com/ryanoasis/nerd-fonts/blob/master/patched-fonts/RobotoMono/Medium/complete/Roboto%20Mono%20Medium%20Nerd%20Font%20Complete%20Mono.ttf
"set guifont=RobotoMono\ Nerd\ Font\ Mono:h16

" Better tab
vnoremap < <gv
vnoremap > >gv

" Keep selection on upper or down case
vmap U Ugv
vmap u ugv

" Disable arrow keys
nnoremap <UP> <NOP>
nnoremap <DOWN> <NOP>
nnoremap <LEFT> <NOP>
nnoremap <RIGHT> <NOP>

" Change all ocurrency of current word
nnoremap <leader>r :%s///g<LEFT><LEFT>
nnoremap <leader>rc :%s///gc<LEFT><LEFT><LEFT>

xnoremap <leader>r :s///g<LEFT><LEFT>
xnoremap <leader>rc :s///gc<LEFT><LEFT><LEFT>

" Remap to only center the movementS
nnoremap <C-d> <C-d>zz
nnoremap <C-u> <C-u>zz
nnoremap n  nzzzv
nnoremap N  Nzzzv

" Use to compatibility with tmux
execute "silent! set <xUp>=\<Esc>[@;*A"
execute "silent! set <xDown>=\<Esc>[@;*B"
execute "silent! set <xRight>=\<Esc>[@;*C"
execute "silent! set <xLeft>=\<Esc>[@;*D"

