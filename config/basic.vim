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

nnoremap <C-j> i<CR><ESC>
"wget https://github.com/ryanoasis/nerd-fonts/blob/master/patched-fonts/RobotoMono/Medium/complete/Roboto%20Mono%20Medium%20Nerd%20Font%20Complete%20Mono.ttf
"set guifont=RobotoMono\ Nerd\ Font\ Mono:h16
