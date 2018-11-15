#!/bin/bash

hugo

git config --global user.email "travis@travis-ci.org"
git config --global user.name "Travis CI"

git add .
git commit -m "Travis build: $TRAVIS_BUILD_NUMBER"
git remote add origin https://${GH_TOKEN}@github.com/jreisinger/notes.git
git push origin master
