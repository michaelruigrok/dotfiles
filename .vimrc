" TODO: if vim has arguments (like a file), don't run sessionfile
" TODO: change any short version of command names to long versions
" TODO: put all autocmd groupings into an augroup
" TODO: consider splitting things up into plugins, ftplugin, etc

	" Initial startup "
	"""""""""""""""""""
" If running on Windows, use .vim directory instead of 'vimfiles'
	let s:MSWindows = has('win95') + has('win16') + has('win32') + has('win64')
	if s:MSWindows
		let $VIMHOME=$HOME."\\.vim"
		set runtimepath=$HOME/.vim,$VIMRUNTIME,$VIM/vimfiles/after,$VIM/.vim/after
	endif

	"  GUI SETTINGS  "
	""""""""""""""""""

if has ('gui_running')

" Boot up the current saved session
	try
		source ~/.vim/session
	catch E484
		" File does not exist error
	endtry

	" Select a font based on system
	" Courier New will be replacede when I _actually_ use that system
	if has("gui_gtk2") || has("gui_gtk3")
		set guifont=Anonymous\ Pro\ For\ Powerline\ 11\\,Source\ Code\ Pro\ 10\\,Monospace
	elseif s:MSWindows
		set guifont=Consolas
	elseif has("gui_photon")
		set guifont=Courier\ New:s11
	elseif has("gui_kde")
		set guifont=Courier\ New/11/-1/5/50/0/0/0/1/0
	elseif has("x11")
		set guifont=-*-courier-medium-r-normal-*-*-180-*-*-m-*-*
	else
		set guifont=Courier_New:h11:cDEFAULT
	endif

endif

" For when vim is embedded in eclipse using eclim:
if exists('g:vimplugin_running')

	set guioptions-=m " turn off menu bar
	set guioptions-=T " turn off toolbar
	let g:EclimCompletionMethod = 'omnifunc'

endif


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"	GENERAL SETTINGS														 "
"																			 "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

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
	command! W w !sudo tee % > /dev/null

" autocorrect waa to wa, a typo which I frequently make
	cabbrev waa <c-r>=(getcmdtype()==':' && getcmdpos()==1 ? 'wa' : 'waa')<CR>
	cabbrev aw <c-r>=(getcmdtype()==':' && getcmdpos()==1 ? 'wa' : 'waa')<CR>

" when a vim file is edited externally, an open version changes with the edit
"  possibly only works while you have not edited your copy
	set autoread

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"	VIM APPEARANCE
"
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" colorscheme to desert
	colorscheme desert

" show relative numbering
	set relativenumber
	set numberwidth=2

" Use UTF-8
	set encoding=utf-8

" turns on highlighting and colourising of programming code
	syntax on

" reduces tab indenting to 4 spaces
" note that tabs are still tabs, not spaces
	set shiftwidth=4
	set tabstop=4

" reduce tabs to 2 spaces in xml or similar
	autocmd FileType xml setlocal shiftwidth=2
	autocmd FileType xml setlocal tabstop=2
	autocmd FileType html setlocal shiftwidth=2
	autocmd FileType html setlocal tabstop=2
	autocmd FileType vue setlocal shiftwidth=2
	autocmd FileType vue setlocal tabstop=2

" text files may not extend further than 78 characters horizonally
	autocmd FileType text setlocal textwidth=78
	autocmd FileType markdown setlocal textwidth=78
	autocmd FileType tex setlocal textwidth=90 " Except LaTeX, because of weird indents
	autocmd FileType python setlocal textwidth=80

" get good working dotpoints
	autocmd FileType text,markdown setlocal formatoptions=ctnqro
	autocmd FileType text,markdown setlocal comments=n:>,b:*,b:+,b:-

" makes it automatically indent in specific cases, such as
"  when adding a curly bracket ({)
	set smartindent

" Minimal number of screen lines to keep above and below the cursor.
	set scrolloff=7

" When splitting windows vertically, open the new window in the right side
	set splitright

" In many terminal emulators the mouse works just fine, thus enable it.
	if has('mouse')
		set mouse=a
		endif

" Disable beeping
	set noeb vb t_vb=
	autocmd GUIEnter * set vb t_vb=

