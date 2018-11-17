
set nocompatible              " required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'

" add all your plugins here (note older versions of Vundle
" used Bundle instead of Plugin)

Plugin 'vim-scripts/indentpython.vim'
Plugin 'vim-syntastic/syntastic'
Plugin 'nvie/vim-flake8'
Plugin 'scrooloose/nerdtree'
Plugin 'Lokaltog/powerline', {'rtp': 'powerline/bindings/vim/'}
Plugin 'flazz/vim-colorschemes' " Vim colorschemes
Plugin 'godlygeek/tabular' " Aligning things
Plugin 'Townk/vim-autoclose' " Auto-close braces
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'elmcast/elm-vim'
Plugin 'rust-lang/rust.vim'
Plugin 'isRuslan/vim-es6'

" Plugin 'tpope/vim-obsession'
Plugin 'christoomey/vim-tmux-navigator'

" Plugin 'Valloric/YouCompleteMe'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required

au BufNewFile,BufRead *.py
	\ set tabstop=4 |
	\ set softtabstop=4 |
	\ set shiftwidth=4 |
	\ set expandtab |
	\ set autoindent |
	\ set fileformat=unix

python3 << EOF
import os
import sys
if 'VIRTUAL_ENV' in os.environ:
    project_base_dir = os.environ['VIRTUAL_ENV']
    activate_this = os.path.join(project_base_dir, 'bin/activate_this.py')
    # exec(open(activate_this).read(), dict(__file__=activate_this))
    with open(activate_this) as f:
        code = compile(f.read(), "activate_this.py", 'exec')
        exec(code, dict(__file__=activate_this))

EOF

let python_highlight_all=1
syntax on

highlight BadWhitespace ctermbg=red guibg=darkred
au BufRead,BufNewFile *.py,*.pyw,*.c,*.h match BadWhitespace /\s\+$/

set encoding=utf-8
let g:syntastic_python_checkers=['flake8']
let g:syntastc_quiet_messages = { 'type': 'style' }
set nu

set tabstop=4
set shiftwidth=4
set autoindent
set smartindent
set textwidth=0 wrapmargin=0
" set laststatus=2 " Always show the powerline

colorscheme wombat256

map! fd <Esc>

let mapleader = " "

" Remap Space+direction keys to move across splits
nnoremap <C-j> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-h> <C-W><C-H>
nnoremap <C-l> <C-W><C-L>

nnoremap <C-Y> <C-W>>
nnoremap <C-O> <C-W><
nnoremap <C-U> <C-W>+
nnoremap <C-I> <C-W>-

nmap ; :CtrlPBuffer<CR>

" Remap Space+N to open toggle NERDTree
nnoremap <leader>ne :NERDTreeToggle<cr>

" Allow the mouse to resize splits
set mouse=n
set ttymouse=xterm2
set pastetoggle=<Insert>


