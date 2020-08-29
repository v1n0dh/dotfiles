 let mapleader = "	"

"--- Plugins ---

call plug#begin('~/.vim/plugged')

" Plug 'Valloric/YouCompleteMe'		"autocomplete
Plug 'vim-syntastic/syntastic'		"syntax checking
Plug 'jiangmiao/auto-pairs'			"autocomplete brackets
Plug 'tpope/vim-surround'

call plug#end()

" --- General Settings ---

syntax enable	" Enables syntax
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
set hidden

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
let g:gruvbox_contrast_dark = 'hard'
let g:gruvbox_vert_split = 'bg2'
colorscheme gruvbox

" Syntastic settings
let g:syntastic_always_populate_loc_list = 0
let g:syntastic_auto_loc_list = 0
let g:syntastic_check_on_open = 0
let g:syntastic_check_on_wq = 0

let g:syntastic_mode_map = { 'mode': 'passive', 'active_filetypes': [],'passive_filetypes': [] }
nnoremap <leader>e :SyntasticCheck<CR>
nnoremap <leader>E :SyntasticToggleMode<CR>

" Autocomplete settings

" let g:ycm_python_binary_path = 'python3'
" let g:ycm_autoclose_preview_window_after_completion = 1
" let g:ycm_min_num_of_chars_for_completion = 1
" let g:ycm_global_ycm_extra_conf = '~/.vim/plugged/YouCompleteMe/third_party/ycmd/cpp/ycm/.ycm_extra_conf.py'

" split navigations

map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l
map <C-h> <C-w>h

map <leader>j <C-w>J
map <leader>k <C-w>K
map <leader>l <C-w>L
map <leader>h <C-w>H

" tab navigations
map <leader>n :tabnext<CR>
map <leader>p :tabprevious<CR>

" buffer navigations
map <C-p> :bprevious<CR>
map <C-n> :bnext<CR>

" mapping for substitute command
nnoremap <leader>s :%s//g<left><left>

" terminal
map <leader>t :vertical terminal<CR>
map <leader>T :terminal<CR>
tnoremap <leader>n <C-W>N

" find command
map <leader>/ :find <right>

" highlight code block
map <leader>v V$%

" StatusBar

hi base ctermbg=236 ctermfg=256 guibg=#1a1a1a guifg=#aaaaaa

set laststatus=2
set statusline=
set statusline+=%#LineNr#
set statusline+=\ [%n]
set statusline+=\ %8F
set statusline+=\ %M
set statusline+=\ %3y
set statusline+=\ %r
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%#LineNr#
set statusline+=%=
set statusline+=\ Format:%{&ff}
set statusline+=\ [%p%%]
set statusline+=\ %2l/%L
