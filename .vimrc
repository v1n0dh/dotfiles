let mapleader = ","

" Plugins: {{{

call plug#begin('~/.vim/plugged')

Plug 'jiangmiao/auto-pairs'
Plug 'tpope/vim-surround'
Plug 'morhetz/gruvbox'
Plug 'vim-scripts/AutoComplPop'
Plug 'vim-scripts/OmniCppComplete'

call plug#end()

" }}}

" General Settings: {{{

syntax enable						" Enables syntax
set number
set relativenumber
set hlsearch
set incsearch						" Ignore case sensitive in search
set showcmd
set mouse=a							" Enable mouse in vim
autocmd! bufwritepost ~/.vimrc source %	" Reload vimrc automatically
set wildmenu						" completion menu
set encoding=utf-8
set backspace=indent,eol,start 		" backspace
set tabstop=4						" set tabsize to 4
set softtabstop=4
set shiftwidth=4
set noexpandtab
set nocompatible
set path+=**						" Search down into subfolders
set hidden
set splitbelow splitright			" split rightside or below the current window
filetype plugin indent on
" netrw settings
let g:netrw_browse_split = 4
let g:netrw_winsize = 20
let g:netrw_banner = 0
let g:netrw_liststyle = 3
" color scheme settings
set background=dark
let g:gruvbox_contrast_dark = 'hard'
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

" tab navigations
" nmap <leader>n :tabnext<CR>
" nmap <leader>p :tabprevious<CR>

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
nnoremap <leader>ev :vsplit $MYVIMRC<CR>
nnoremap <leader>sv :source $MYVIMRC<CR>

" }}}

" StatusBar: {{{

set laststatus=2
set statusline=
set statusline+=%#Pmenu#
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

" c and c++ snippets
augroup filetype_c_cpp
	autocmd!
	autocmd Filetype c,cpp inoremap <buffer> <localleader>i #include <><left>
	autocmd Filetype c,cpp inoremap <buffer> <localleader>d #define<SPACE>
	autocmd Filetype c,cpp inoremap <buffer> <localleader>m int main()<CR>{<CR><CR>}<up><TAB>
	autocmd Filetype c,cpp inoremap <buffer> <localleader>e if () {<CR>}<up><ESC>f)i
	autocmd Filetype c,cpp inoremap <buffer> <localleader>f for () {<CR>}<up><ESC>f)i
	autocmd Filetype c,cpp inoremap <buffer> <localleader>w while () {<CR>}<up><ESC>f)i
	autocmd Filetype c,cpp inoremap <buffer> <localleader>s switch () {<CR>}<up><ESC>f)i
	autocmd Filetype cpp inoremap <buffer> <localleader>c class<CR>{<CR><CR><CR>}<ESC><up>ipublic:<ESC>0x<up>i<CR><ESC><up>iprivate:<ESC>0x<up><up><ESC>2fsa<SPACE>
	autocmd Filetype c,cpp nnoremap <buffer> <localleader>t I// <ESC>
augroup END

" }}}

" OmniCppComplete Settings {{{

augroup omni_cpp
	autocmd!
	autocmd Filetype cpp set tags+=~/.vim/tags/cpptags
	autocmd Filetype cpp let OmniCpp_MayCompleteDot = 1
	autocmd Filetype cpp let OmniCpp_MayCompleteArrow = 1
	autocmd Filetype cpp let OmniCpp_MayCompleteScope = 1
	autocmd Filetype cpp let OmniCpp_SelectFirstItem = 2
	autocmd Filetype cpp let OmniCpp_NamespaceSearch = 2
	autocmd Filetype cpp let OmniCpp_ShowPrototypeInAbbr = 1
	autocmd Filetype cpp let OmniCpp_LocalSearchDecl = 1
	autocmd CursorMovedI * if pumvisible() == 0 | pclose | endif
	autocmd InsertLeave * if pumvisible() == 0 | pclose | endif
augroup END

" }}}
