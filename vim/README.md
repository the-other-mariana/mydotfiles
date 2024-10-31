# Vim editor dotfiles

## Install a plugin manually from a git repository

1. If you dont have a `.vim` folder, create one

2. Type on a shell:

```bash
mkdir -p plugins
cd plugins
git clone https://github.com/<usr>/<repo_name>.git
```

3. open the `.vimrc` file (or create it) and add:

```vim
set rtp+=~/.vim/plugins/repo_name
source ~/.vim/plugins/<repo_name>/plugin/<plugin_name>.vim
```

4. If you got vim open, re-run the `.vimrc` file from the vim command line:

```vim
:vs ~/.vimrc
```

## Full Set Up

```
cd ~
mkdir -p .vim
mkdir -p ~/.vim/plugins
cd ~/.vim/plugins
git clone git@github.com:preservim/nerdtree.git
mkdir -p ~/.vim/colors
cd ~/.vim/colors
curl -O https://raw.githubusercontent.com/sts10/vim-pink-moon/master/colors/pink-moon.vim
sudo apt-get install vim-gtk
```

Then you paste this into `~/.vimrc`:

```vim
set number
set termguicolors
colorscheme pink-moon
set background=dark
" highlight current window column 80
augroup BgHighlight
    autocmd!
    autocmd WinEnter * set colorcolumn=80
    autocmd WinLeave * set colorcolumn=0
augroup END
" tell vim where to find plugins: runtimepath is where vim looks for scripts
" nerdtree: taken from https://github.com/preservim/nerdtree
set rtp+=~/.vim/plugins/nerdtree
source ~/.vim/plugins/nerdtree/plugin/NERD_tree.vim
" Start NERDTree. If a file is specified, move the cursor to its window.
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * NERDTree | if argc() > 0 || exists("s:std_in") | wincmd p | endif
" Close the tab if NERDTree is the only window remaining in it.
autocmd BufEnter * if winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif
```

## Useful commands

- In case you press Ctrl-Z by accident:

```bash
Ctrl-Q
```

- Copy visually selected text from vim to clipboard:

```vim
"+y
```

- Paste from clipboard into vim:

```vim
mouse wheel click
```

- Split vim window vertically:

```vim
Ctrl-w
```

- Split vim window horizontally:

```vim
Ctrl-s
```

- Move to existent left, down, up, right windows:

```vim
Ctrl-(h|j|k|l)
```

