" TODO: if vim has arguments (like a file), don't run sessionfile
" TODO: change any short version of command names to long versions
" TODO: consider splitting things up into plugins, ftplugin, etc
" TODO: add insertDate and insertTime abbreviations
" TODO: create a command argument envar when running the given code.
	" potentially add envar for post-run test commands (e.g. to test output)

	" Initial startup "
	"""""""""""""""""""
" If running on Windows, use .vim directory instead of 'vimfiles'
	let s:MSWindows = has('win95') + has('win16') + has('win32') + has('win64')
	if s:MSWindows
		let $VIMHOME=$HOME."\\.vim"
		set runtimepath=$HOME/.vim,$VIMRUNTIME,$VIM/vimfiles/after,$VIM/.vim/after
	endif

	"Pathogen"
	""""""""""
	execute pathogen#infect()

	"  GUI SETTINGS  "
	""""""""""""""""""

if has ('gui_running')

" Boot up the current saved session
	if ! &diff
		try
			source ~/.vim/session
		catch E484
			" File does not exist error
		endtry
	endif

	" Select a font based on system
	" Courier New will be replaced when I _actually_ use that system
	if has("gui_gtk2") || has("gui_gtk3")
		set guifont=Anonymous\ Pro\ For\ Powerline\ 11\\,Source\ Code\ Pro\ 10\\,Courier\ New\ 12,Monospace\ 12
	elseif s:MSWindows
		set guifont=Consolas
	elseif has("gui_photon")
		set guifont=Courier\ New:s12
	elseif has("gui_kde")
		set guifont=Courier\ New/12/-1/5/50/0/0/0/1/0
	elseif has("x11")
		set guifont=-*-courier-medium-r-normal-*-*-180-*-*-m-*-*
	else
		set guifont=Courier_New:h12:cDEFAULT
	endif

endif

" For when vim is embedded in eclipse using eclim:
if exists('g:vimplugin_running')

	set guioptions-=m " turn off menu bar
	set guioptions-=T " turn off toolbar
	let g:EclimCompletionMethod = 'omnifunc'

endif


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"   GENERAL SETTINGS                                                         "
"                                                                            "
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
"    VIM APPEARANCE
"
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

let my_colorschemes = [ 'one', 'PaperColor', 'afterglow', 'materialbox', 'meta5', 'solarized8_flat', 'rakr', 'ayu', 'challenger_deep', 'deep-space', 'happy_hacking', 'hybrid', 'gruvbox', 'scheakur', 'sonokai', 'space-vim-dark']
try 
	execute 'colorscheme' my_colorschemes[localtime() % (len(my_colorschemes) - 1)]
catch
	colorscheme desert
endtry
set bg=dark

if ! has ('gui_running')
	" TODO: set some colourschemes
	let my_colorschemes = [ 'gotham256', 'OceanicNext', 'rdark-terminal2', 'sierra', 'spacecamp', 'twilight256']
	let only_gui = [ 'flattened_dark' ] 
	let daytime_colorschemes = ['solarized8']
endif

" show relative numbering
	set relativenumber
	set numberwidth=2

" show relative numbering in netrw
	let g:netrw_bufsettings = 'noma nomod nu rnu nobl nowrap ro'

" Use UTF-8
	set encoding=utf-8

" turns on highlighting and colourising of programming code
	syntax on

" reduces tab indenting to 4 spaces
" note that tabs are still tabs, not spaces
	set shiftwidth=4
	set tabstop=4

augroup tablength
	autocmd!
" reduce tabs to 2 spaces in xml or similar
	autocmd BufRead,BufNewFile *.jelly,*.vue setlocal filetype=html
	autocmd FileType xml,html,vue,tex setlocal shiftwidth=2
	autocmd FileType xml,html,vue,tex setlocal tabstop=2
	autocmd FileType tex setlocal expandtab

" Vim usually does special indentation for lisps. To help facilitate this,
" a common standard of 2 spaces is used for indentation.
	autocmd FileType lisp,clojure setlocal shiftwidth=2
	autocmd FileType lisp,clojure setlocal tabstop=2
	autocmd FileType lisp,clojure setlocal expandtab
augroup END

" text files may not extend further than 78 characters horizonally
augroup textwidth
	autocmd!
	autocmd FileType text,markdown setlocal textwidth=78
	autocmd FileType tex setlocal textwidth=90 " Except LaTeX, because of weird indents
	autocmd FileType python setlocal textwidth=80
augroup END

" get good working dotpoints
augroup dotpoints
	autocmd!
	autocmd FileType text,markdown setlocal formatoptions=ctnqro
	autocmd FileType text,markdown setlocal comments=n:>,b:*,b:+,b:-
augroup END

" makes it automatically indent in specific cases, such as
"  when adding a curly bracket ({)
	set smartindent

" Minimal number of screen lines to keep above and below the cursor.
	set scrolloff=7

" When splitting windows vertically, open the new window in the right side
	set splitright
	let g:netrw_altv = 1 " also split netrw right

" In many terminal emulators the mouse works just fine, thus enable it.
	if has('mouse')
		set mouse=a
		endif

" Disable beeping
augroup nobeep
	autocmd!
	set noeb vb t_vb=
	autocmd GUIEnter * set vb t_vb=
augroup END

" Spell checker for Australian English, but not in helpfiles
" augroup spelling
" 	autocmd!
" 	autocmd FileType text setlocal spell spelllang=en_au
" 	autocmd Syntax help setlocal nospell
" augroup END

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"    GENERAL COMMANDS AND HELPERS
"                                                                            "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" TODO: use autocmd to parse .gitignore in dir


command! -nargs=1  Grep grep -r
 	\ --exclude=tags 
	\ --exclude=.git
	\ --exclude-dir=node_modules
	\ --exclude-dir=bin
	\ --exclude-dir=.expo
	\ --exclude-dir=obj
	\ <f-args> .

command! -nargs=1 Vimgrep vimgrep --exclude=tags <f-args> .
vnoremap g/ y:Grep <c-r>"<CR>


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"   ABBREVIATIONS AND MAPPINGS                                               "
"                                                                            "
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

	" Bash Abbrievs "
	""""""""""""""""""
" TODO: set this up to use getopt or getopts. But keep it simple!
"  preferably _just_ as a way to move args to the start of a command
iabbrev bashArgs while [ $# -ne 0 ]; do
	\<CR>case "$1" in
		\<CR>-f \| --force ) FORCE=true
			\<CR>shift
			\<CR>;;
		\<CR>-n \| --name ) NAME="$2"
			\<CR>shift
			\<CR>shift
			\<CR>;;
		\<CR>-- )
			\<CR>shift
			\<CR>break
			\<CR>;;
		\<CR>* ) break
			\<CR>;;
	\<CR>esac
\<CR>done

iabbrev echo2 echo >&2


	" HTML SHORTCUTS "
	""""""""""""""""""

augroup html-helpers
	autocmd!

" $L-l-t surround visually selected paragraphs with <p> tags
	autocmd FileType html vnoremap <leader>lt :s/^\(\w.*\)$/<p>\1<\/p>/<CR>

augroup END

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

iabbrev jsLink <script type="text/javascript" src="js/main.js" async="async"></script>

iabbrev jsLinkModule <script type="module" src="js/main.js" async="async"></script>

iabbrev jsModule 
	\var module = (function() {
	\<CR>'use strict';
	\<CR>
	\<CR>return {
	\<CR>};
	\<CR>
	\<CR>})();

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

iabbrev forloop for (int i = 0; i < ; i++) {<esc>7hi

	" LEADER "
	""""""""""

