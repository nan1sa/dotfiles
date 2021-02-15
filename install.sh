#!/usr/bin/env sh

set -eu

cd

mkdir ~/.ssh/
echo -e "Host github.com\n\tStrictHostKeyChecking no\n" > ~/.ssh/config

git init
git remote add origin git@github.com:nan1sa/dotfiles.git
git fetch origin master
git reset --hard origin/master
echo '*' > .git/info/exclude

git clone https://aur.archlinux.org/yay-bin.git
cd yay-bin
makepkg -si --noconfirm
cd ../
rm -rf yay-bin

curl https://sh.rustup.rs -sSf | sh
git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch v0.8.0
