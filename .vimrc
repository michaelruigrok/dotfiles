
" only uses file for vim, not vi. This removes any clashes
	set nocompatible

" reduces tab indenting to 4 spaces, as per the python standard. 
	set shiftwidth=4
	set tabstop=4

" turns on highlighting and colourising of programming code
	syntax on

" makes it automatically indent in specific cases, such as 
" when adding a curly bracket ({)
	set smartindent

" Minimal number of screen lines to keep above and below the cursor.
	set scrolloff=999

" Use UTF-8
	set encoding=utf-8

" binds Alt + Shift + G to show line numbers (in theory)
	map <A-G> :set nu!<CR>

	""SEARCHING""

" Starts searching while you type in your search
    set incsearch
        
" Searches using all lowercase include capitals, but not the other way around
	set ignorecase
	set smartcase


	""EXPERIMENTAL - RESEARCH LATER""
	
" Autocomplete menus some sort of command
	" set wildmenu
	" wildmode=list:longest,full

	 
