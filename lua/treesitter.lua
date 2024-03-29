require'nvim-treesitter.configs'.setup {
    ensure_installed = {"c", "cpp","python","lua"}, -- one of "all", "maintained" (parsers with maintainers), or a list of languages
    ignore_install = { "glsl" }, -- List of parsers to ignore installing
    highlight = {
        enable = true,              -- false will disable the whole extension
        disable = { "vim", "json","jsonc"},  -- list of language that will be disabled
        -- additional_vim_regex_highlighting = true,
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
