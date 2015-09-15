" VIM Configuration File
" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
filetype off
call vundle#begin()
Plugin 'scrooloose/nerdtree'
Plugin 'scrooloose/nerdcommenter'
Plugin 'jpalardy/vim-slime'
Plugin 'tpope/vim-unimpaired'
Plugin 'danro/rename.vim'
call vundle#end()

filetype plugin indent on
" set UTF-8 encoding
set enc=utf-8
set fenc=utf-8

" automatically reread externally changed files (not modified in vim)
set autoread
set hidden

" longer command history
set history=1000
set termencoding=utf-8
" disable vi compatibility (emulation of old bugs)
set nocompatible
" use indentation of previous line
set autoindent
" use intelligent indentation for C
set smartindent
" configure tabwidth and insert spaces instead of tabs
set tabstop=4        " tab width is 4 spaces
set sw=4
set shiftwidth=4     " indent also with 4 spaces
set expandtab        " expand tabs to spaces
" wrap lines at 120 chars. 80 is somewaht antiquated with nowadays displays.
set textwidth=120

" turn syntax highlighting on
syntax on
set t_Co=256
set bg=dark

"colorscheme lucius
if (match(system("cat /etc/issue"), "Ubuntu") != -1)
    let g:lucius_contrast_bg = 'high'
endif
colorscheme lucius

" turn line numbers on
set number
" highlight matching braces
set showmatch
" intelligent comments
"set comments=sl:/*,mb:\ *,elx:\ */
"incremental searching
set incsearch 

if v:version > 703 
  set formatoptions+=j " Delete comment character when joining commented lines
endif

" no toolbar, no menu
set guioptions-=T
set guioptions-=m
" no righthand scroll bar
set guioptions-=r
" no left hand scroll bar
set guioptions-=L
set pastetoggle=<f5>
" Automatically cd into the directory that the file is in
autocmd BufEnter * execute "chdir ".escape(expand("%:p:h"), ' ')

let NERDTreeQuitOnOpen=1
"remap jj to escape in insert mode
inoremap jj <Esc>
let mapleader=","
nmap <leader>w :w!<cr>
nmap <leader>e :e<space>
nmap <leader>x :x<cr>
nmap <leader>q :bd<cr>
nmap <leader>b :buffers<cr>:b<space>
nmap <leader>n :NERDTree<cr>
" Pressing ,ss will toggle and untoggle spell checking
map <leader>ss :setlocal spell!<cr>
" Toggle paste mode on and off
map <leader>pp :setlocal paste!<cr>
nmap <S-Enter> i<cr><Esc> 

" vim-slime
let g:slime_target = "tmux"
let g:slime_paste_file = tempname()
