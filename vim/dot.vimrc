" VIM Configuration File
" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
filetype off
call vundle#begin()
call vundle#end()

filetype plugin indent on
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
"let g:zenburn_high_Contrast = 1
"colorscheme zenburn
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

set guioptions-=T
set guioptions-=r
set guioptions-=L
set pastetoggle=<f5>
" Automatically cd into the directory that the file is in
autocmd BufEnter * execute "chdir ".escape(expand("%:p:h"), ' ')
autocmd FileType puppet setlocal shiftwidth=2 tabstop=2 autoindent smartindent

