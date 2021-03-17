# alswl's vim configuration #

## About miv ##

miv = vim configuration

forked from [alswl/.oOo.@Github][]

## Usage ##

``` bash
git clone --recursive https://github.com/alswl/miv.git
ln -s $(pwd)/miv/.vim $HOME/
ln -s $(pwd)/miv/.vimrc $HOME/
vim +PlugInstall +qa
```


## Tips

- F1: NerdTree
- F2: Table of Content
- `<leader> m` Mark color
- `<leader> n` Mark remove color
- `<leader> r` Mark reguar
- `g ctrl-]` open ctags list
- `ctags -R --python-kinds -i` skip Python import statement
- `:DrawIt` DrawIt mode
- `<leader> tm` Table Mode
- `<leader>nr` selected visual region edit
- `:NR` selected line edit
- `:NRV` selected region edit
- `:NW` current window region edit
- `vipga=` align a paragraph with `=`
- `gaip=` align a paragraph with `=`
- `vipga➡️=` align a paragraph with `=`, right margin
- into view mode, `ga:` align block with `:`, right margin
- `\sf` File path convert

## Install with nvim

```
mkdir -p ~/.config/nvim
cat <<EOF > ~/.config/nvim/init.vim
set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath = &runtimepath
source ~/.vimrc
EOF
ln -s ~/.vim/UltiSnips ~/.config/nvim/
```



[alswl/.oOo.@Github]: https://github.com/alswl/.oOo.



