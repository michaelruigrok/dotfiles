#!/bin/bash

# get_plugin git-maintainer git-repo
function get_plugin() {
	git clone "git://github.com/$1/$2.git" || 
	( cd "$2" && git pull "git://github.com/$1/$2.git" ; cd ~/.vim/bundle )
	echo "----------------------------------------------------------------------"
}

#get pathogen
mkdir -p ~/.vim/autoload ~/.vim/bundle && \
curl -LSso ~/.vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim || \
wget -O ~/.vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim
(exit $?) || exit 1

#get other plugins
cd ~/.vim/bundle

get_plugin roryokane detectindent
get_plugin sickill vim-pasta
get_plugin othree html5.vim
get_plugin vim-airline vim-airline
get_plugin easymotion vim-easymotion
get_plugin tpope vim-surround
get_plugin tpope vim-repeat
get_plugin tpope vim-unimpaired
get_plugin vim-scripts screenplay
get_plugin vim-scripts paredit # see https://gist.github.com/nblumoe/5450099 for usage notes
get_plugin mattn emmet-vim

echo "----------------------------------------------------------------------"
