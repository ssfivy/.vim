" Override the default python settings

" Use indentation for code folding
set foldmethod=indent
" Keep toplevel fold open when opening file
set foldlevel=1

" Set omni completion to use python syntax
set omnifunc=pythoncomplete#Complete

" override the indentation settings
" PEP-8 mandates 4 spaces indent for new code.
setlocal expandtab
setlocal shiftwidth=4
setlocal softtabstop=4

" Allow shortcut to execute current file
" will save all files, determine our desired interpreter then executes the current file
" https://superuser.com/questions/20625/vim-execute-the-script-im-working-on-in-a-split-screen
" https://stackoverflow.com/questions/953398/how-to-execute-file-im-editing-in-vim/953425#953425
" set autowrite
" au BufEnter *
" \if match( getline(1) , '^\#!') == 0 |
" \ execute("let b:interpreter = getline(1)[2:]") |
" \endif
"
" fun! CallInterpreter()
" 	if exists("b:interpreter")
" 		set makeprg=b:interpreter."\ %"
" 		make<cr>
"		exec ("!".b:interpreter." %")
" 	endif
" endfun
" map <F5> :call CallInterpreter()<cr>
":map <F5> :make<cr>

" Above solution need more vimscript magic than I have so here's a simpler
" version for now
" map <F5> :w<cr>:!%:p<cr><cr>
