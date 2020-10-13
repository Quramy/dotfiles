#!/bin/bash

dotfiles=".vimrc .npmrc .zshrc .tmux.conf .gitignore_global .vimspector.json"

for f in $dotfiles; do
  if [ ! -h "$HOME/$f" ]; then
    ln -s "$f" "$HOME"
  fi
done
