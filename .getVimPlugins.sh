#!/bin/bash
cd .vim/bundle
git clone git://github.com/tpope/vim-sleuth.git || 
( cd vim-sleuth && git pull git://github.com/tpope/vim-sleuth.git ; cd ~/.vim/bundle )
echo "----------------------------------------------------------------------"

git clone git://github.com/othree/html5.vim.git || 
( cd html5.vim && git pull git://github.com/othree/html5.vim.git ; cd ~/.vim/bundle )
echo "----------------------------------------------------------------------"

git clone git://github.com/vim-airline/vim-airline.git || 
( cd vim-airline && git pull git://github.com/vim-airline/vim-airline.git ; cd ~/.vim/bundle )
echo "----------------------------------------------------------------------"

git clone git://github.com/easymotion/vim-easymotion.git || 
( cd vim-easymotion && git pull git://github.com/easymotion/vim-easymotion.git ; cd ~/.vim/bundle )
echo "----------------------------------------------------------------------"

git clone git://github.com/tpope/vim-surround.git || 
( cd vim-surround && git pull git://github.com/tpope/vim-surround.git ; cd ~/.vim/bundle ) 
echo "----------------------------------------------------------------------"

git clone git://github.com/tpope/vim-repeat.git || 
( cd vim-repeat git://github.com/tpope/vim-repeat.git ; git pull; cd ~/.vim/bundle )
echo "----------------------------------------------------------------------"
echo "----------------------------------------------------------------------"
