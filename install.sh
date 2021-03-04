#!/bin/bash
# Links everything in home/ to ~/, does sanity checks.
# By Simon Eskildsen (github.com/Sirupsen)

function symlink {
  ln -nsf $1 $2
}

for file in home/.[^.]*; do
  path="$(pwd)/$file"
  base=$(basename $file)
  target="$HOME/$(basename $file)"

  if [[ -h $target && ($(readlink $target) == $path)]]; then
    echo -e "\x1B[90m~/$base is symlinked to your dotfiles.\x1B[39m"
  elif [[ -f $target && $(md5sum $path) == $(md5sum $target) ]]; then
    echo -e "\x1B[32m~/$base exists and was identical to your dotfile.  Overriding with symlink.\x1B[39m"
    symlink $path $target
  elif [[ -a $target ]]; then
    read -p "\x1B[33m~/$base exists and differs from your dotfile. Override?  [yn]\x1B[39m" -n 1

    if [[ $REPLY =~ [yY]* ]]; then
      symlink $path $target
    fi
  else
    echo -e "\x1B[32m~/$base does not exist. Symlinking to dotfile.\x1B[39m"
    symlink $path $target
  fi
done

# source tmux
tmux source-file ~/.tmux.conf

# install ripgrep
if ! command -v rg &> /dev/null; then
  sudo apt-get install -y ripgrep
fi


# install vim plugins
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
      https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

vim +PlugInstall +qall
