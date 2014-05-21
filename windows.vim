
" Windows-specific settings
"""""""""""""""""""""""""""

"Set font for gvim
set guifont=Consolas:h10:cANSI

" Use cmd if we're calling shell stuff
" I would use powershell except it broke diff functionality
set shell=cmd.exe

" fix backspace key behavior for gvim in windows
set backspace=indent,eol,start 

" use diff utility from PATH
"set diffexpr=
