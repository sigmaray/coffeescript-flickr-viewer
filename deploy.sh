#!/bin/bash -v

cd $HOME/projects/jezz
middleman build
cp $HOME/projects/jezz/build/* -rf $HOME/projects/jezz-github-pages/
cd $HOME/projects/jezz-github-pages/
git add .
git commit -m "New version" 
git push origin gh-pages
cd $HOME/projects/jezz
