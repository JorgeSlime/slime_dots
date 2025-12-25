vim.cmd('command! LL VimtexCompile')
vim.cmd('command! L VimtexView')
vim.cmd('command! CL VimtexClean')
return{
    "lervag/vimtex",
    lazy = false,     -- we don't want to lazy load VimTeX
    -- tag = "v2.15", -- uncomment to pin to a specific release
    init = function()
        vim.g.vimtex_view_method = "zathura"
        vim.g.vimtex_quickfix_mode = 0
        vim.g.tex_conceal='abdmg'
        --vim.g.vimtex_compiler_method='pdflatex -shell-escape'
        vim.g.vimtex_compiler_method='pdflatex'


    end
}
