if &compatible
  set nocompatible               " Be iMproved
endif

" Disable Vim's native pack feature
set packpath=
" set runtimepath+=~/.cache_test/nvim/dein/repos/github.com/Shougo/dein.vim

let $VIM_PATH = fnamemodify(resolve(expand('<sfile>:p')), ':h:h')
let $CACHE = expand('~/.cache/nvim')
if !isdirectory(expand($CACHE))
    call mkdir(expand($CACHE), 'p')
endif
let g:dein#auto_recache = 1
let s:dein_dir = expand('$CACHE/dein')
let s:dein_repo_dir = s:dein_dir . '/repos/github.com/Shougo/dein.vim'
if &runtimepath !~# '/dein.vim'
    if !isdirectory(s:dein_repo_dir)
        execute '!git clone https://github.com/Shougo/dein.vim' s:dein_repo_dir
    endif
    execute 'set runtimepath+='.substitute(
                \ fnamemodify(s:dein_repo_dir, ':p') , '/$', '', '')
endif

if dein#min#load_state(s:dein_dir)
    call dein#begin(s:dein_dir, [expand('<sfile>')])
    " Required:
    " call dein#add('neovim/nvim-lspconfig')
    call dein#add('neoclide/coc.nvim', { 'merged': 0, 'rev': 'release' })
    call dein#add('honza/vim-snippets')
    " if has('nvim')
    " call dein#add('nvim-treesitter/nvim-treesitter')
    " endif
    " Required:
    call dein#end()
    call dein#save_state()
endif
    " Update or install plugins if a change detected
if dein#check_install()
    if ! has('nvim')
        set nomore
    endif
    call dein#install()
endif
call dein#call_hook('source')
call dein#call_hook('post_source')

filetype plugin indent on
syntax enable

set termguicolors


