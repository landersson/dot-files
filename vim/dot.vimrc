" VIM Configuration File
" Set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
filetype off
call vundle#begin()
Plugin 'scrooloose/nerdcommenter'
"Plugin 'jpalardy/vim-slime' " for pasting test into screen/tmux sessions
Plugin 'tpope/vim-unimpaired'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-surround' 
Plugin 'danro/rename.vim'
Plugin 'Valloric/YouCompleteMe'
Plugin 'fs111/pydoc.vim'
Plugin 'kana/vim-textobj-user'
Plugin 'lucapette/vim-textobj-underscore.git'
Plugin 'Julian/vim-textobj-variable-segment' 
Plugin 'sgur/vim-textobj-parameter'
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'machakann/vim-swap'
Plugin 'mileszs/ack.vim'
Plugin 'rodjek/vim-puppet'
Plugin 'Vimjas/vim-python-pep8-indent'
Plugin 'pangloss/vim-javascript'
Plugin 'timonv/vim-cargo'
Plugin 'landersson/vim-term-cargo'
call vundle#end()

filetype plugin indent on

" set UTF-8 encoding
set enc=utf-8
set fenc=utf-8
set fileformat=unix

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

" c/c++ indentation options
set cino=N-s,g0,j1,(0,t0

" configure tabwidth and insert spaces instead of tabs
set tabstop=4        " tab width is 4 spaces
set sw=4
set shiftwidth=4     " indent also with 4 spaces
set expandtab        " expand tabs to spaces

" wrap lines at 120 chars. 80 is somewaht antiquated with nowadays displays.
set textwidth=0
set nofoldenable

" builtin terminal ansi colors

if exists('+termguicolors')
  let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
  let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
  set termguicolors
endif

"set termguicolors
let g:terminal_ansi_colors = [
            \ "#000000", "#a82838", "#108020", "#a07010", "#4060e0", "#a050b0", "#109090", "#707070",
            \ "#909090", "#b84050", "#309040", "#c09010", "#5080f0", "#c070d0", "#30c0c0", "#c0c0c0"]
set t_Co=256

if has("gui_running") 
    "colorscheme laan
    set bg=light
else
    set bg=dark
endif

" turn syntax highlighting on
let g:solarized_contrast="high"
colorscheme blueberry
syntax on

"highlight matching angle brackets
set matchpairs+=<:> 

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

set shortmess+=c

" Automatically cd into the directory that the file is in
"autocmd BufEnter * execute "chdir ".escape(expand("%:p:h"), ' ')
" strip trailing whitespace on code files before each buffer write
autocmd BufWritePre *.{py,cc,h} :%s/\s\+$//e

set laststatus=2
set statusline=%<\ %n:%F\ %m%r%y%=%-35.(L:\ %l\/\%L,\ C:\ %c%V\ (%P)%)

"--- Plugin options ------------------------------------------------------------ 

" ack
if executable('ag')
  let g:ackprg = 'ag --vimgrep'
endif
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

" YCM options
let g:ycm_always_populate_loc_list = 0
let g:ycm_enable_diagnostic_signs = 0
let g:ycm_seed_identifiers_with_syntax = 1
let g:ycm_collect_identifiers_from_tags_files = 1
let g:ycm_collect_identifiers_from_comments_and_strings = 1
let g:ycm_cache_omnifunc=0
let g:ycm_autoclose_preview_window_after_completion = 0
let g:ycm_autoclose_preview_window_after_insertion = 0
"let g:ycm_global_ycm_extra_conf = '~/.vim/.ycm_extra_conf.py'

" CtrlP options
let g:ctrlp_map = '' 
let g:ctrlp_match_current_file = 1

let g:pydoc_cmd = 'python3 -m pydoc'

"--- Keyboard mapping ------------------------------------------------------------  

"remap jk to escape in insert mode
inoremap jk <Esc>
let mapleader=","
nnoremap <leader>w :w!<cr>
"nnoremap <leader>p <c-w>w
nnoremap <c-p> <c-w>w
nnoremap <c-h> <c-w>h
nnoremap <c-l> <c-w>l:
nnoremap <leader>z :e #<cr>
nnoremap <leader>l <c-w>w
" edit file in the same directory 
nnoremap <leader>e :e <C-R>=expand("%:p:h") . "/" <CR>
nnoremap <leader>v :vsp<space>
nnoremap <leader>g :YcmCompleter GoTo<cr>
nnoremap <leader>s :%s/
nnoremap <leader>a ct_
nnoremap <leader>X :x<cr>
nnoremap <leader>xw <c-w>q       " close current window
nnoremap <leader>xq :cclose<cr>  " close quickfix
nnoremap <leader>q :bp\|bd #<cr>
nnoremap <leader>b :buffers<cr>:b<space>
nnoremap <leader>n :NERDTree<cr>
nnoremap <leader>m :CtrlPMRUFiles<cr>
nnoremap <leader>f :CtrlP<cr>
nnoremap <leader>t :botright split<cr>:term ++curwin<cr>
nnoremap <leader>` :vsplit $MYVIMRC<cr>
nnoremap <leader>% :w<cr>:so %<cr>
nnoremap <leader><space> i<space><Esc>la<space><Esc>h
" Pressing ,ss will toggle and untoggle spell checking
noremap <leader>ss :setlocal spell!<cr>
" Toggle paste mode on and off
noremap <leader>pp :setlocal paste!<cr>
noremap Y y$

" Open new line and enter insert mode without indentation
nnoremap <S-Enter> A<cr><Esc>I
" Open new line without entering insert mode
nnoremap <c-Enter> o<Esc>

function! RepeatChar(char, count)
    return repeat(a:char, a:count)
endfunction

nnoremap s :<C-U>exec "normal i".RepeatChar(nr2char(getchar()), v:count1)<CR>
nnoremap S :<C-U>exec "normal a".RepeatChar(nr2char(getchar()), v:count1)<CR>
noremap <Up> <NOP>
noremap <Down> <NOP>
noremap <Left> <NOP>
noremap <Right> <NOP>

" Compile buffer as rust and run
noremap <leader>rr :w<cr>:RustRun<cr>

" show symbol id for word under cursor
noremap <leader>xs :echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<'
            \ . synIDattr(synID(line("."),col("."),0),"name") . "> lo<"
            \. synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"<CR>

function! ReturnHighlightTerm(group, term)
   " Store output of group to variable
   let output = execute('hi ' . a:group)

   " Find the term we're looking for
   return matchstr(output, a:term.'=\zs\S*')
endfunction
