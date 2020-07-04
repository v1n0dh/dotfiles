let mapleader = "\t"

"--- Plugins ---

call plug#begin('~/.vim/plugged')

	" Plug 'Valloric/YouCompleteMe'		"autocomplete
	" Plug 'vim-syntastic/syntastic'		"syntax checking
	Plug 'jiangmiao/auto-pairs'		"autocomplete brackets
	" Plug 'ctrlpvim/ctrlp.vim'		"file finder

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
set path+=** 	" Search down into subfolders

" split below and right side of actual file
set splitbelow splitright

" remove extra white spaces in a line
autocmd bufwritepost * %s/\s\+$//e

" Run xrdb command whenever Xresources or Xdefaults are updated
autocmd BufWritePost *Xresources,*Xdefaults !xrdb -merge %

" source bashrc file whenever updated
autocmd BufWritePost *bashrc !source %

" enable executable permissions after updating a script
autocmd BufWritePost *.sh,*.bash,*.py !chmod +x %

" --- Color Schemes ---

set background=dark
"set termguicolors
"colorscheme twilight256

" Autocomplete settings

" let g:ycm_python_binary_path = 'python3'
" let g:ycm_autoclose_preview_window_after_completion = 1
" let g:ycm_min_num_of_chars_for_completion = 1
" let g:ycm_global_ycm_extra_conf = '~/.vim/plugged/YouCompleteMe/third_party/ycmd/cpp/ycm/.ycm_extra_conf.py'

" split navigations

map <leader>j <C-W><C-J>
map <leader>k <C-W><C-K>
map <leader>l <C-W><C-L>
map <leader>h <C-W><C-H>

" mapping for substitute command
nnoremap <leader>s :%s//g<left><left>

" find command
map <leader>f :find <right>

" terminal
map <leader>t :vertical terminal<CR>
map <leader>T :terminal<CR>
tnoremap <leader>n <C-W>N

" StatusBar

hi base ctermbg=black ctermfg=grey guibg=#080808 guifg=#808080

set laststatus=2
set statusline=
set statusline+=%#base#
set statusline+=\ [%n]
set statusline+=\ %F
set statusline+=\ %r
set statusline+=%=
set statusline+=\ %y
set statusline+=\ %3l/%L