" Spell checker for Australian English, but not in helpfiles
	autocmd FileType text setlocal spell spelllang=en_au
	autocmd Syntax help setlocal nospell

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"	ABBREVIATIONS AND MAPPINGS												 "
"																			 "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

iabbrev myCopyrightHash 
		\#Copyright (C) 2015 Michael Ruigrok - protected under Australian and International Copyright law
	\<CR>#Michael Ruigrok can be found at http://www.github.com/michaelruigrok/
	\<CR>#or at ruigrok.michael@gmail.com 
	\<CR>#Licence found within licence.txt 
	\<CR>############################################ 
	\<CR> 
	\<CR> 
	\<CR> 
	\<CR> 

iabbrev myCopyrightSlash 
		\/* Copyright (C) 2015 Michael Ruigrok - protected under Australian and International Copyright law
	\<CR>Michael Ruigrok can be found at http://www.github.com/michaelruigrok/
	\<CR>or at michael.ruigrok@gmail.com 
	\<CR>Licence found within licence.txt 
	\<CR>*/ 
	\<CR> 

iabbrev shortCopy COPYRIGHT (C) 2015 Michael Ruigrok. See licence.txt.

iabbrev addBreak 
	\<CR>-------------------------------------------------------------------
	\-------------
	\<CR>  


	" HTML SHORTCUTS "
	""""""""""""""""""

" $L-l-t surround visually selected paragraphs with <p> tags
autocmd FileType html vnoremap <leader>lt :s/^\(\w.*\)$/<p>\1<\/p>/<CR>

" This is kind of redundant since I have skeleton files, but I'm leaving it in
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

iabbrev jqueryLink <script type="text/javascript"
	\<CR>src="https://code.jquery.com/jquery-3.2.1.min.js"
	\<CR>integrity="sha256-hwg4gsxgFZhOsEEamdOYGBf13FyQuiTwlAQgxVSNgt4="
	\<CR>crossorigin="anonymous"></script>

" This is supposed to add a closing tag to an element automatically, after you
" type in "<//"
	inoremap <lt>// </<C-X><C-O>


	" C abreiviations "
iabbrev cTemp #include <stdio.h>
	\<CR>#include <stdbool.h>
	\<CR>#include <stdlib.h>
	\<CR>
	\<CR>int main(int argc, char** argv) {
	\<CR>
	\<CR>return 0;
	\<CR>}

iabbrev cFileOpen #include <sys/types.h>
	\<CR>#include <sys/stat.h>
	\<CR>#include <fcntl.h>

