let mapleader = ","
let $RTP=split(&runtimepath, ',')[0]
let $RC="$HOME/.vimrc"

" Plugins: {{{

call plug#begin('~/.vim/plugged')

Plug 'jiangmiao/auto-pairs'
Plug 'tpope/vim-surround'
Plug 'morhetz/gruvbox'

call plug#end()

" }}}

" General Settings: {{{

syntax enable							" Enables syntax
set number
set relativenumber
set hlsearch
set incsearch							" Ignore case sensitive in search
set showcmd
set mouse=a								" Enable mouse in vim
set wildmenu							" completion menu
set encoding=utf-8
set backspace=indent,eol,start			" backspace
set tabstop=4							" set tabsize to 4
set softtabstop=4
set shiftwidth=4
set noexpandtab
set nocompatible
set path+=**
set hidden
set splitbelow splitright				" split rightside or below the current window
set noswapfile
filetype plugin indent on
" color scheme settings
set background=dark
let g:gruvbox_contrast_dark = "hard"
let g:gruvbox_vert_split = 'bg2'
colorscheme gruvbox
" autocompletion settings
set omnifunc=syntaxcomplete#Complete
set completeopt=menuone,preview,longest

" }}}

" General autocommands: {{{

augroup general
	autocmd!
	" remove extra white spaces in a line
	autocmd BufWritePost * %s/\s\+$//e
	autocmd BufWritePost * %s/\n\+\%$//e

	" Run xrdb command whenever Xresources or Xdefaults are updated
	autocmd BufWritePost *Xresources,*Xdefaults !xrdb -merge %

	" source bashrc file whenever updated
	autocmd BufWritePost *bashrc !source %

	" enable executable permissions after updating a script
	autocmd BufWritePost *.sh,*.bash,*.py !chmod +x %

	" set foldmethod to marker
	autocmd Filetype vim set foldmethod=marker

	autocmd! bufwritepost ~/.vimrc source %

	autocmd Filetype c source $RTP/snippets/c.vim
	autocmd Filetype cpp source $RTP/snippets/cpp.vim
augroup END

" }}}

" Key Bindings: {{{

" split navigations
nmap <C-j> <C-w>j
nmap <C-k> <C-w>k
nmap <C-l> <C-w>l
nmap <C-h> <C-w>h

nmap <leader>j <C-w>J
nmap <leader>k <C-w>K
nmap <leader>l <C-w>L
nmap <leader>h <C-w>H

" buffer navigations
nmap <C-p> :bprevious<CR>
nmap <C-n> :bnext<CR>

" mapping for substitute command
nnoremap <leader>s :%s//g<left><left>

" terminal
nnoremap <leader>t :vertical terminal<CR>
nnoremap <leader>T :terminal<CR>
tnoremap <leader>tn <C-W>N

nnoremap <leader>/ :find <right>

nnoremap <leader>v va{

nnoremap <leader>n :noh<CR>

" make a vimrc split and source vimrc
nnoremap <leader>ev :e $MYVIMRC<CR>
nnoremap <leader>sv :source $MYVIMRC<CR>

" }}}

" StatusBar: {{{

hi base ctermbg=236 ctermfg=256 guibg=#1a1a1a guifg=#aaaaaa

set laststatus=2
set statusline=
set statusline+=%#base#
set statusline+=\ [%n]
set statusline+=\ %8F
set statusline+=\ %M
set statusline+=\ %3y
set statusline+=\ %r
set statusline+=%=
set statusline+=\ Format:%{&ff}
set statusline+=\ [%p%%]
set statusline+=\ %2l/%L

" }}}

" Snippets:  {{{

let maplocalleader = "/"

augroup includes
	autocmd!
	autocmd Filetype sh inoremap <buffer> <localleader>i #!/bin/sh<CR><CR>
	autocmd Filetype bash inoremap <buffer> <localleader>i #!/bin/bash<CR><CR>
	autocmd Filetype python inoremap <buffer> <localleader>i #!/usr/bin/python3<CR><CR>
augroup END

" }}}
