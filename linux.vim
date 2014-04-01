" Linux-specific settings
"""""""""""""""""""""""""

" Set terminal encoding to utf-8
if (&term =~ "xterm" || &term == "screen") && (&termencoding == "")
	set termencoding=utf-8
endif

" Set screen title as well.
if &term == "screen"
	set t_ts=
	set t_fs=
endif

" I Can Has 256 Colorz.
if &term == "screen" || &term == "xterm-256color" || &term == "xterm"
	set t_Co=256
endif

" Change terminal titlebar
if &term == "screen" || &term =~ "xterm"
	if has('title')
		set title
	endif
endif