iabbrev cThreads #include <pthread.h>
	\<CR>#include <semaphore.h>

	" LEADER "
	""""""""""

" With a map leader it's possible to do extra key combinations
"  like <leader>w saves the current file
	let mapleader = ","
	let g:mapleader = ","

" leader-p runs the the previous colon command 
	nnoremap <leader>p @:

" leader-n toggles between relative and absolute numbering
	nnoremap <leader>n :call NumberToggle()<cr>
	
	" required function
		function! NumberToggle()
			if(&relativenumber == 1)
				set relativenumber!
				set number 
			else
				set relativenumber
				set number!
			endif
		endfunc

" leader-b is the black hole register (deleting or changing without saving for
"  pasting)
	nnoremap <leader>b "_

" I wonder what control-S should do?
	nnoremap <c-s> <Esc>:w<CR>
	inoremap <c-s> <Esc>:w<CR>

" Make Y do the same thing as ^ (because ^ is too far to reach)
	nnoremap Y ^

" leader-s saves the session, leader-S saves session and buffers
	noremap <leader>s :mks! ~/.vim/session<CR>
	noremap <leader>S :mks! ~/.vim/session<CR>:wa<CR>

" leader-L saves the session, leader-S saves session and buffers
" note the capital, different from leading into language specific binds
	noremap <leader>L :source ~/.vim/session<CR>

" :C or leader-c clears search, colour column, and reloads syntax
	command! C let @/ = ""
	nnoremap <leader>c :let @/ = ""<CR>:set cc=0<CR>:syntax sync fromstart<CR>

" Rather than deleting _all_ my stuff, Ctrl-w Ctrl-w changes window (like in
" normal mode)
	imap <C-w><C-w> <esc><C-w><C-w>

" binds Alt + Shift + G to show/hide line numbers
	map <leader>g :set nu!<CR>

" Okay, I'm going to try and set up a command that can sort things.
" Say you have a list of things that you want to manually put into categories,
" You can use this command to make a binding which will help you.
" Set up a heading for a category you want to sort the things into.
" Enter the command, with the line number of that heading as the argument.
" You can now press <leader-t> to move things from the unsorted list into that
" category.
" For now, it will put them up the top, which will reverse the order that you
" put them in
" In the future, I might make it so it keeps the old order
" I might also set it up so you can press <leader><number> to
" iterate with multiple categories at once.
"
command! -nargs=1 SortHelper let sortHelper=<args> | nnoremap <leader>t :call ManSort()<CR>

" Maintain order
function! ManSort()
	normal jmtk
	execute "m " . g:sortHelper
	normal 't

	" increment variable
	let g:sortHelper = g:sortHelper + 1
	echo g:sortHelper
endfunction

" multiple sortings at once
"function! SortHelper(
" for each
" Each argument must be bigger than the last
" So the position in array corresponds with position in the file
" We increment not just the list, but all the lists in the array that follow
" it

function! AddRunner(lang)
	autocmd FileType a:lang nnoremap <buffer> <leader>m :w<CR>:!a:lang %<CR>
endfunction

" binds space to open and close folds
	map <space> za

" with vim-surround, leader comments out the surrounded word
	" First name leader-C to do nothing in particular
	nnoremap <leader>C <NOP>
	autocmd FileType javascript map <buffer> <leader>Cw ysiW*ysiW/
	autocmd FileType css map <buffer> <leader>Cw ysiW*ysiW/

" and leader-b for lines:
	autocmd FileType javacript map <buffer> <leader>b I//<esc>
	autocmd FileType css map <buffer> <leader>b I/*<esc>A*/<esc>

" returns you to normal mode when you press 'j'  and 'k' at the same time
	inoremap jk <Esc>
	inoremap kj <Esc>

" MakeTags will make your ctags
command! MakeTags !ctags -R .

" repeat command once for each line of a visual selection
vnoremap . :normal .<CR>

" for various scripting languages, <leader>m runs open file
	function! AddRunner(lang)
		autocmd FileType a:lang nnoremap <buffer> <leader>m :w<CR>:!a:lang %<CR>
	endfunction
	call AddRunner("python")
	call AddRunner("sh")
	call AddRunner("ruby")
	call AddRunner("perl")
	call AddRunner("perl6")
	call AddRunner("lua")
	call AddRunner("php")
	autocmd FileType awk nnoremap <buffer> <leader>m :w<CR>:!awk -f %<CR>
	autocmd FileType sed nnoremap <buffer> <leader>m :w<CR>:!sed -f %<CR>
	autocmd FileType cs nnoremap <buffer> <leader>m :w<CR>:!mono-csc %<CR>

" for LaTeX documents, compile as a pdf
	autocmd FileType tex nnoremap <buffer> <leader>m :w<CR>:!pdflatex %<CR>

" for this vimrc, <leader>m reloads its contents
	autocmd FileType vim nnoremap <buffer> <leader>m :so %<CR>

" for c/c++, <leader>m compiles a single file and then runs the binary
	function! CompileC(...)
		let newfile = split(expand('%:p'),"\\.")[0]
		let argc = 1
		let argv = ''
		for arg in a:000
			let argv = argv . ' ' . arg
			argc += 1
		endfor
		if filereadable(expand('%:p:h') . '/Makefile')
			make -j 8
		else
			if (&ft=='c')
				execute '!clear; gcc -std=gnu99 -pedantic -Wall ' . expand('%:p') . ' -o ' . newfile . ' && ' newfile . ' ' . argv
			else 
				execute '!clear; g++ -pedantic -Wall ' . expand('%:p') . ' -o ' . newfile . ' && ' newfile . ' ' . argv
			endif
		endif
	endfunction

	autocmd FileType c nnoremap <buffer> <leader>m :call CompileC()<CR>
	autocmd FileType cpp nnoremap <buffer> <leader>m :call CompileC()<CR>
	autocmd FileType c++ nnoremap <buffer> <leader>m :call CompileC()<CR>

" for Java, <leader>m compiles the file and then runs the binary
	function! CompileJava()
		if filereadable("build.gradle")
			"stub for gradle building
			echo "Is a Gradle Project"
			!gradle build run
		elseif exists('g:vimplugin_running')
			Java
		else
			let cdir = getcwd()
			let jdir = expand('%:p:h')
			execute 'silent cd ' . jdir
			execute 'silent cd ..'
			let jfile = split(expand('%'),"\\.")[0]
			execute '!clear; javac "' . expand('%') . '" && java "' . jfile . '"'
			execute 'cd ' . cdir
		endif
	endfunction

	autocmd FileType java nnoremap <buffer> <leader>m :call CompileJava()<CR>


	" LANGUAGE SPECIFIC COMMANDS"
	"""""""""""""""""""""""""""""
	
