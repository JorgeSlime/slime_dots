-- Deshabilitar Copilot para archivos C++
vim.api.nvim_create_autocmd("FileType", {
    pattern = "cpp",
    callback = function()
        vim.b.copilot_enabled = false
    end,
})

--desactiva el omnicomplete de vim 
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "tex", "plaintex", "latex" },
  callback = function()
    vim.bo.omnifunc = ""
  end,
})



-- Funcion de notify de bienvenida
function welcome()
    local text = "UwU"
    vim.notify("Bienvenido JorgeSlime", 'info', {
        title = text,
        timeout=3000,
        render = "simple",
        stages = "slide",
    })
end
vim.cmd([[autocmd VimEnter * lua welcome()]])



-- Definir la función en Lua
function OpenInput()
    -- Abrir el archivo input.txt en una nueva ventana vertical
    vim.cmd('vsplit in')
end
vim.cmd('command! INPUT lua OpenInput()')
function OpenOutput()
    -- Abrir el archivo outpit con los resultados de forma vetical 
    vim.cmd('vsplit out')

    -- desabulita la edicion de este archivo
    --vim.bo.readonly = true
    --vim.bo.modifiable = false
end

-- Función para compilar programas en Rust o C++
function CompileProgramTOT()
    local file_path = vim.fn.expand('%:p')
    local file_name = vim.fn.expand('%:t:r')
    local file_extension = vim.fn.expand('%:e')
    local compile_command = nil

    if file_extension == "rs" then
        if vim.fn.filereadable('../Cargo.toml') == 1 then
            compile_command = 'cargo build'
        else
            compile_command = 'rustc -o "' .. file_name .. '" "' .. file_path .. '"'
        end
    elseif file_extension == "cpp" then
        --compile_command = 'g++ "' .. file_path .. '" -o "' .. file_name .. '" -std=c++23 -O2 -Wall -Wextra -Wunknown-pragmas -DSLIME -I/home/jorge/.config/nvim/my_includes'
        compile_command = 'g++ "' .. file_path .. '" -o "' .. file_name .. '" -std=c++20 -O2 -Wconversion -Wshadow -Wall -Wextra -DSLIME'
    else
        vim.api.nvim_err_writeln("No se puede compilar: formato no reconocido (" .. file_extension .. ")")
        return
    end

    local compile_output = vim.fn.systemlist(compile_command)

    if vim.v.shell_error ~= 0 then
        -- Crear nuevo buffer en vsplit
        vim.cmd('vsplit')
        local bufnr = vim.api.nvim_create_buf(false, true)
        vim.api.nvim_win_set_buf(0, bufnr)

        vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, compile_output)
        vim.api.nvim_buf_set_option(bufnr, 'modifiable', false)
        vim.api.nvim_buf_set_option(bufnr, 'bufhidden', 'wipe')
        vim.api.nvim_buf_set_option(bufnr, 'filetype', 'compilelog')

        vim.api.nvim_buf_set_name(bufnr, 'Compilación con errores')
    else
        vim.notify(file_name .. ": compilado correctamente")
    end
end

-- Función para ejecutar programas en Rust o C++
function RunProgramTOT()
    local file_name = vim.fn.expand('%:r') 
    local file_extension = vim.fn.expand('%:e') 
    local run_command = nil
    if file_extension == "rs" then
        if vim.fn.filereadable('../Cargo.toml') == 1 then
            run_command = 'lxterminal -e /bin/bash -c \'cargo run; echo; read -p "Pulse_intro_para_salir..."\''
        else
            run_command = 'lxterminal -e /bin/bash -c \'./"' .. file_name .. '"; echo; read -p "Pulse_intro_para_salir..."\''
        end
    elseif file_extension == "cpp" then
        run_command = 'kitty -e /bin/bash -c \'./"' .. file_name .. '"; echo; read -p "Pulse_intro_para_salir..."\''
    else
        vim.api.nvim_err_writeln("No se puede ejecutar: formato no reconocido (" .. file_extension .. ")")
        return
    end
    os.execute(run_command)
