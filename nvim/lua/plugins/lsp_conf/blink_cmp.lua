return{
    'saghen/blink.cmp',
    enabled = true,
    dependencies = { 
        'rafamadriz/friendly-snippets',
        'L3MON4D3/LuaSnip', version = 'v2.*',
    },
      
    opts = {
        -- 'default' (recommended) for mappings similar to built-in completions (C-y to accept)
        -- 'super-tab' for mappings similar to vscode (tab to accept)
        -- 'enter' for enter to accept
        -- 'none' for no mappings
        keymap = { 
            preset = 'enter',
        },
        snippets = { preset = 'luasnip'},
        appearance = {
          -- 'mono' (default) for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
          -- Adjusts spacing to ensure icons are aligned
          nerd_font_variant = 'mono'
        },

        -- (Default) Only show the documentation popup when manually triggered
        completion = {
            menu = {
                draw = {
                    treesitter = { "lsp" },
                },
            },
            documentation = { 
                auto_show = true,
                auto_show_delay = 200,
            },
            ghost_text = { 
                enabled = vim.g.ai_cmp,
            },

        },
        signature = { enabled = false },
        -- Default list of enabled providers defined so that you can extend it
        -- elsewhere in your config, without redefining it, due to `opts_extend`
        sources = {
            default = { 'lsp', 'path', 'snippets', 'buffer'},
        },
        cmdline = {
            enabled = true,
            keymap = {
              preset = "cmdline",
              ["<Right>"] = false,
              ["<Left>"] = false,
            },
            completion = {
              list = { selection = { preselect = false } },
              menu = {
                auto_show = function(ctx)
                  return vim.fn.getcmdtype() == ":"
                end,
              },
              ghost_text = { enabled = true },
            },
        },       

        -- (Default) Rust fuzzy matcher for typo resistance and significantly better performance
        -- You may use a lua implementation instead by using `implementation = "lua"` or fallback to the lua implementation,
        -- when the Rust fuzzy matcher is not available, by using `implementation = "prefer_rust"`
        --
        -- See the fuzzy documentation for more information
        fuzzy = { implementation = "prefer_rust_with_warning" }
    },
    opts_extend = { "sources.default" }
}