" With a map leader it's possible to do extra key combinations
"  like <leader>w saves the current file
	let mapleader = ","
	let g:mapleader = ","

" map , to something else, so I can still use it.
" I would've just mapped leader to space, but I'm too used to it now v_v
	nnoremap <space> ,

" leader-p runs the the previous colon command 
	nnoremap <leader>p @:

" leader-P changes the paste mode
	nnoremap <leader>P :set paste!<CR>

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
	nnoremap <leader>c :let @/ = ""<CR>:set cc=0<CR>:syntax sync fromstart<CR>:set nopaste<CR>

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

" returns you to normal mode when you press 'j'  and 'k' at the same time
	inoremap jk <Esc>
	inoremap kj <Esc>

" MakeTags will make your ctags
	command! MakeTags !ctags -R .

" repeat command once for each line of a visual selection
	vnoremap . :normal .<CR>

" Since REPLs are usually super slow,
" Write the given lines to a pipe that a script can
" read and execute in a single REPL instance
" e.g. `tail -f /tmp/$USER/*-REPL.fifo | tee /dev/tty | repl-cli`
	function! WriteToRepl() range
		let address = a:firstline.",".a:lastline

		if (!exists(&filetype))
			let ftype = &filetype
		else
			let ftype = expand("%:e")
		endif

		" /tmp/$USER/$filetype-REPLE.fifo
		execute address . "w>> /tmp/" . $USER . "/" .  ftype . "-REPL.fifo"
	endfunction

	vnoremap <leader>r :'<,'>call WriteToRepl()<CR>
	nnoremap <leader>r :call WriteToRepl()<CR>

