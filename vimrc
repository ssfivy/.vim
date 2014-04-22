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
" ==Task-specific configuration==
"
" ==Language-specific configuration==
"
"

" ========================
" = OS-specific settings =
" ========================
" Handle cross-platform issues after bootloader

" Set location of all of our auxiliary scripts
let s:vimfiles="$HOME/.vim"

if has('win32') || has('win64')
	" Load windows-specific settings
	:exec ":source " . s:vimfiles . "/windows.vim"
else
	" Load linux-specific settings
	:exec ":source " . s:vimfiles . "/linux.vim"
endif

" =====================
" = Plugin management =
" =====================

" Let vundle handle all our plugins for us
set nocompatible
filetype off
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

" Plugin management
Plugin 'gmarik/vundle'

" Colorschemes
Plugin 'tomasr/molokai'
Plugin 'ciaranm/inkpot'
Plugin 'altercation/vim-colors-solarized'

" Navigational
Plugin 'scrooloose/nerdtree'              " treeview on side
Plugin 'jistr/vim-nerdtree-tabs'          " nerdtree improvements
Plugin 'myusuf3/numbers.vim'              " Intellegently toggle line numbers
Plugin 'plasticboy/vim-markdown'          " Folding on markdown files

" Auto completion
Plugin 'ervandew/supertab'                " use tab key for insert completion
		" Plugin 'sirver/ultisnips'           " snippet engine
Plugin 'honza/vim-snippets'               " snippet collection
		" Plugin 'Valloric/YouCompleteMe'     " Code completion engine

" Formatting
Plugin 'godlygeek/tabular'                " Line up various texts

" External Tools
Plugin 'oplatek/Conque-Shell'       " Open shell inside vim window
		" Plugin 'vim-scripts/vcscommand.vim' " Multiple version control plugin

filetype plugin indent on

" stuff I don't know how to add to vundle
:exec ":source" . s:vimfiles . "/cscope_maps.vim"

" ========================
" = Common Configuration =
" ========================

" General configuration
"""""""""""""""""""""""

" Sets how many lines of history VIM has to remember
set history=1000

" VIM user interface
""""""""""""""""""""

" line numbers
set number
" do not display line numbers in these filetypes
let g:numbers_exclude = ['conque_term','tagbar', 'gundo', 'minibufexpl', 'nerdtree']
" Ignore case when searching
set ignorecase
" When searching try to be smart about cases
set smartcase
" Highlight search results
set hlsearch
" While typing a search command, show where the pattern, as it was typed
" so far, matches.  The matched string is highlighted.
set incsearch
" Clear search result highlight when entering insert mode
" This sets the "latest search" register to the empty string, so that nothing
" will be highlighted. Earlier searches can still be remembered by using the
" key after hitting / or ? and optionally the "start" of the string to be
" searched.
autocmd InsertEnter * :let @/=""
autocmd InsertLeave * :let @/=""

" tab completion for command mode
set wildmode=longest:full,list:full,full
set wildmenu

" Colors and Fonts
""""""""""""""""""
" Enable syntax highlighting
syntax on

" Set color scheme
set background=dark
color inkpot

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

" Default tab configuration
setlocal tabstop=4       " Tabs are 4 spaces wide



" Moving around, vim tabs and buffers
"""""""""""""""""""""""""""""""""""""

" always show tab bar
set showtabline=2

" open NERDTree on startup
autocmd VimEnter * NERDTreeTabsOpen

" Exclude irrelevant filed from NERDTree
let NERDTreeIgnore = ['\.pyc$', '\.launch$', '\.apconfig$']

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

" Tags and related
""""""""""""""""""

" Omni completion
set omnifunc=syntaxcomplete#Complete
set completeopt=menuone,longest,preview

" Trigger omni completion with tab key
let g:SuperTabDefaultCompletionType = "context"
" Navigate completion menu from top to bottom
let g:SuperTabContextDefaultCompletionType = "<c-n>"

" Snippet trigger configuration
"let g:UltiSnipsExpandTrigger="<tab>"

" ==========================
" = Task-specific settings =
" ==========================
" Run specific vimrc scripts depending on what the computer is
" call script for work/circuitlink
if has('win32') || has('win64')
	:exec ":source " . s:vimfiles . "/work.vim"
endif
" call script for personal machine

" =================================== 
" = Language-specific configuration =
" =================================== 
" See .vim/after/ftplugin for more configurations after this vimrc ends

" Change colorschemes by filetype
" We can't put this command in separate filetype plugin, this has to be a
" global command
:autocmd BufEnter,FileType *
\   if &ft ==# 'c' || &ft ==# 'cpp' | colorscheme inkpot |
\   elseif &ft ==# 'mkd' | colorscheme molokai |
\   endif

