
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
	set history=700

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
"	if has('mouse')
"		  set mouse=a
"	  endif

" Disable beeping
	set noeb vb t_vb=
	au GUIEnter * set vb t_vb=

" binds Alt + Shift + G to show line numbers 
	map <A-G> :set nu!<CR>

" binds space to open and close folds
	map <space> za
	
" returns you to normal mode when you press 'j'  and 'k' at the same time
	inoremap jk <Esc>
	inoremap kj <Esc>

" And if you're on a machine that Caps lock isn't escape, and you press it
"  before hand, accidently:
	inoremap JK <Esc><

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"	ABBREVIATIONS AND COMMANDS												 "
"																			 "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
iabbrev myCopyright 
		\#Copyright (C) 2015 crayonsmelting - protected under Australian and International Copyright law 
	\<CR>#crayonsmelting can be found at http://www.github.com/crayonsmelting/ or at crayons.melting@gmail.com 
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

iabbrev cssLink <link rel='stylesheet' type='text/css' href='style.css'/>

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
	noremap <C-s> :w<CR>

" :C clears search
	command C let @/ = ""
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

	""EXPERIMENTAL - RESEARCH LATER""
	
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
