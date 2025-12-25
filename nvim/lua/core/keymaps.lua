local map = vim.api.nvim_set_keymap 
local opts = {noremap = true, silent = true }


--Utils
    -- Select All
map('n', '<C-a>', '<Esc>ggVG',opts)
    -- Ctrl C 
map('v', '<C-c>', '"+y', {noremap = true })
    --automatic keys
vim.api.nvim_set_keymap(
  'i',
  '{<CR>',
  '{<CR>}<Esc>O',
  { noremap = true }
)

-- Mapeo para Telescope
map('n', '<C-f>', '<cmd>Telescope find_files<cr>', opts)
--map('n', '<A-f>', '<cmd>Telescope live_grep<cr>', opts)
map('n', '<A-f>', '<cmd>Telescope oldfiles<cr>', opts)
-- Navegate FIles config
--map('n', '<C-d>', ':lua MiniFiles.open()<CR>', opts)
--Nvim tree toggle 
map('n', '<C-q>', ':NvimTreeToggle<CR>', opts)

-- Cambiar entre ventanas 
--map('n', '<C-l>', ':BufferNext<CR>', opts)
--map('n', '<C-h>', ':BufferPrevious<CR>', opts)
--map('n', '<C-q>', ':BufferClose<CR>',opts)
-- Split commands two splits
map('n', '<A-l>', '<C-w>l', opts)
map('n', '<A-h>', '<C-w>h', opts)
map('n', '<A-v>', '<C-w>v', opts)
-- Mappings LATEX 
-- Mapeo Ctrl + p en modo normal
--vim.api.nvim_set_keymap('n', '<C-p>', ':!zathura %:r.pdf &<CR>', { noremap = true, silent = true })
-- Comando :L que hace lo mismo
vim.api.nvim_create_user_command('L', function()
  vim.cmd('!zathura %:r.pdf &')
end, {})

-- Comando para accept solo para una palabra  de Copilot 
vim.keymap.set('i', '<C-P>', '<Plug>(copilot-accept-word)')
-- Comando para accept linea completa de Copilot
vim.keymap.set('i', '<C-L>', 'copilot#Accept("\\<CR>")', {
    expr = true,
    replace_keycodes = false
})
--vim.g.copilot_no_tab_map = true--
-- Mapeo de PageUp y PageDown como Home y End SOLO PARA TECLADO KM32 DELUX
vim.keymap.set({'n','i','v'}, '<PageUp>', '<Home>')
vim.keymap.set({'n','i','v'}, '<PageDown>', '<End>')




