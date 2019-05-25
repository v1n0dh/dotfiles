set nocompatible

" --- General Settings ---

syntax on	" Enables syntax
set number
set hlsearch	" Hilights the search element
set incsearch	" Ignore case sensitive in search
set showcmd
set mouse=a	" Enable mouse in vim
autocmd! bufwritepost .vimrc source %	" Reload vimrc automatically
set wildmenu
set encoding=utf-8
set backspace=indent,eol,start 		"backspace

" --- Plugins ---

call plug#begin('~/.vim/plugged')

	Plug 'Valloric/YouCompleteMe'		"autocomplete
	Plug 'vim-syntastic/syntastic'		"syntax checking
	Plug 'Raimondi/delimitMate'		"autocomplete brackets
	Plug 'ctrlpvim/ctrlp.vim'		"file finder

call plug#end()

" --- Color Schemes ---

set background=dark
set termguicolors
colorscheme lucid

" Autocomplete settings

let g:ycm_python_binary_path = 'python3'
let g:ycm_autoclose_preview_window_after_completion = 1
let g:ycm_min_num_of_chars_for_completion = 1

" split navigations

nnoremap <C-S> <C-W><C-J>
nnoremap <C-W> <C-W><C-K>
nnoremap <C-D> <C-W><C-L>
nnoremap <C-A> <C-W><C-H>

" Remappings

map <F3> :bprevious<CR>		"previous buffer 
map <F4> :bnext<CR>		"next buffer 

" StatusBar

set laststatus=2
set statusline=
set statusline+=%=
set statusline+=\ %L 
set statusline+=\ %n
