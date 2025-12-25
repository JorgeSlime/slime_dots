-- Configuración básica de NeoVim
-- para numeros de línea relativos y otras opciones comunes     
vim.opt.number = true                   -- Mostrar números de línea
vim.opt.relativenumber = true           -- Mostrar números de línea relativos
vim.opt.cursorline = true               -- Resaltar la línea del cursor  
vim.opt.cursorlineopt = 'number'         -- Resaltar solo el número de línea del cursor
vim.opt.signcolumn = "yes:1"  -- siempre muestra la columna de signos, evita "saltos"
vim.opt.numberwidth = 4     -- ancho fijo para números
-------------------------------------------------------------
vim.opt.tabstop = 4                     -- Tamaño de la tabulación
vim.opt.shiftwidth = 4                  -- Tamaño de indentación
vim.opt.expandtab = true                -- Utilizar espacios en lugar de tabulaciones
vim.opt.smartindent = true              -- Indentación automática inteligente
vim.opt.wrap = false                    -- Desactivar el ajuste automático de líneas
vim.opt.encoding = 'utf-8'              -- Codificación UTF-8
vim.opt.termguicolors = true     --for vim notify
vim.opt.mouse = 'a'                     -- Activar el uso del mouse
vim.opt.hidden = true
vim.opt.autoindent = true
vim.opt.spell=true
vim.opt.spelllang='es'
vim.cmd('syntax on')                     -- Activar la sintaxis
vim.g.airline_powerline_fonts = 1

