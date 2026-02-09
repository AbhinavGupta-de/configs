" .vimrc - Converted from .ideavimrc

call plug#begin('~/.vim/plugged')

Plug 'machakann/vim-highlightedyank'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-surround'
Plug 'easymotion/vim-easymotion'
Plug 'justinmk/vim-sneak'
Plug 'preservim/nerdtree'
Plug 'vim-scripts/ReplaceWithRegister'
Plug 'kana/vim-textobj-user'
Plug 'kana/vim-textobj-entire'
Plug 'terryma/vim-multiple-cursors'
Plug 'liuchengxu/vim-which-key'
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'jiangmiao/auto-pairs'
Plug 'sheerun/vim-polyglot'

call plug#end()

let mapleader = " "

set number
set relativenumber
set incsearch
set hlsearch
set smartcase
set ignorecase
set showmode
set showcmd
set scrolloff=10
set visualbell
set t_vb=
set clipboard=unnamed
set autoindent
set smartindent
set expandtab
set tabstop=4
set shiftwidth=4
set softtabstop=4
set hidden
set wildmenu
set wildmode=longest:full,full
set backspace=indent,eol,start
set mouse=a
set encoding=utf-8
set splitright
set splitbelow
set noswapfile
set nobackup
set nowritebackup

let g:highlightedyank_highlight_duration = 300
let NERDTreeShowHidden=1
let NERDTreeQuitOnOpen=1
let g:EasyMotion_do_mapping = 0
let g:sneak#label = 1
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'
let g:ctrlp_working_path_mode = 'ra'

set timeoutlen=500
nnoremap <silent> <leader> :<c-u>WhichKey '<Space>'<CR>
vnoremap <silent> <leader> :<c-u>WhichKeyVisual '<Space>'<CR>

inoremap jk <Esc>
map Q gq
vnoremap < <gv
vnoremap > >gv
nnoremap <leader><Space> :nohlsearch<CR>

nnoremap <A-h> <C-w>h
nnoremap <A-l> <C-w>l
nnoremap <A-k> <C-w>k
nnoremap <A-j> <C-w>j
nnoremap <A-n> :tabnext<CR>
nnoremap <A-p> :tabprev<CR>

map <leader>f <Plug>(easymotion-s)
map <leader>e <Plug>(easymotion-f)
map <leader>j <Plug>(easymotion-s)
map <leader>x :NERDTreeToggle<CR>

map <leader>ff :CtrlP<CR>
map <leader>fb :CtrlPBuffer<CR>

map <leader>wv :vsplit<CR>
map <leader>ws :split<CR>
map <leader>wh <C-w>h
map <leader>wl <C-w>l
map <leader>wk <C-w>k
map <leader>wj <C-w>j
map <leader>q :q<CR>
map <leader>w :w<CR>

map <leader>gs :Git<CR>
map <leader>gc :Git commit<CR>
map <leader>gp :Git push<CR>
map <leader>gl :Git log<CR>
map <leader>gb :Git blame<CR>
map <leader>gd :Gdiff<CR>

map <leader>zo zR
map <leader>zc zM
map <leader>c gcc

nnoremap <leader>bd :bd<CR>
nnoremap <leader>bn :bnext<CR>
nnoremap <leader>bp :bprev<CR>
nnoremap <leader>s :w<CR>
nnoremap <leader>qa :qa<CR>
