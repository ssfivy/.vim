
" override the indentation settings
setlocal shiftwidth=4
setlocal softtabstop=4

" Shortcut to compile and preview
set autowrite
set makeprg=make
map <F5> :make<cr>
