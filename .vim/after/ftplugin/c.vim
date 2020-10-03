
set tabstop=8
set shiftwidth=8
set softtabstop=8
set noexpandtab
set autoindent
set smartindent
setlocal path=.,**,,,/usr/include

inoremap <buffer> <localleader>i #include <><left>
inoremap <buffer> <localleader>d #define<SPACE>
inoremap <buffer> <localleader>m int main()<CR>{<CR><CR>}<up><TAB>
inoremap <buffer> <localleader>e if () {<CR>}<up><ESC>f)i
inoremap <buffer> <localleader>f for () {<CR>}<up><ESC>f)i
inoremap <buffer> <localleader>w while () {<CR>}<up><ESC>f)i
inoremap <buffer> <localleader>s switch () {<CR>}<up><ESC>f)i
nnoremap <buffer> <localleader>t I// <ESC>