augroup runners
	autocmd!

" For various scripting languages, <leader>m runs open file
	" For most languages, we can just exec the file direct, or use
	" the interpreter (using the filetype name)
	" TODO: detect Makefile and actually use make accordingly
	autocmd FileType * execute "setlocal makeprg="
				\. fnameescape('[[ -x % ]] && %:.:h/%:t $* \|\| '.&filetype.' % $*')
	nnoremap <leader>m :w<CR>:exec 'make '.
				\(exists('makeargs') ? makeargs : '')<CR>
	" TODO: try and use vim's smart compiler/running architecture
	"autocmd FileType * compiler &filetype
	autocmd FileType * let b:dispatch = &filetype . ' %'

" In Other cases, the runner syntax differs
	autocmd FileType awk  setlocal makeprg=awk\ -f\ %:.
	autocmd FileType sed  setlocal makeprg=sed\ -f\ %:.
	autocmd FileType cs   setlocal makeprg=mono-csc\ -f\ %:.
	autocmd FileType dot  setlocal makeprg=dot\ -Tx11\ %:.
	autocmd FileType rust let makeargs='build'

" for LaTeX documents, compile as a pdf
	autocmd FileType tex setlocal makepgr=pdflatex\ %:.

" for this vimrc, <leader>m reloads its contents
	autocmd FileType vim setlocal makeprg=
	autocmd FileType vim nnoremap <buffer> <leader>m :source %<CR>

" Terraform validation
	autocmd FileType terraform execute 'setlocal ' . fnameescape(
				\  'efm=%EError: %m,'
				\. '%WWarning: %m,'
				\. '%ISuccess! %m,'
				\. '%C%.%#on %f line %l%.%# in %o:,'
				\. '%C %.%#,'
				\. '%C%m,'
				\. '%C,'
				\. '%-G,'
				\)
	autocmd FileType terraform setlocal makeprg=terraform\ validate\ -no-color

" Raku
	autocmd FileType raku execute 'setlocal '. fnameescape(
				\  'efm=%E%.%#Error while compiling %f (Module),'
				\. '%E%.%#Error while compiling %f,'
				\. '%WWarning: %m,'
				\. '%EAttempt to %m,'
				\. '%C%.%#at %f:%l,'
				\. '%C %#in block %o at %f line %l,'
				\. '%C%p>%.%#,'
				\. '%C %#%m,'
				\. '%C,'
				\. '%-G,'
				\)
	autocmd FileType raku  setlocal makeprg=rakudo\ %

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
			if (&filetype == 'c')
				execute '!clear; gcc -std=gnu99 -pedantic -Wall ' . expand('%:p') . ' -o ' . newfile . ' && ' newfile . ' ' . argv
			else 
				execute '!clear; g++ -pedantic -Wall ' . expand('%:p') . ' -o ' . newfile . ' && ' newfile . ' ' . argv
			endif
		endif
	endfunction

	autocmd FileType c,cpp,c++ nnoremap <buffer> <leader>m :call CompileC()<CR>

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
			silent cd ..
			let jfile = split(expand('%'),"\\.")[0]
			execute '!clear; javac "' . expand('%') . '" && java "' . jfile . '"'
			execute 'cd ' . cdir
		endif
	endfunction

	autocmd FileType java nnoremap <buffer> <leader>m :call CompileJava()<CR>

	function! RunClojure(...)
		write
		if filereadable('project.clj')
			" Probably a Leiningen project, try and use that
			!clear; lein run
		elseif search('defn -main', "w")
			" Has a main function, run that
			let namespace = matchstr(getline(search('(ns')), '(ns \zs\(\w\+\)\ze')
			execute "!clear; clojure -classpath " . expand('%:p:h') . " --main " . namespace
		else
			!clojure %
		endif
	endfunction
	autocmd FileType clojure nnoremap <buffer> <leader>m :call RunClojure()<CR>

augroup END


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

		" Javascript "
		command! PurgeDebuggers !sed -i '/^\s*debugger;\s*$/d' `grep -lr 'debugger;' .`;


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"    SEARCHING                                                               "
"                                                                            "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Starts searching while you type in your search
	set incsearch

" Highlights all search instances
	set hlsearch

" Searches using all lowercase include capitals, but not the other way around
	set ignorecase
	set smartcase

