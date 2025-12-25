---- indent-blankline
--local highlight = {
--    "RainbowRed",
--    "RainbowYellow",
--    "RainbowBlue",
--    "RainbowOrange",
--    "RainbowGreen",
--    "RainbowViolet",
--    "RainbowCyan",
--}
--
--local hooks = require "ibl.hooks"
---- create the highlight groups in the highlight setup hook, so they are reset
---- every time the colorscheme changes
--hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
--    vim.api.nvim_set_hl(0, "RainbowRed", { fg = "#E06C75" })
--    vim.api.nvim_set_hl(0, "RainbowYellow", { fg = "#E5C07B" })
--    vim.api.nvim_set_hl(0, "RainbowBlue", { fg = "#61AFEF" })
--    vim.api.nvim_set_hl(0, "RainbowOrange", { fg = "#D19A66" })
--    vim.api.nvim_set_hl(0, "RainbowGreen", { fg = "#98C379" })
--    vim.api.nvim_set_hl(0, "RainbowViolet", { fg = "#C678DD" })
--    vim.api.nvim_set_hl(0, "RainbowCyan", { fg = "#56B6C2" })
--end)
--
----require("ibl").setup { indent = { highlight = highlight } }
--return {
--    'lukas-reineke/indent-blankline.nvim',
--    -- name = "indent-blankline",
--    main = "ibl", -- Required after v3.0.0
--    enabled = true,
--    lazy = true,
--    event = {"BufReadPost", "BufNewFile"},
--    opts = {
--        indent = {
--            char = "┃",
--            smart_indent_cap = true,
--            highlight = {
--                "winter_blue",
--            },
--        },
--        scope = {
--            enabled = false
--        },
--        viewport_buffer = {
--            min = 100,
--            max = 600,
--        },
--    },
--    config = function(_, opts)
--
--        local hooks = require("ibl.hooks")
--
--        hooks.register(
--            hooks.type.HIGHLIGHT_SETUP, function()
--                vim.api.nvim_set_hl(0, "winter_blue", { fg = "#252535" })
--            end
--        )
--
--        hooks.register(hooks.type.VIRTUAL_TEXT, function(_, bufnr, row, virt_text)
--            local config = require("ibl.config").get_config(bufnr)
--            local line = vim.api.nvim_buf_get_lines(bufnr, row, row + 1, false)[1]
--            if line == "" then
--                for _, v in ipairs(virt_text) do
--                    if v[1] == config.indent.char then
--                        v[1] = "┊"
--                    end
--                end
--            end
--            return virt_text
--        end)
--        local ibl_ok, ibl = pcall(require, "ibl")
--
--        if not ibl_ok then
--            print("Error loading 'indent-blankline'.")
--            return
--        end
--
--        ibl.setup(opts)
--
--    end
--}

-- Colores Rainbow personalizados
local rainbow_colors = {
    Red    = "#E06C75",
    Yellow = "#E5C07B",
    Blue   = "#61AFEF",
    Orange = "#D19A66",
    Green  = "#98C379",
    Violet = "#C678DD",
    Cyan   = "#56B6C2",
}

local rainbow_highlight = {
    "RainbowRed",
    "RainbowYellow",
    "RainbowBlue",
    "RainbowOrange",
    "RainbowGreen",
    "RainbowViolet",
    "RainbowCyan",
}

return {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    lazy = true,
    event = { "BufReadPost", "BufNewFile" },

    opts = {
        indent = {
            char = "┃",
            smart_indent_cap = true,
            highlight = rainbow_highlight,
        },
        scope = {
            enabled = true,
            highlight = rainbow_highlight,
            show_start = false,
            show_end = false,
        },
        viewport_buffer = {
            min = 100,
            max = 600,
        },
    },

    config = function(_, opts)
        local hooks = require("ibl.hooks")

        -- 🎨 Registrar highlight groups (se re-aplican al cambiar colorscheme)
        hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
            for name, color in pairs(rainbow_colors) do
                vim.api.nvim_set_hl(0, "Rainbow" .. name, { fg = color })
            end
        end)

        -- 🧊 Virtual text personalizado para líneas vacías
        hooks.register(hooks.type.VIRTUAL_TEXT, function(_, bufnr, row, virt_text)
            local config = require("ibl.config").get_config(bufnr)
            local line = vim.api.nvim_buf_get_lines(bufnr, row, row + 1, false)[1]

            if line == "" then
                for _, v in ipairs(virt_text) do
                    if v[1] == config.indent.char then
                        v[1] = "┊" -- caracter más suave
                    end
                end
            end

            return virt_text
        end)

        local ok, ibl = pcall(require, "ibl")
        if not ok then
            print("Error loading 'indent-blankline'.")
            return
        end

        ibl.setup(opts)
    end,
}

