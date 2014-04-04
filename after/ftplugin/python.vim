" Override the default python settings

" Use indentation for code folding
set foldmethod=indent

" Set omni completion to use python syntax
set omnifunc=pythoncomplete#Complete

" override the indentation settings
" PEP-8 mandates 4 spaces indent for new code.
setlocal expandtab
setlocal shiftwidth=4
setlocal softtabstop=4
