" VIM Configuration File
" set the runtime path to include Vundle and initialize
let g:haskell_conceal              = 0
set rtp+=~/.vim/bundle/Vundle.vim
filetype off
call vundle#begin()
Plugin 'scrooloose/nerdtree'
Plugin 'scrooloose/nerdcommenter'
Plugin 'jpalardy/vim-slime'
Plugin 'tpope/vim-unimpaired'
Plugin 'tpope/vim-fugitive'
Plugin 'danro/rename.vim'
Plugin 'dag/vim2hs'
"Plugin 'scrooloose/syntastic'
Plugin 'Valloric/YouCompleteMe'
Plugin 'fs111/pydoc.vim'
"Plugin 'bling/vim-airline'
Plugin 'kana/vim-textobj-user'
Plugin 'lucapette/vim-textobj-underscore.git'
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'rust-lang/rust.vim'
call vundle#end()

filetype plugin indent on
" set UTF-8 encoding
set enc=utf-8
set fenc=utf-8

" automatically reread externally changed files (not modified in vim)
set autoread
set hidden

" better tab completion when opening files
set wildmode=longest,list,full
set wildmenu

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
set textwidth=0
set nofoldenable

" turn syntax highlighting on
syntax on
set t_Co=256
set bg=dark
if has("gui_running") 
    "colorscheme lucius
    if (match(system("cat /etc/issue"), "Ubuntu") != -1)
        let g:lucius_contrast_bg = 'high'
        let g:lucius_contrast_bg = 'high'
    endif
    colorscheme lucius
else
    colorscheme laan
endif

" turn line numbers on
set number
" highlight matching braces
set showmatch
" intelligent comments
"set comments=sl:/*,mb:\ *,elx:\ */
"incremental searching
set incsearch 

" emacs style searching case policy
set ignorecase
set smartcase

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
autocmd BufWritePre *.py :%s/\s\+$//e

set laststatus=2
set statusline=%<\ %n:%F\ %m%r%y%=%-35.(L:\ %l\/\%L,\ C:\ %c%V\ (%P)%)

let g:ctrlp_map = '<c-k>'
let g:ctrlp_cmd = 'CtrlP'

let g:pydoc_cmd = 'python3 -m pydoc'
let NERDTreeQuitOnOpen=1
"remap jj to escape in insert mode
inoremap jk <Esc>
let mapleader=","
nmap <leader>w :w!<cr>
"nmap <leader>p <c-w>w
nmap <c-p> <c-w>w
nmap <c-h> <c-w>h
nmap <c-l> <c-w>l:
nmap <leader>e :e<space>
nmap <leader>v :vsp<space>
nmap <leader>g :YcmCompleter GoTo<cr>
nmap <leader>s :%s/
nmap <leader>X :x<cr>
nmap <leader>q :bp\|bd #<cr>
nmap <leader>b :buffers<cr>:b<space>
nmap <leader>n :NERDTree<cr>
" Pressing ,ss will toggle and untoggle spell checking
map <leader>ss :setlocal spell!<cr>
" Toggle paste mode on and off
map <leader>pp :setlocal paste!<cr>

" Open new line and enter insert mode without indentation
nmap <S-Enter> A<cr><Esc>I

" Open new line without entering insert mode
nmap <c-Enter> o<Esc>

function! RepeatChar(char, count)
    return repeat(a:char, a:count)
endfunction
nnoremap s :<C-U>exec "normal i".RepeatChar(nr2char(getchar()), v:count1)<CR>
nnoremap S :<C-U>exec "normal a".RepeatChar(nr2char(getchar()), v:count1)<CR>
noremap <Up> <NOP>
noremap <Down> <NOP>
noremap <Left> <NOP>
noremap <Right> <NOP>

" vim-slime
let g:slime_target = "timux"
let g:slime_paste_file = tempname()

" syntastic options
let g:syntastic_cpp_compiler = 'clang++-3.6'
let g:syntastic_cpp_compiler_options = ' -std=c++11'
"set statusline+=%#warningmsg#
"set statusline+=%{SyntasticStatuslineFlag()}
"set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

let g:ycm_register_as_syntastic_checker = 1


map <F10> :echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<'
            \ . synIDattr(synID(line("."),col("."),0),"name") . "> lo<"
            \. synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"<CR>

