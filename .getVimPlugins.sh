#!/bin/bash

# get_plugin git-maintainer git-repo
get_plugin() {
	dir=~/.vim/bundle
	loc="https://github.com/$1/$2.git"
	git clone "$loc" "$dir/$2" ||
	( cd "$dir/$2" && git pull "$loc" )
	echo "----------------------------------------------------------------------"
}

remove_plugins() {
	dir=~/.vim/bundle/
	for file in "$@"; do
		rm -rf "$dir/$file"
	done
}

#get pathogen
mkdir -p ~/.vim/autoload ~/.vim/bundle && {
curl -LSso ~/.vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim || \
wget -O ~/.vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim
}

(exit $?) || exit 1

remove_plugins vim-sleuth vim-airline paredit.vim vim-editorconfig

#get other plugins
get_plugin xolox vim-misc
get_plugin tpope vim-repeat # support to repeat custom mappings
get_plugin mattn emmet-vim # type in css selectors, out comes fully formed HTML
get_plugin roryokane detectindent # command to guess the correct indentation settings
get_plugin sickill vim-pasta # p/P paste with appropriate indentation
get_plugin tpope vim-dispatch

# UI/Syntax
get_plugin rafi awesome-vim-colorschemes # A Whole heap of colourschemes
get_plugin itchyny lightline.vim # Make the bottom line all pretty
get_plugin ap vim-css-color # preview the colours of CSS with highlights

get_plugin vim-scripts screenplay # For writing scripts, of the film variety
get_plugin editorconfig editorconfig-vim

# Utilities
get_plugin AndrewRadev linediff.vim # Diff only portions of a file
get_plugin xolox vim-notes
get_plugin mbbill undotree

# Motions/Mappings
get_plugin easymotion vim-easymotion # extend f/F and t/T with an interactive multi-jump select
get_plugin tpope vim-rsi # readline mappings in insert mode
get_plugin tpope vim-surround # operate on surrounding brackets/tags
get_plugin tpope vim-commentary # `gc` verb un/comments
get_plugin tpope vim-unimpaired # collection of mappings using ] and [

# Language support 
get_plugin sheerun vim-polyglot
get_plugin neoclide coc.nvim # Language server support
get_plugin othree html5.vim
get_plugin keith swift.vim
get_plugin peitalin vim-jsx-typescript
get_plugin tpope vim-fireplace # clojure repl integration
get_plugin guns vim-sexp # lisp S-expression handling
get_plugin tpope vim-sexp-mappings-for-regular-people # lisp S-expression handling
get_plugin andrewstuart vim-kubernetes

echo "----------------------------------------------------------------------"
