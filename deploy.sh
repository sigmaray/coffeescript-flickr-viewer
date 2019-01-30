#!/bin/bash -v

middleman build
cp $HOME/projects/coffeescript-flickr-viewer/build/* -rf $HOME/projects/coffeescript-flickr-viewer-demo/
cd $HOME/projects/coffeescript-flickr-viewer-demo/
git add .
git commit -m "New version"
git checkout -b gh-pages
git push origin gh-pages
cd $HOME/coffeescript-flickr-viewer
