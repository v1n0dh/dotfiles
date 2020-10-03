
augroup cpp_snippets
	autocmd!
	autocmd Filetype c,cpp inoremap <buffer> <localleader>i #include <><left>
	autocmd Filetype c,cpp inoremap <buffer> <localleader>d #define<SPACE>
	autocmd Filetype c,cpp inoremap <buffer> <localleader>m int main()<CR>{<CR><CR>}<up><TAB>
	autocmd Filetype c,cpp inoremap <buffer> <localleader>e if () {<CR>}<up><ESC>f)i
	autocmd Filetype c,cpp inoremap <buffer> <localleader>f for () {<CR>}<up><ESC>f)i
	autocmd Filetype c,cpp inoremap <buffer> <localleader>w while () {<CR>}<up><ESC>f)i
	autocmd Filetype c,cpp inoremap <buffer> <localleader>s switch () {<CR>}<up><ESC>f)i
	autocmd Filetype c,cpp inoremap <buffer> <localleader>c class<CR>{<CR><CR><CR>}<ESC><up>ipublic:<ESC>0x<up>i<CR><ESC><up>iprivate:<ESC>0x<up><up><ESC>2fsa<SPACE>
	autocmd Filetype cpp nnoremap <buffer> <localleader>t I// <ESC>
augroup END
