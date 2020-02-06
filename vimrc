" Vim configuration file
"
" Table of contents:
"
" ==OS-specific configuration==
"
" ==Plugin management==
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
" ==Plugin-specific configuration==
"
" ==Language-specific configuration==
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
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" Plugin management
" To install plugin call :PluginInstall
Plugin 'VundleVim/Vundle.vim'

" Colorschemes
Plugin 'tomasr/molokai'
Plugin 'ciaranm/inkpot'
Plugin 'altercation/vim-colors-solarized'
Plugin 'jonathanfilip/vim-lucius'
Plugin 'chriskempson/base16-vim'

" Navigational
Plugin 'scrooloose/nerdtree'              " treeview on side
Plugin 'jistr/vim-nerdtree-tabs'          " nerdtree improvements
Plugin 'myusuf3/numbers.vim'              " Intellegently toggle line numbers
Plugin 'plasticboy/vim-markdown'          " Folding on markdown files

" Editing
Plugin 'terryma/vim-multiple-cursors'     " Multiple cursors
Plugin 'tpope/vim-commentary'             " Comments stuff out

" Auto completion
Plugin 'ervandew/supertab'                " use tab key for insert completion
Plugin 'sirver/ultisnips'           " snippet engine
Plugin 'honza/vim-snippets'               " snippet collection
" Plugin 'Valloric/YouCompleteMe'     " Code completion engine

" UI
Plugin 'vim-airline/vim-airline'           " Lean & mean status/tabline for vim that's light as air.
Plugin 'vim-airline/vim-airline-themes'     " Themes for vim-airline

" Formatting
Plugin 'godlygeek/tabular'                " Line up various texts

" Language support
Plugin 'dense-analysis/ale'          " Asynchronous syntax checker
Plugin 'sheerun/vim-polyglot'          " Language pack for 120+ languages

" External Tools
Plugin 'tpope/vim-fugitive'         " git client
"Plugin 'oplatek/Conque-Shell'       " Open shell inside vim window
" Plugin 'vim-scripts/vcscommand.vim' " Multiple version control plugin

" TODO: https://www.vimfromscratch.com/articles/vim-for-python/

call vundle#end()
filetype plugin indent on

" ========================
" = Common Configuration =
" ========================

" General configuration
"""""""""""""""""""""""

" Sets how many lines of history VIM has to remember
set history=1000

" enable modelines
set modeline
set modelines=5


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
if filereadable(expand("~/.vimrc_background"))
  let base16colorspace=256
  source ~/.vimrc_background
else
  set background=dark
  color solarized
endif

" default file encoding is utf-8
set encoding=utf-8

" Text, tab and indent related
""""""""""""""""""""""""""""""

" Show tabs and trailing whitespace visually
set list listchars=tab:»·,trail:·,extends:…
set listchars+=nbsp:‗

" Default tab configuration
setlocal tabstop=4       " Tabs are 4 spaces wide
setlocal softtabstop=4
setlocal shiftwidth=4
setlocal expandtab

" Moving around, vim tabs and buffers
"""""""""""""""""""""""""""""""""""""

" fix cursor around middle of screen and move the text around it
set scrolloff=30

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
set statusline+=\ %-3.3n\                       " buffer number
set statusline+=%f\                             " file name
set statusline+=%h%m%r%w                        " flags
set statusline+=\[%{strlen(&ft)?&ft:'none'},    " filetype
set statusline+=%{&encoding},                   " encoding
set statusline+=%{&fileformat}]                 " file format
set statusline+=%=                              " right align
set statusline+=%-14.(%l,%c%V%)\ %<%P           " offset

" Always show status line
set laststatus=2

" Tags and related
""""""""""""""""""

" Don't screw up folds when inserting text that might affect them, until
" leaving insert mode. Foldmethod is local to the window. Protect against
" screwing up folding when switching between windows.
"autocmd InsertEnter * if !exists('w:last_fdm') | let w:last_fdm=&foldmethod | setlocal foldmethod=manual | endif
"autocmd InsertLeave,WinLeave * if exists('w:last_fdm') | let &l:foldmethod=w:last_fdm | unlet w:last_fdm | endif

" Snippet trigger configuration
"let g:UltiSnipsExpandTrigger="<tab>"

" External interface
""""""""""""""""""""
" Hit F9 to run make
:map <F9> :make <CR>

" ================================= 
" = Plugin-specific configuration =
" ================================= 

" NERDTree 
"""""""""""
" open NERDTree on startup
autocmd VimEnter * NERDTreeTabsOpen

" Exclude irrelevant filed from NERDTree
let NERDTreeIgnore = ['\.pyc$', '\.launch$', '\.apconfig$', '\.egg-info$', '__pycache__']

let NERDTreeMapOpenSplit='h'
let NERDTreeMapToggleHidden='H'

" NERDtree fixes
" Open nerdtree on console vim, even on new tabs
let g:nerdtree_tabs_open_on_console_startup = 1
" When switching into a tab, make sure that focus is on the file window, not
" in the NERDTree window.
let g:nerdtree_tabs_focus_on_files = 1

" Omni completion
"""""""""""""""""
set omnifunc=syntaxcomplete#Complete
set completeopt=menuone,longest,preview

" Trigger omni completion with tab key
let g:SuperTabDefaultCompletionType = "context"
" Navigate completion menu from top to bottom
let g:SuperTabContextDefaultCompletionType = "<c-n>"

" Airline
"""""""""
let g:airline_theme='base16'        " set theme
let g:airline_powerline_fonts = 1   " use powerline fonts

" ALE
"""""
" Configure when linting happens
let g:ale_lint_on_text_changed = 'never'

let g:ale_linters = {
			\ 'c'   : ['clangd'],
			\ 'cpp' : ['clangd'],
			\ 'python': ['pylint', 'pyflake', 'flake8'],
			\ 'go': ['gofmt'],
			\ 'yaml': ['yamllint']
			\}
let g:ale_c_parse_compile_commands = 1

let g:ale_fixers = {
			\ 'python': ['autopep8'],
			\ 'go': ['gofmt'],
			\ '*': ['remove_trailing_lines', 'trim_whitespace']
			\}
let g:ale_fix_on_save = 1


" ================================== 
" = Machine-specific configuration =
" ================================== 
let hostname = substitute(system('hostname'), '\n', '', '')
if hostname == "petrushka"
	" Laptop, use light color theme
	set background=light
	color lucius
	LuciusLightHighContrast
endif

" =================================== 
" = Language-specific configuration =
" =================================== 
" See .vim/after/ftplugin for more configurations after this vimrc ends

" Change colorschemes by filetype
" We can't put this command in separate filetype plugin, this has to be a
" global command
" :autocmd BufEnter,FileType *
" \   if &ft ==# 'c' || &ft ==# 'cpp' | colorscheme inkpot |
" \   elseif &ft ==# 'mkd' | colorscheme molokai |
" \   endif
":exec "ConqueTermTab python"

