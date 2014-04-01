" Vim configuration file
"
" Table of contents:
"
" ==Plugin management==
"
" ==OS-specific configuration==
"
" ==Common configuration==
"    -> General configuration
"    -> VIM user interface
"    -> Colors and Fonts
"    -> Files and backups
"    -> Text, tab and indent related
"    -> Visual mode related
"    -> Moving around, tabs and buffers
"    -> Status line
"    -> Editing mappings
"    -> vimgrep searching and cope displaying
"    -> Spell checking
"    -> Misc
"    -> Helper functions
"
" ==Language-specific configuration==
"
"

" =====================
" = Plugin management =
" =====================

" Set location of all of our auxiliary scripts
let s:vimfiles="$HOME/.vim"


" ========================
" = OS-specific settings =
" ========================

if has('win32') || has('win64')
	" Load windows-specific settings
	:exec ":source " . s:vimfiles . "/windows.vim"
else
	" Load linux-specific settings
	:exec ":source " . s:vimfiles . "/linux.vim"
endif

" ========================
" = Common Configuration =
" ========================

" General configuration
"""""""""""""""""""""""

" Sets how many lines of history VIM has to remember
set history=1000

" VIM user interface
""""""""""""""""""""

" Display line numbers
set number

" Ignore case when searching
set ignorecase

" When searching try to be smart about cases
set smartcase

" Highlight search results
set hlsearch

" While typing a search command, show where the pattern, as it was typed
" so far, matches.  The matched string is highlighted.
set incsearch

" Colors and Fonts
""""""""""""""""""
" Enable syntax highlighting
syntax on

" Set color scheme
set background=dark

" default file encoding is utf-8
set encoding=utf-8

" Text, tab and indent related
""""""""""""""""""""""""""""""

" Show tabs and trailing whitespace visually
if (&termencoding == "utf-8") || has("gui_running")
  set list listchars=tab:»·,trail:·,extends:…
  if v:version >= 700
    set listchars+=nbsp:‗
  endif
else
  set list listchars=tab:>-,trail:.,extends:>
  if v:version >= 700
    set listchars+=nbsp:_
  endif
endif

" Moving around, tabs and buffers
"""""""""""""""""""""""""""""""""

" always show tab bar
set showtabline=2

" fuck you lear siegler for putting arrow keys at insane locations
" crutch: use ijkl for sane arrow movement instead of hjkl
" also treat long (wrapped) lines as break lines (useful when moving around in them)
noremap i gk
noremap I K
noremap <C-w>i <C-w>k
noremap <C-w>I <C-w>K
noremap <C-w><C-i> <C-w><C-k>
noremap j h
noremap J H
noremap <C-w>j <C-w>h
noremap <C-w>J <C-w>H
noremap <C-w><C-j> <C-w><C-h>
noremap k gj
noremap K J
noremap <C-w>k <C-w>j
noremap <C-w>K <C-w>J
noremap <C-w><C-k> <C-w><C-k>
noremap h i
noremap H I

let NERDTreeMapOpenSplit='h'
let NERDTreeMapToggleHidden='H'

" restrict: disable arrow keys in normal and insert modes
map <up> <nop>
map <down> <nop>
map <left> <nop>
map <right> <nop>
imap <up> <nop>
imap <down> <nop>
imap <left> <nop>
imap <right> <nop>

" Status line
"""""""""""""

set statusline=
set statusline+=\ %-3.3n\ " buffer number
set statusline+=%f\ " file name
set statusline+=%h%m%r%w " flags
set statusline+=\[%{strlen(&ft)?&ft:'none'}, " filetype
set statusline+=%{&encoding}, " encoding
set statusline+=%{&fileformat}] " file format
set statusline+=%= " right align
set statusline+=%-14.(%l,%c%V%)\ %<%P " offset

" Always show status line
set laststatus=2

" =================================== 
" = Language-specific configuration =
" =================================== 
" See .vim/after/ftplugin for individual file types

