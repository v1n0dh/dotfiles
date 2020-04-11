" --- Plugins ---

call plug#begin('~/.vim/plugged')

	Plug 'Valloric/YouCompleteMe'		"autocomplete
	Plug 'vim-syntastic/syntastic'		"syntax checking
	Plug 'jiangmiao/auto-pairs'		"autocomplete brackets
	Plug 'ctrlpvim/ctrlp.vim'		"file finder

call plug#end()

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
set tabstop=4
set softtabstop=4
set shiftwidth=4
set noexpandtab
set nocompatible

" split below and right side of actual file
set splitbelow splitright

" remove extra white spaces in a line
autocmd bufwritepost * %s/\s\+$//e


" --- Color Schemes ---

set background=dark
" set termguicolors
" colorscheme monokai

" Autocomplete settings

" let g:ycm_python_binary_path = 'python3'
" let g:ycm_autoclose_preview_window_after_completion = 1
" let g:ycm_min_num_of_chars_for_completion = 1
" let g:ycm_global_ycm_extra_conf = '~/.vim/plugged/YouCompleteMe/third_party/ycmd/cpp/ycm/.ycm_extra_conf.py'

" split navigations

nnoremap <C-j> <C-W><C-J>
nnoremap <C-k> <C-W><C-K>
nnoremap <C-l> <C-W><C-L>
nnoremap <C-h> <C-W><C-H>

" Remappings

map <F3> :bprevious<CR>		"previous buffer
map <F4> :bnext<CR>		"next buffer

" StatusBar

" set laststatus=2
" set statusline=
" set statusline+=%=
" set statusline+=\ %L
" set statusline+=\ %n

