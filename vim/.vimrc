scriptencoding utf-8
set encoding=utf-8

" Plugins

" Make sure Plug Installer is installed
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif
call plug#begin('~/.vim/plugged')

Plug 'scrooloose/nerdtree'            " File navigation
Plug 'kien/ctrlp.vim'                 " Ctrl-p fuzzy finder
Plug 'tpope/vim-commentary'           " Comments gc
Plug 'tpope/vim-surround'             " easy surroundings
Plug 'tpope/vim-repeat'               " repeat advanced commands (eg. vim surround) 
Plug 'mattn/emmet-vim'                " Emmet for vim
Plug 'christoomey/vim-tmux-navigator' " Navigate seamlessly between vim and tmux splits
Plug 'christoomey/vim-tmux-runner'    " Send commands from vim to tmux
Plug 'tpope/vim-fugitive'             " Git for vim
Plug 'ervandew/supertab'              " Autocompletion with tab
Plug 'shime/vim-livedown'             " preview your markdown file with :LivedownPreview
Plug 'ElmCast/elm-vim'                " preview your markdown file with :LivedownPreview
Plug 'prettier/vim-prettier', { 'do': 'yarn install' }
                                      "make your js files ... prettier!
Plug 'elixir-editors/vim-elixir'      " Elixir support for vim
Plug 'isRuslan/vim-es6'               " ES6 syntax highlighting
Plug 'evidens/vim-twig'               " Twig syntax highlighting
Plug 'stevearc/vim-arduino'           " Add Arduino support (depends on arduino command)
Plug 'stephpy/vim-php-cs-fixer'       " Add wrapper around php-cs-fixer

call plug#end()

set nocompatible      " Use improved vi at the cost of being compatible to previous versions
set backspace=2       " Backspace deletes like most programs in insert mode and the same as set backspace=.indent,eol,start
set history=50        " remember commands (default = 50)

set nobackup          " no swp-file business etc.
set nowritebackup
set noswapfile

set autowrite         " Automatically :write before running commands

set splitbelow        " Open new split panes to right and bottom, which feels more natural
set splitright

set list listchars=tab:»·,trail:·,nbsp:· " Display extra whitespace
set nofoldenable      " Say no to code folding...

set tabstop=2         " Reasonable tab settings
set shiftwidth=2
set shiftround
set expandtab

" Tab settings per filetype
autocmd FileType html setlocal shiftwidth=4 tabstop=4
autocmd FileType php setlocal shiftwidth=4 tabstop=4

" Color Scheme
syntax enable
colorscheme monokai

" Relative AND absolute line numbers
set numberwidth=5
set number relativenumber

" Case insensitive search
set ignorecase
set smartcase

" Highlight cursorline
set cursorline

" Jump to the last cursor position when reopening a file
if has("autocmd")
  au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif

" NerdTree
let NERDTreeShowHidden=1 " Show hidden files
let NERDTreeSortHiddenFirst=1
let NERDTreeSortOrder=[]
let NERDTreeIgnore = ['\.DS_Store$']
" Open Nerdtree with Ctrl-n
map <C-N> :NERDTreeToggle<CR>
" Show current file in NERDTree
noremap <leader>f :NERDTreeFind<CR> 

" CTRL-P
let g:ctrlp_switch_buffer = 0 " Allow opening mutlipe splits with same file via CtrlP
let g:ctrlp_match_window_bottom = 1
let g:ctrlp_working_path_mode = 'r'
let g:ctrlp_match_window_reversed = 1
let g:ctrlp_mruf_default_order = 1
let g:ctrlp_max_height = 30
let g:ctrlp_max_files = 300
let g:ctrlp_max_depth = 99

" Persistent undo
set undofile " Maintain undo history between sessions
set undodir=~/.vim/undo

" Use The Silver Searcher https://github.com/ggreer/the_silver_searcher
if executable('ag')
  " Use Ag over Grep
  set grepprg=ag\ --nogroup\ --nocolor

  " Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
  let g:ctrlp_user_command = 'ag %s -l --nocolor --hidden -g ""'

  " ag is fast enough that CtrlP doesn't need to cache
  let g:ctrlp_use_caching = 0
endif
set grepprg=ag

" Vertical splits for fugitive
set diffopt+=vertical

" KEYBOARD MAPPINGS

" 0 is easier to reach than ^
nmap 0 ^

" Allign window movement for vim and tmux
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-h> <C-w>h
nnoremap <C-l> <C-w>l

" Don't allow arrow key movements
nnoremap <Left> :echoe "Use h"<CR>
nnoremap <Right> :echoe "Use l"<CR>
nnoremap <Up> :echoe "Use k"<CR>
nnoremap <Down> :echoe "Use j"<CR>

" A line is supposed to be a displayed line (not an actual line in the code)
nmap k gk
nmap j gj

" transform my typical typos into meaningful commands
:command! W w
:command! Q q
:command! Qa qa
:command! Wq wq

" Format file indentation
nnoremap <Leader><space> <esc>gg=G``zz

let g:VtrUseVtrMaps = 1     " Vim tmux runner default mapping

:command! -complete=file -nargs=1 Rpdf :r !pdftotext -nopgbrk <q-args> -
:command! -complete=file -nargs=1 Rpdf :r !pdftotext -nopgbrk <q-args> - |fmt -csw78

" Automatically comb your CSS on save
" (requires to be installed with `npm install csscomb -g`)
autocmd FileType scss,css nnoremap <buffer> <leader>css :call CSScomb()<CR>
function! CSScomb()
  execute "silent !csscomb " . expand('%')
  redraw!
endfunction

" Arduino
let g:arduino_verify_tmux = ''
let g:arduino_upload_tmux = ''
nnoremap <Leader>av :ArduinoVerify<cr>
nnoremap <Leader>au :ArduinoUpload<cr>