end
-- Ejecutar programas en una nueva ventana de Kitty
function RunProgramTOT1()
    local file_path = vim.fn.expand('%:p')
    local file_name = vim.fn.expand('%:r')
    local file_base = vim.fn.expand('%:t:r')
    local file_ext  = vim.fn.expand('%:e')

    local run_cmd = nil

    if file_ext == "cpp" then
        -- Ejecuta binario C++ ya compilado
        run_cmd = {
            "lxterminal", "-e", "bash", "-c",
            "./\"" .. file_name .. "\"; echo; read -p 'Pulse intro para salir...'"
        }

    elseif file_ext == "rs" then
        -- Rust: usa Cargo si existe
        if vim.fn.filereadable("../Cargo.toml") == 1 then
            run_cmd = {
                "lxterminal", "-e", "bash", "-c",
                "cargo run; echo; read -p 'Pulse intro para salir...'"
            }
        else
            run_cmd = {
                "kitty", "-e", "bash", "-c",
                "./\"" .. file_name .. "\"; echo; read -p 'Pulse intro para salir...'"
            }
        end

    elseif file_ext == "java" then
        -- Java: compila y ejecuta
        run_cmd = {
            "lxterminal", "-e", "bash", "-c",
            "javac \"" .. file_path .. "\" && java \"" .. file_base .. "\"; echo; read -p 'Pulse intro para salir...'"
        }

    elseif file_ext == "py" then
        -- Python
        run_cmd = {
            "lxterminal", "-e", "bash", "-c",
            "python3 \"" .. file_path .. "\"; echo; read -p 'Pulse intro para salir...'"
        }

    else
        vim.api.nvim_err_writeln(
            "No se puede ejecutar: formato no soportado (" .. file_ext .. ")"
        )
        return
    end

    -- Ejecuta el comando
    vim.fn.jobstart(run_cmd, { detach = true })
end


function RunProgramWithInput()
    local program_name = vim.fn.expand('%:r') -- Nombre del archivo sin extensión
    local file_extension = vim.fn.expand('%:e') -- Extensión del archivo
    local input_file = 'in' -- Archivo de entrada
    local run_command = nil

    -- Detectar el tipo de archivo
    if file_extension == "rs" then
        if vim.fn.filereadable('Cargo.toml') == 1 then
            run_command = 'lxterminal -e bash -c \'cargo run -- < "' .. input_file .. '"; echo; read -p "Pulse_intro_para_salir..."\''
        else
            run_command = 'lxterminal -e bash -c \'./"' .. program_name .. '" < "' .. input_file .. '"; echo; read -p "Pulse_intro_para_salir..."\''
        end
    elseif file_extension == "cpp" then
        run_command = 'lxterminal -e bash -c \'./"' .. program_name .. '" < "' .. input_file .. '"; echo; read -p "Pulse_intro_para_salir..."\''
    else
        vim.api.nvim_err_writeln("No se puede ejecutar: formato no reconocido (" .. file_extension .. ")")
        return
    end

    -- Ejecutar el comando
    os.execute(run_command)
end

-- Comando único para compilar y ejecutar
function CompileAndRunTOT()
    CompileProgramTOT()
    if vim.v.shell_error == 0 then
        RunProgramTOT()
    end
end
-- FUNCIONES PARA COMPILAR Y EJECUTAR 
vim.cmd('command! Compile lua CompileProgramTOT()')
vim.cmd('command! Run lua RunProgramTOT1()')
vim.cmd('command! CompileRun lua CompileAndRunTOT()')
vim.cmd('command! RunIO lua RunProgramWithInput()')

-- Para Lua cuando se abre archivos prolog
vim.api.nvim_create_autocmd({"BufNewFile", "BufRead"}, {
    pattern = "*.pl",
    callback = function()
        vim.bo.filetype = "prolog"
    end
})

vim.api.nvim_set_hl(0, "CursorLineNr", { fg = "#FFD700", bold = true })
--vim.api.nvim_set_hl(0, "LineNr", { fg = "#5c5c5c" })
