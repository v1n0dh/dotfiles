
augroup filetype_c
	autocmd!
	autocmd Filetype c inoremap <buffer> <localleader>i #include <><left>
	autocmd Filetype c inoremap <buffer> <localleader>d #define<SPACE>
	autocmd Filetype c inoremap <buffer> <localleader>m int main()<CR>{<CR><CR>}<up><TAB>
	autocmd Filetype c inoremap <buffer> <localleader>e if () {<CR>}<up><ESC>f)i
	autocmd Filetype c inoremap <buffer> <localleader>f for () {<CR>}<up><ESC>f)i
	autocmd Filetype c inoremap <buffer> <localleader>w while () {<CR>}<up><ESC>f)i
	autocmd Filetype c inoremap <buffer> <localleader>s switch () {<CR>}<up><ESC>f)i
	autocmd Filetype c nnoremap <buffer> <localleader>t I// <ESC>
augroup END