" In command mode, first tab fills in the longest common match
"  Second tab displays list. Two more tabs will iterate over that list.
	set wildmode=longest,list,list,list:full
	set wildmenu

" Ignore certain matches from autocomplete
	set wildignore+=*.o,*.obj
" These patterns will appear last in autocomplete
	set suffixes+=*.pdf

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"   HISTORY & UNDO                                                           "
"                                                                            "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" tell it to use an undo file
	set undofile
" set a directory to store the undo history
	set undodir=~/.vim/undo-history/

" put all swap files in ~/.vim
	set directory^=~/.vim/swapfiles

    """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
    "   Skeletons and Templates                                                  "
    "                                                                            "
    """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

augroup templates
	autocmd!

	autocmd BufNewFile *.c 0r ~/.vim/skeleton/c | normal 4j
	autocmd BufNewFile *.h 0r ~/.vim/skeleton/h
	autocmd BufNewFile *.l 0r ~/.vim/skeleton/l
	autocmd BufNewFile *.tex 0r ~/.vim/skeleton/tex

	autocmd BufNewFile *.java 0r ~/.vim/skeleton/java
	autocmd BufNewFile *.html 0r ~/.vim/skeleton/html
	autocmd BufNewFile Makefile 0r ~/.vim/skeleton/Makefile

	autocmd BufNewFile *_test.c 0r ~/.vim/skeleton/minUnit_test.c | normal 33GdG
	autocmd BufNewFile *cgi.sh 0r ~/.vim/skeleton/cgi.sh | normal G

	" expand filenames with <@%>, <@%:p>, <@%:t:r:p:h>, et cetera
	autocmd BufNewFile * silent! %s/<@\(%.\{-}\)>/\=expand(submatch(1))/
	" use vim expressions in templates with <\=expression>
	autocmd BufNewFile * silent! %s/<\\=\(.\{-}\)>/\=eval(submatch(1))/

	" move the cursor to preferable positions
	autocmd BufNewFile *.c silent 8 | normal $
	autocmd BufNewFile *.h 4
	autocmd BufNewFile *.html silent 5 | normal f<;

augroup END



	"Line Managers"
	"""""""""""""""

" fix such that airline runs without having to split
	set laststatus=2

if exists(':AirlineRefresh')

" turn on pretty arrows
	let g:airline_powerline_fonts = 1
	let g:airline#extensions#whitespace#checks = [ 'indent', 'long' ]

endif

	" CoC Language Server "
	"""""""""""""""""""""""
" TODO: move into an autocmd maybe? It's not like I use these feature that
" frequently

" Some default recommended settings
	set hidden
	"set nobackup
	"set nowritebackup
	"set cmdheight=2
	"set shortmess=2
	set updatetime=1000

" Enable markers on the side
	if has("patch-8.1.1564")
		" Recently vim can merge signcolumn and number column into one
		set signcolumn=number
	else
		set signcolumn=yes
	endif

" Next/previous error/warning/diagnostic
	nmap <silent> [c <Plug>(coc-diagnostic-prev)
	nmap <silent> ]c <Plug>(coc-diagnostic-next)

" Code Navigation
	nmap <silent> <c-]> <Plug>(coc-definition)
	nmap <silent> g] <Plug>(coc-references)
	nmap <silent> gy <Plug>(coc-type-definition)
	nmap <silent> <c-\> <Plug>(coc-implementation)

	nnoremap <silent> gK :call <SID>coc_documentation()<CR>

	function! s:coc_documentation()
		if (index(['vim','help'], &filetype) >= 0)
			execute 'h '.expand('<cword>')
		else
			call CocAction('doHover')
		endif
	endfunction

"" Other stuff:
" CocDiagnostics to get a list of what's wrong
" https://github.com/neoclide/coc.nvim/wiki/Language-servers



	""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
	"	EXPERIMENTS																 "
	"																			 "
	""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Look through all subfolders for files
" Since I usually hang out in ~, this is probably pretty slow
	"set path+=**
	set path+=* " nvm, just try within the next layer.


" also 'b: <literally any substring of a file> is pretty useful!
" ctrl-t, tag stack
"
" GET USED TO USING CTRL-N/P without CTRL-X, DUMMY!
"
" set complete?
"
" ctrl-e to exit completion
"
" set showcmd
" 
" 1<C-V> repeats last visual block
" <C-X><C-V> completes vim commands
" '[ and '] for the boundaries around changed/pasted text
" '< and '> last visual selection
" command mode ctrl+f for command history
" s/match//n count occurrences
