#!/usr/bin/env sh

set -eu

cd

git init
git remote add origin https://github.com/nan1sa/dotfiles.git
git fetch origin master
git reset --hard origin/master
echo '*' > .git/info/exclude
git remote remove origin
git remote add origin git@github.com:nan1sa/dotfiles.git

git clone https://aur.archlinux.org/yay-bin.git
cd yay-bin
makepkg -si --noconfirm
cd ../
rm -rf yay-bin

yay -S $(cat .config/dotfiles/packages-archlinux.txt) --noconfirm

sh <(curl https://sh.rustup.rs -sSf) -y
git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch v0.8.0
