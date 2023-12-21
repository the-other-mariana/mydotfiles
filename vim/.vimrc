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
set rtp+=~/.vim/plugins/nerdtree-git-plugin
source ~/.vim/plugins/nerdtree-git-plugin/autoload/gitstatus.vim

