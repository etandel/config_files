"SET RUNTIMEPATH^=~/.VIM RUNTIMEPATH+=~/.VIM/AFTER
"let &packpath = &runtimepath
"source ~/.vimrc

"let mapleader = '\'

filetype off                  " required by vundle?
" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim

"call vundle#begin('~/some/path/here')
call vundle#begin()
Plugin 'gmarik/Vundle.vim'

Plugin 'neovim/nvim-lsp'
Plugin 'tamago324/nlsp-settings.nvim'  " allows for local per-project settings

"Plugin 'tmhedberg/SimpylFold'
"Plugin 'Valloric/YouCompleteMe'
Plugin 'scrooloose/nerdtree'
"Plugin 'scrooloose/syntastic'
Plugin 'wincent/command-t'
"Plugin 'tpope/vim-pathogen'
Plugin 'tpope/vim-surround'

Plugin 'ms-jpq/coq_nvim', {'branch': 'coq'}
Plugin 'ms-jpq/coq.artifacts', {'branch': 'artifacts'}
Plugin 'ms-jpq/coq.thirdparty', {'branch': '3p'}

Plugin 'vim-scripts/indentpython.vim'
"Plugin 'nvie/vim-flake8'

"Plugin 'rust-lang/rust.vim'
Plugin 'pest-parser/pest.vim'

Plugin 'vmchale/dhall-vim'

"Plugin 'cespare/vim-toml'

"Plugin 'hashivim/vim-terraform'

"Bundle 'leafo/moonscript-vim'

"Plugin 'rhysd/vim-gfm-syntax'

""html/css
Plugin 'mattn/emmet-vim'
Plugin 'othree/html5.vim'

"Plugin 'lervag/vimtex'

"Plugin 'raichoo/purescript-vim'

""elixir
Plugin 'elixir-editors/vim-elixir'
"Plugin 'slashmili/alchemist.vim'

" themes
Plugin 'jnurmine/Zenburn'
Plugin 'altercation/vim-colors-solarized'
Plugin 'overcache/NeoSolarized'
Plugin 'arcticicestudio/nord-vim'
Plugin 'sainnhe/sonokai'
call vundle#end()            " required
filetype on    " required
filetype plugin indent on    " required


set bs=indent,eol,start		" allow backspacing over everything in insert mode
set smartindent
"set backup	            	" keep a backup file
"set viminfo='20,\"50    	" read/write a .viminfo file, don't store 
                                " more than 50 lines of registers
set tildeop                 " make tilde (~) behave like an operator
set number                  " show line numbers

set splitbelow
set splitright

set expandtab
set tabstop=4
set softtabstop=4
set shiftwidth=4

set foldmethod=indent   "fold based on indent
set foldlevel=1         
set foldnestmax=10      "deepest fold is 10 levels
set nofoldenable        "dont fold by default

"make neovim check if file was changed and autoreload it if it was
set autoread    
au FocusGained * :checktime

noremap <Up> <nop>
noremap <Down> <nop>
noremap <Left> <nop>
noremap <Right> <nop>
noremap <F1> <nop>

if exists('g:neovide')
    "set guifont=Inconsolata\ 12
    set guifont=JetBrains_Mono:h8
    colorscheme sonokai
    let g:neovide_remember_window_size = v:false
    let g:neovide_scale_factor = 1.0
elseif has('gui_running')
    set guioptions-=m  "remove menu bar
    set guioptions-=T  "remove menu bar
    set background=dark
    "set guifont=Inconsolata\ 12
    set guifont=JetBrains\ Mono\ 10
    "set linespace=1
    "colorscheme solarized
    "colorscheme NeoSolarized
    colorscheme sonokai
else
    "colorscheme zenburn
    "colorscheme nord
    colorscheme sonokai
endif

if v:lang =~ "utf8$" || v:lang =~ "UTF-8$"
   set fileencodings=ucs-bom,utf-8,latin1
endif

" Switch syntax highlighting on, when the terminal has colors
" Also don't switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
  syntax on
  set nohlsearch
endif


" Don't wake up system with blinking cursor:
" http://www.linuxpowertop.org/known.php
let &guicursor = &guicursor . ",a:blinkon0"

filetype plugin on

"""" LANG AND PLUGIN CONFIGS """"

" Python stuff
"let python_highlight_all=1
let g:python3_host_prog = '/usr/bin/python3'

" Golang stuff
autocmd Filetype go setlocal noexpandtab tabstop=4 shiftwidth=4
autocmd Filetype proto setlocal noexpandtab tabstop=4 shiftwidth=4

