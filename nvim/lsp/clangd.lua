return {
    cmd = { 'clangd', '--background-index' },
    root_markers = {'compile_commands.json', 'compile_flags.txt' },
    filetypes = { 'c', 'cpp' },
    --init_options = {
    --    fallbackFlags = { "-std=c++23" },
    --}
}
