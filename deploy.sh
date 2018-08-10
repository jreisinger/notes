#!/bin/bash

hugo
git add .
git commit -m "deploy new stuff"
git push
