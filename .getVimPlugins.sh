#!/bin/bash

# get_plugin git-maintainer git-repo
get_plugin() {
	dir=~/.vim/bundle
	loc="git://github.com/$1/$2.git"
	git clone "$loc" "$dir/$2" ||
	( cd "$dir/$2" && git pull "$loc" )
	echo "----------------------------------------------------------------------"
}

#get pathogen
mkdir -p ~/.vim/autoload ~/.vim/bundle && {
curl -LSso ~/.vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim || \
wget -O ~/.vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim
}

(exit $?) || exit 1

# Remove vim-sleuth
rm -rf ~/.vim/bundle/vim-sleuth/
# Remove vim-airline
rm -rf ~/.vim/bundle/vim-airline/

#get other plugins
get_plugin tpope vim-repeat # support to repeat custom mappings
get_plugin mattn emmet-vim # type in css selectors, out comes fully formed HTML
get_plugin roryokane detectindent # command to guess the correct indentation settings
get_plugin tpope vim-dispatch

# UI/Syntax
get_plugin rafi awesome-vim-colorschemes # A Whole heap of colourschemes
get_plugin itchyny lightline.vim # Make the bottom line all pretty
get_plugin ap vim-css-color # preview the colours of CSS with highlights
get_plugin sgur vim-editorconfig

get_plugin vim-scripts screenplay # For writing scripts, of the film variety
get_plugin editorconfig editorconfig-vim

# Utilities
get_plugin AndrewRadev linediff.vim # Diff only portions of a file

# Motions/Mappings
get_plugin sickill vim-pasta # p/P paste with appropriate indentation
get_plugin easymotion vim-easymotion # extend f/F and t/T with an interactive multi-jump select
get_plugin tpope vim-surround # operate on surrounding brackets/tags
get_plugin tpope vim-commentary # `gc` verb un/comments
get_plugin vim-scripts paredit.vim # lisp list maps. See https://gist.github.com/nblumoe/5450099 for usage notes
get_plugin tpope vim-unimpaired # collection of mappings using ] and [

# Language support 
get_plugin neoclide coc.nvim # Language server support
get_plugin othree html5.vim
get_plugin keith swift.vim
get_plugin peitalin vim-jsx-typescript

echo "----------------------------------------------------------------------"