"NerdTree
map <C-n> :NERDTreeToggle<CR>
let NERDTreeIgnore=['\.pyc$', '\~$']

"Command-T
let g:CommandTWildIgnore=&wildignore . ",*/bower_components,*/node_modules,*/target,*/_build,*/deps,venv,__pycache__"
let g:CommandTPreferredImplementation='lua'

lua << EOF
vim.keymap.set('n', '<Leader>b', '<Plug>(CommandTBuffer)')
vim.keymap.set('n', '<Leader>j', '<Plug>(CommandTJump)')
vim.keymap.set('n', '<Leader>t', '<Plug>(CommandT)')
EOF


" dhall
let g:dhall_format=1

"YouCompleteMe
"let g:ycm_autoclose_preview_window_after_completion=1
"map <leader>g  :YcmCompleter GoTo<CR>
"map <leader>r  :YcmCompleter GoToReferences<CR>
"let g:ycm_rust_src_path = '/home/etandel/proj/rust/src'
"let g:ycm_semantic_triggers = {
"     \}


" rust

"emmet
let g:user_emmet_install_global = 0
autocmd FileType html,css EmmetInstall

"gfm 
"let g:markdown_fenced_languages = ['json', 'python']

"filetypes workaround
au BufRead,BufNewFile *.dhall set filetype=dhall
au BufRead,BufNewFile *.rs set filetype=rust
au BufRead,BufNewFile *.ex,*.exs set filetype=elixir

"lsp and coq


lua << EOF
--vim.lsp.set_log_level("debug")

local nlspsettings = require("nlspsettings")
nlspsettings.setup({
  config_home = vim.fn.stdpath('config') .. '/nlsp-settings',
  local_settings_dir = ".nlsp-settings",
  local_settings_root_markers_fallback = { '.git' },
  append_default_schemas = true,
  loader = 'json'
})

vim.g.coq_settings = {auto_start = "shut-up"}
local coq = require("coq")

local nvim_lsp = require('lspconfig')
local on_attach = function(client, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  local opts = { noremap=true, silent=true }
  vim.keymap.set('n', '<leader>G', vim.lsp.buf.declaration, opts)
  vim.keymap.set('n', '<leader>g', vim.lsp.buf.definition, opts)
  vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
  vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
  vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
  -- buf_set_keymap('n', '<space>wa', vim.lsp.buf.add_workspace_folder, opts)
  -- buf_set_keymap('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, opts)
  vim.keymap.set('n', '<space>wl', function() print(vim.inspect(vim.lsp.buf.list_workspace_folders())) end, opts)
  vim.keymap.set('n', '<leader>D', vim.lsp.buf.type_definition, opts)
  vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts)
  vim.keymap.set('n', '<leader>R', vim.lsp.buf.references, opts)
  vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, opts)
  vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
  vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
  vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, opts)

  vim.keymap.set("n", "<leader>f", function() vim.lsp.buf.format {async = true} end, opts)

  -- Set autocommands conditional on server_capabilities
  -- if client.resolved_capabilities.document_highlight then
    vim.api.nvim_exec([[
      hi LspReferenceRead cterm=bold ctermbg=red guibg=LightYellow
      hi LspReferenceText cterm=bold ctermbg=red guibg=LightYellow
      hi LspReferenceWrite cterm=bold ctermbg=red guibg=LightYellow
      augroup lsp_document_highlight
        autocmd!
        autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
        autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
      augroup END
    ]], false)
  -- end
end

local capabilities = vim.lsp.protocol.make_client_capabilities()
--capabilities.textDocument.completion.completionItem.snippetSupport = true

-- Use a loop to conveniently both setup defined servers 
-- and map buffer local keybindings when the language server attaches
local servers = {"pyright", "rust_analyzer", "tsserver", "gopls", "dhall_lsp_server"}
for _, lsp in ipairs(servers) do
  nvim_lsp[lsp].setup(coq.lsp_ensure_capabilities{on_attach = on_attach, capabilities=capabilities})
end

require'lspconfig'.elixirls.setup(
    coq.lsp_ensure_capabilities{
        on_attach = on_attach,
        capabilites = capabilities,
        cmd = { "/home/etandel/sw/elixir-ls/language_server.sh" },
    }
)

EOF

" completion-nvim
" Use completion-nvim in every buffer
" Use <Tab> and <S-Tab> to navigate through popup menu
inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

" Set completeopt to have a better completion experience
set completeopt=menuone,noinsert,noselect

" Avoid showing message extra message when using completion
set shortmess+=c
