
" ---编译、运行----
function! function#RunResult() abort " 先保存，再格式化，最后运行可执行文件
    exec "w"
    if has("win32")
        if  &filetype == "c"
            exec "!clang % -Wall -std=c99 -O2 -o %<.exe"
            exec "!start cmd /c  \"\"%<.exe\" & pause && del %:r.exe\""
        elseif &filetype == "cpp"
            exec "!clang++ % -Wall -std=c++11 -O2 -o %<.exe"
            exec "!start cmd /c  \"\"%<.exe\" & pause && del %:r.exe\""
        elseif &filetype == "tex"
            exec ":VimtexCompile"
        elseif &filetype == "fortran"
            exec "!gfortran % -Wall  -O2 -o %<.exe"
            exec "!start cmd /c  \"\"%<.exe\" & pause && del %r:.exe\""
        elseif &filetype == "lua"
            exec "!start cmd /c lua %<.lua & pause"
        elseif &filetype == "perl"
            exec "!start cmd /c perl %<.pl & pause"
        elseif &filetype == "python"
            exec "!start cmd /c \"python  %<.py & pause\""
        elseif &filetype == "markdown"
            exec "MarkdownPreview"
        elseif &filetype == "gnuplot"
            exec "!start cmd /c  \"gnuplot % & pause \""
            exec "!pause"
        endif
    else
        " echo expand('%:p:r')
        set splitbelow
        if &filetype == 'c'
            :!clang "%" -std=c99 -lm -O2 -o "%<"
            if has('nvim')
                :sp
            endif
            :term   "%:p:r"  && rm "%:p:r"
            " exec "new +resize10 term://   "%:p:r"  && rm %:p:r"
            " exec "!rm  "%:p:r" "
        elseif &filetype == 'cpp'
            :!clang++ -std=c++11 "%" -O2  -o "%<"
            :sp
            :term   "%:p:r"  && rm "%:p:r"
        elseif &filetype == "fortran"
            :!gfortran "%" -Wall  -O2 -o "%<"
            :sp
            :term   "%:p:r"  && rm "%<"
        elseif &filetype == 'python'
            :sp
            :term  python3 -u "%"
            " elseif &filetype == 'markdown'
            " :InstantMarkdownPreview
        elseif &filetype == 'tex'
            silent! exec "VimtexStop"
            silent! exec "VimtexCompile"
        elseif &filetype == 'gnuplot'
            :cd  "%:p:h"
            :!gnuplot.exe "%"
        endif
    endif
endfunction


" Jump definition in other window
function! function#JumpDefinition() abort
    if winnr('$') >= 4 || winwidth(0) < 120
        if g:registered_lsp ==# 'coc'
            exec "normal \<Plug>(coc-definition)"
        else
            exec "<cmd>lua vim.lsp.buf.definition()"
        endif
    else
        if g:registered_lsp ==# 'coc'
            exec 'vsplit'
            exec "normal \<Plug>(coc-definition)"
        else
            exec 'vsplit'
            exec "lua vim.lsp.buf.definition()"
        endif
    endif
endfunction


