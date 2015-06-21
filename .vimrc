
	"  GUI SETTINGS  "
	""""""""""""""""""

if has ('gui_running')

" Boot up the current saved session
	source ~/.session.vim

" set font to Anonymous Pro, font size to 12
	set guifont=Anonymous\ Pro\ For\ Powerline 12



endif


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"	GENERAL SETTINGS														 "
"																			 "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" If running on Windows, use .vim directory instead of 'vimfiles'
	let s:MSWindows = has('win95') + has('win16') + has('win32') + has('win64')
	if s:MSWindows
		set runtimepath=$VIM/.vim,$VIMRUNTIME,$VIM/vimfiles/after,$VIM/.vim/after
	endif

" only uses file for vim, not vi. This removes any clashes
	set nocompatible

" allow backspacing over everything in insert mode
	set backspace=indent,eol,start

" enable file type detection for plugins
	filetype plugin indent on

" number of lines in history memory
	set history=10000

" :W sudo saves the file
"  (useful for handling the permission-denied error)
	command W w !sudo tee % > /dev/null

" when a vim file is edited externally, an open version changes with the edit
"  possibly only works while you have not edited your copy
	set autoread

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"	VIM USER INTERFACE														 "
"																			 "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Use UTF-8
	set encoding=utf-8

" turns on highlighting and colourising of programming code
	syntax on

" reduces tab indenting to 4 spaces, as per the python standard
" note that tabs are still tabs, not spaces
	set shiftwidth=4
	set tabstop=4

" sets text file 'textwidth' to 78 characters
	autocmd FileType text setlocal textwidth=78

" makes it automatically indent in specific cases, such as
"  when adding a curly bracket ({)
	set smartindent

" Minimal number of screen lines to keep above and below the cursor.
	set scrolloff=10

" In many terminal emulators the mouse works just fine, thus enable it.
	if has('mouse')
		set mouse=a
		endif

" Disable beeping
	set noeb vb t_vb=
	au GUIEnter * set vb t_vb=

	function! NumberToggle()
		if(&relativenumber == 1)
			set relativenumber!
		else
			set relativenumber
		endif
	endfunc

	nnoremap <leader>n :call NumberToggle()<cr>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"	ABBREVIATIONS AND COMMANDS												 "
"																			 "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
iabbrev myCopyright
		\#Copyright (C) 2015 crayonsmelting - protected under Australian and International Copyright law
	\<CR>#crayonsmelting can be found at http://www.github.com/crayonsmelting/
	\<CR>#or at crayons.melting@gmail.com
	\<CR>#Licence found within licence.txt
	\<CR>############################################
	\<CR>
	\<CR>
	\<CR>
	\<CR>

iabbrev shortCopy COPYRIGHT (C) 2015 crayonsmelting. See licence.txt.

iabbrev addBreak
	\<CR>---------------------------------------------------------------------
\---------
	\<CR>


	" HTML SHORTCUTS "
	""""""""""""""""""

iabbrev htmlTemplate <!DOCTYPE html>
	\<CR>
	\<CR><html lang="en">
	\<CR><head>
	\<CR><meta charset="utf-8"/>
	\<CR><title></title>
	\<CR></head>
	\<CR><body>
	\<CR></body>
	\<CR></html>

iabbrev cssLink <link rel='stylesheet' type='text/css' href='css/style.css'/>

iabbrev jsLink <script type="text/javascript" src="js/main.js"></script>

iabbrev jqueryLink <script type="text/javascript" src="js/jquery.js"></script>

" This is supposed to add a closing tag to an element automatically, after you
" type in "<//"
	inoremap <lt>// </<C-X><C-O>

	" OTHER COMMANDS "
	""""""""""""""""""

" With a map leader it's possible to do extra key combinations
"  like <leader>w saves the current file
	let mapleader = ","
	let g:mapleader = ","

" Leader-b is the black hole register (deleting or changing without saving for
"  pasting
	nnoremap <leader>b "_

" I wonder what control-S should do?
	noremap <c-s> <Esc>:w<CR>

" leader-s saves the session, leader-S saves session and buffers
	noremap <leader>s :mks! ~/.session.vim<CR>
	noremap <leader>S :mks! ~/.session.vim<CR>:w<CR>

" :C or leader-c clears search
	command C let @/ = ""
	nnoremap <leader>c :let @/ = ""<CR>

" Rather than deleting _all_ my stuff, Ctrl-w Ctrl-w changes window (like in
" norman mode)
	imap <C-w><C-w> <esc><C-w><C-w>

" binds Alt + Shift + G to show line numbers
	map <A-G> :set nu!<CR>

" binds space to open and close folds
	map <space> za

" returns you to normal mode when you press 'j'  and 'k' at the same time
	inoremap jk <Esc>
	inoremap kj <Esc>


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"	SEARCHING																 "
"																			 "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Starts searching while you type in your search
    set incsearch

" Highlights all search instances
	set hlsearch

" Searches using all lowercase include capitals, but not the other way around
	set ignorecase
	set smartcase


" Autocomplete menus some sort of command
	set wildmode=longest:full
	set wildmenu

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"	HISTORY & UNDO															 "
"																			 "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" tell it to use an undo file
	set undofile
" set a directory to store the undo history
	set undodir=~/.vim/undo-history/

	"Pathogen"
	""""""""""
	execute pathogen#infect()


	"Airline"
	"""""""""
" fix such that airline runs without having to split
	set laststatus=2
	
" turn on pretty arrows
	let g:airline_powerline_fonts = 1


