set nocompatible	        " Use Vim defaults (much better!)

filetype off                  " required by vundle?
" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim

"call vundle#begin('~/some/path/here')
call vundle#begin()
Plugin 'gmarik/Vundle.vim'
Plugin 'tmhedberg/SimpylFold'
Plugin 'Valloric/YouCompleteMe'
Plugin 'scrooloose/nerdtree'
Plugin 'scrooloose/syntastic'
Plugin 'wincent/command-t'
Plugin 'tpope/vim-pathogen'

Plugin 'vim-scripts/indentpython.vim'
Plugin 'nvie/vim-flake8'

Plugin 'rust-lang/rust.vim'

Bundle 'leafo/moonscript-vim'

Plugin 'lervag/vimtex'

Plugin 'raichoo/purescript-vim'

Plugin 'jnurmine/Zenburn'
Plugin 'altercation/vim-colors-solarized'
call vundle#end()            " required
filetype on    " required
filetype plugin indent on    " required


set bs=indent,eol,start		" allow backspacing over everything in insert mode
set autoindent  	        " always set autoindenting on
set smartindent
"set backup	            	" keep a backup file
set viminfo='20,\"50    	" read/write a .viminfo file, don't store 
                                " more than 50 lines of registers
set history=50		        " keep 50 lines of command line history
set ruler		            " show the cursor position all the time
set tildeop                 " make tilde (~) behave like an operator
set number                  " show line numbers

set splitbelow
set splitright

" Python stuff
let python_highlight_all=1
"au BufRead,BufNewFile *.py,*.pyw,*.c,*.h match BadWhitespace /\s\+$/
"python with virtualenv support
py << EOF
import os
import sys
if 'VIRTUAL_ENV' in os.environ:
  project_base_dir = os.environ['VIRTUAL_ENV']
  activate_this = os.path.join(project_base_dir, 'bin/activate_this.py')
  execfile(activate_this, dict(__file__=activate_this))
EOF

"NerdTree
map <C-n> :NERDTreeToggle<CR>
let NERDTreeIgnore=['\.pyc$', '\~$']

"YouCompleteMe
let g:ycm_autoclose_preview_window_after_completion=1
map <leader>g  :YcmCompleter GoTo<CR>
map <leader>r  :YcmCompleter GoToReferences<CR>
let g:ycm_rust_src_path = '/home/etandel/proj/rust/src'

"work around so .rs files are detected as rust instead of hercules (wtf?)
au BufRead,BufNewFile *.rs set filetype=rust

if has('gui_running')
    set guioptions-=m  "remove menu bar
    set guioptions-=T  "remove menu bar
    set background=dark
    set guifont=Inconsolata\ 14
    colorscheme solarized
else
    colorscheme zenburn
endif


if v:lang =~ "utf8$" || v:lang =~ "UTF-8$"
   set fileencodings=ucs-bom,utf-8,latin1
endif


"TODO, change the bg: match ErrorMsg '\%>100v.\+' " colors line red when it's longer than 100chars

" Switch syntax highlighting on, when the terminal has colors
" Also don't switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
  syntax on
  set nohlsearch
endif

set expandtab
set tabstop=4
set smarttab
set softtabstop=4
set shiftwidth=4

noremap <Up> <nop>
noremap <Down> <nop>
noremap <Left> <nop>
noremap <Right> <nop>
noremap <F1> <nop>

set foldmethod=indent   "fold based on indent
set foldlevel=1         
set foldnestmax=10      "deepest fold is 10 levels
set nofoldenable        "dont fold by default

if has("cscope") && filereadable("/usr/bin/cscope")
   set csprg=/usr/bin/cscope
   set csto=0
   set cst
   set nocsverb
   " add any database in current directory
   if filereadable("cscope.out")
      cs add cscope.out
   " else add database pointed to by environment
   elseif $CSCOPE_DB != ""
      cs add $CSCOPE_DB
   endif
   set csverb
endif

filetype plugin on

if &term=="xterm"
     set t_Co=8
     set t_Sb=[4%dm
     set t_Sf=[3%dm
endif

" Don't wake up system with blinking cursor:
" http://www.linuxpowertop.org/known.php
let &guicursor = &guicursor . ",a:blinkon0"

