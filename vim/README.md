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

