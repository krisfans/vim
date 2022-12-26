if &compatible
  set nocompatible               " Be iMproved
endif

" Disable Vim's native pack feature
set packpath=
" set runtimepath+=~/.cache_test/nvim/dein/repos/github.com/Shougo/dein.vim
" set runtimepath+=~/.cache_test/nvim/dein/repos/github.com/tyru/caw.vim
" set runtimepath+=~/.cache_test/nvim/dein/repos/github.com/nvim-treesitter/nvim-treesitter

let $CACHE = expand('~/.cache/nvim')
if !isdirectory(expand($CACHE))
    call mkdir(expand($CACHE), 'p')
endif
let s:dein_dir = expand('$CACHE/dein')
let s:dein_repo_dir = s:dein_dir . '/repos/github.com/Shougo/dein.vim'
if &runtimepath !~# '/dein.vim'
    if !isdirectory(s:dein_repo_dir)
        execute '!git clone https://github.com/Shougo/dein.vim' s:dein_repo_dir
    endif
    execute 'set runtimepath+='.substitute(
                \ fnamemodify(s:dein_repo_dir, ':p') , '/$', '', '')
endif

let g:dein#auto_recache = 1
if dein#load_state(s:dein_dir)
    call dein#begin(s:dein_dir)
    " Required:
    call dein#add('neovim/nvim-lspconfig')
    call dein#add('hrsh7th/nvim-cmp')
    call dein#add('hrsh7th/cmp-buffer')
    call dein#add('hrsh7th/cmp-nvim-lsp')
    call dein#add('tyru/caw.vim')
    if has('nvim')
    call dein#add('nvim-treesitter/nvim-treesitter')
    endif
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

" filetype plugin indent on
" syntax enable
" Attempt to determine the type of a file based on its name and possibly its
" contents. Use this to allow intelligent auto-indenting for each filetype,
" and for plugins that are filetype specific.
if has('filetype')
  filetype indent plugin on
endif

" Enable syntax highlighting
if has('syntax')
  syntax on
endif
set termguicolors

lua << EOF
--     require'lspconfig'.clangd.setup{}
--     local cmp = require("cmp")
--         cmp.setup({
--             snippet = {
--                 expand = function(args)
--                    vim.fn["vsnip#anonymous"](args.body)
--                  -- require 'snippy'.expand_snippet(args.body)
--             end,
--         },
--         sources = {
--             { name = "nvim_lsp" },
--             { name = "buffer" },
--             -- { name = "vsnip" },
--            -- { name = 'snippy' }
--         },
--         mapping = {
--             ["<S-TAB>"] = cmp.mapping.select_prev_item(),
--             ["<TAB>"] = cmp.mapping.select_next_item(),
--             ["<C-Space>"] = cmp.mapping.complete(),
--             ["<C-e>"] = cmp.mapping.close(),
--             ['<CR>'] = cmp.mapping.confirm()
--         },
--     })
EOF
    if has('nvim')
lua << EOF
require'nvim-treesitter.configs'.setup {
    ensure_installed = {"c", "cpp","python","lua"}, -- one of "all", "maintained" (parsers with maintainers), or a list of languages
    ignore_install = { "glsl" }, -- List of parsers to ignore installing
    highlight = {
        enable = true,              -- false will disable the whole extension
        disable = { "vim", "latex" ,"json","jsonc"},  -- list of language that will be disabled
        -- additional_vim_regex_highlighting = false,
    },
    indent = {
        enable = true
    },
    refactor = {
        -- 高亮显示光标下符号的定义
        highlight_definitions = {
            enable = true
        },
        -- 高亮当前函数范围
        highlight_current_scope = {
            enable = false
        },
    },
}
EOF
endif