" Leader-l ($L for short) is a leader for language-specific commands:

	" Eclim "
		if exists('g:vimplugin_running')

			" TODO: Set these up also for javascript, php search, all that 
			" g[ is remapped to work with eclim's JavaSearch
			nnoremap g[ :JavaSearchContext<cr>

			" g{ performs a non-context sensitive search
			nnoremap g{ :JavaSearch<cr>

			" $L-i updates imports as required
			nnoremap <leader>li :JavaImportOrganize<cr>

			" $L-c uses Java's quick fix to correct error under the cursor
			nnoremap <leader>lc :call JavaCorrect()<cr>

			function! JavaCorrect()
				let olda = @a
				redir @a
				JavaCorrect
				redir END
				if @a =~ 'No Error Found'
					ll
					JavaCorrect
				endif
				let @a = olda
			endfunc

			" $L-b toggles java debugger breakpoint
			nnoremap <leader>lb :JavaDebugBreakpointToggle!<cr>

		" leader-l-d prefix for other debugger commands:
			
			" $L-d-l lists all breakpoints of current file
			nnoremap <leader>ldl :JavaDebugBreakpointsList<cr>

			" $L-d-L lists all breakpoints, including dependent files
			nnoremap <leader>ldL :JavaDebugBreakpointsList!<cr>

			" $L-d-r lists all breakpoints, including dependent files
			nnoremap <leader>ldr :JavaDebugBreakpointRemove<cr>
			
			" $L-d-R lists all breakpoints, including dependent files
			nnoremap <leader>ldR :JavaDebugBreakpointRemove<cr>

		endif



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


" In command mode, firs tab fills in the longest common match
"  Second tab uses the entirety of the first match
	set wildmode=list:longest,full
	set wildmenu

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"	HISTORY & UNDO															 "
"																			 "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" tell it to use an undo file
	set undofile
" set a directory to store the undo history
	set undodir=~/.vim/undo-history/

" put all swap files in ~/.vim
	set directory^=~/.vim/swapfiles

	""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
	"	Skeletons and Templates													 "
	"																			 "
	""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

augroup templates
	autocmd!

	autocmd BufNewFile *.c 0r ~/.vim/skeleton/c | normal 4j
	autocmd BufNewFile *.h 0r ~/.vim/skeleton/h
	autocmd BufNewFile *.l 0r ~/.vim/skeleton/l

	autocmd BufNewFile *.java 0r ~/.vim/skeleton/java
	autocmd BufNewFile *.html 0r ~/.vim/skeleton/html
	autocmd BufNewFile Makefile 0r ~/.vim/skeleton/Makefile

	" expand filenames with <@%>, <@%:p>, <@%:t:r:p:h>, et cetera
	autocmd BufNewFile * silent! %s/<@\(%.\{-}\)>/\=expand(submatch(1))/
	" use vim expressions in templates with <\=expression>
	autocmd BufNewFile * silent! %s/<\\=\(.\{-}\)>/\=eval(submatch(1))/

	" move the cursor to preferable positions
	autocmd BufNewFile *.c silent 8 | normal $
	autocmd BufNewFile *.h 4
	autocmd BufNewFile *.html silent 5 | normal f<;

augroup END

	"Pathogen"
	""""""""""
	execute pathogen#infect()


	"Airline"
	"""""""""

	if exists(':AirlineRefresh')

" fix such that airline runs without having to split
	set laststatus=2
	
" turn on pretty arrows
	let g:airline_powerline_fonts = 1
	let g:airline#extensions#whitespace#checks = [ 'indent', 'long' ]

	endif


