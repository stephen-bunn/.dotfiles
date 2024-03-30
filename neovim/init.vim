" Plugins
" https://github.com/junegunn/vim-plug
call plug#begin(stdpath('data') . '/plugged')
Plug 'itchyny/lightline.vim'
Plug 'mengelbrecht/lightline-bufferline'
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'
Plug 'editorconfig/editorconfig-vim'
Plug 'raimondi/delimitmate'
Plug 'ryanoasis/vim-devicons'
Plug 'mcchrish/nnn.vim'
Plug 'dracula/vim', { 'as': 'dracula' }
Plug 'neoclide/coc.nvim', { 'branch': 'release' }
Plug 'roxma/nvim-yarp'
Plug 'roxma/vim-hug-neovim-rpc'
Plug 'dag/vim-fish'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'nanotee/zoxide.vim'
Plug 'NoahTheDuke/vim-just'
Plug 'github/copilot.vim'
call plug#end()

" Color Scheme
let g:dracula_colorterm = 0
colorscheme dracula

" COC
function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1] =~# '\s'
endfunction
" Map [tab] to iterate through COC completions
inoremap <silent><expr> <Tab>
  \ coc#pum#visible() ? coc#pub#next(1)
  \ CheckBackspace() ? "\<Tab>" :
  \ coc#refresh()

" Map [tab] to go to the next COC completion
inoremap <expr> <Tab> coc#pum#visible() ? coc#pum#next(1) : "\<Tab>"

" Map [shift + tab] to go to the previous COC completion
inoremap <expr> <S-Tab> coc#pum#visible() ? coc#pum#prev(1) : "\<Tab>"

" Map [ctrl + space] to refresh COC completions
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

" Lightline
let g:lightline = {
  \ 'colorscheme': 'dracula',
  \ 'tabline': {
  \   'left': [['buffers']],
  \   'right': [['close']]
  \ },
  \ 'component_expand': {
  \   'buffers': 'lightline#bufferline#buffers'
  \ },
  \ 'component_type': {
  \   'buffers': 'tabsel'
  \ }
  \ }

" Keybinds
noremap <C-A-w> <C-W><C-c>
noremap <C-A-n> :vsp<cr>
noremap <C-A-m> :sp<cr>
noremap <C-A-j> <C-W><C-j>
noremap <C-A-k> <C-W><C-k>
noremap <C-A-h> <C-W><C-h>
noremap <C-A-l> <C-W><C-l>
noremap <C-j> :bprevious<cr>
noremap <C-k> :bnext<cr>
noremap <C-n> :enew<cr>
noremap <C-w> :Bclose<cr>:tabclose<cr>gT
noremap <C-i> :Zi<cr>
noremap <C-o> :FZF .<cr>

" Force language variable to `en`
let $LANG='en'

" Leader
let mapleader = ","
" Write file with [leader:w]
nmap <leader>w :w!<cr>
" Quit nvim with [leader:q]
nmap <leader>q :q<cr>
" Disable highlights from search with [leader:enter]
map <silent> <leader><cr> :noh<cr>
map <leader>tee :tabedit <C-r>=expand("%:p:h")<cr>/k
map <leader>cd :cd %:p:h<cr>:pwd<cr>

syntax enable
filetype plugin on
filetype indent on

" Enable line numbers
set nu

" Enable proper terminal coloring
" Required when running nvim in either `screen` or `tmux`
set termguicolors

" Draw a desired line length column
set colorcolumn=100

" Set bash as the default shell for compatability with other shells (e.g. `fish`)
set shell=/bin/bash

" Set a history buffer limit for nvim
set history=500

" Enable autoreading of files
set autoread

" Set the statusline to always be visible
set laststatus=2

" Set the number of lines to show in the command-line window
set so=7

" Open new split windows below the current window
set splitbelow

" Open new split windows to the right of the current window
set splitright

" Set the language menu to English
set langmenu=en

" Enable wildmenu for command-line completion
set wildmenu

" Show the cursor position in the bottom right corner
set ruler

" Set the height of the command-line window
set cmdheight=1

" Keep hidden buffers in memory
set hid

" Configure backspace behavior
set backspace=eol,start,indent

" Allow cursor to move to the next/previous line in wrap mode
set whichwrap+=<,>,h,l

" Ignore case when searching
set ignorecase

" Use smart case when searching, unless a capital letter is used
set smartcase

" Highlight search results
set hlsearch

" Incremental search
set incsearch

" Disable redrawing while executing macros
set lazyredraw

" Enable magic characters in search patterns
set magic

" Show matching brackets/parentheses
set showmatch

" Set the maximum number of search matches to highlight
set mat=2

" Disable error bells
set noerrorbells

" Disable visual bell
set novisualbell

" Disable visual bell for terminal
set t_vb=

" Set the timeout for key codes
set tm=500

" Set the width of the fold column
set foldcolumn=2

" Set the background color scheme to dark
set background=dark

" Set the encoding to UTF-8
set encoding=utf8

" Set the file format options
set ffs=unix,dos,mac

" Expand tabs to spaces
set expandtab

" Use smart tabs
set smarttab

" Set the number of spaces for each indentation level
set shiftwidth=4

" Set the number of spaces for a tab
set tabstop=4

" Enable line break
set lbr

" Set the text width for automatic line wrapping
set tw=500

" Enable auto-indentation
set ai

" Enable smart indenting
set si

" Enable line wrapping
set wrap

au FocusGained,BufEnter * checktime
command! W execute 'w !sudo tee % >/dev/null' <bar> edit!

let g:lasttab = 25
nmap <leader>t1 :exe "tabn ".g:lasttab<cr>
au TabLeave * let g:lasttab = tabpagenr()

try
  set switchbuf=useopen,usetab,newtab
  set stal=2
catch
endtry
