return {
  "L3MON4D3/LuaSnip",
  dependencies = {
    "rafamadriz/friendly-snippets",
  },
  config = function()
    require("luasnip.loaders.from_vscode").lazy_load()  -- friendly-snippets
    require("luasnip.loaders.from_snipmate").lazy_load({ paths = "~/.config/nvim/snippets" })
    --require("snippets.luasnip") 
    local ls = require('luasnip')
    local M = {}
    function M.expand_or_jump()
        if ls.expand_or_jumpable() then
      		ls.expand_or_jump()
        end
    end
    function M.jump_next()
        if ls.jumpable(1) then
    		ls.jump(1)
    	end
    end
    function M.jump_prev()
        if ls.jumpable(-1) then
      		ls.jump(-1)
      	end
    end
    function M.change_choice()
    	if ls.choice_active() then
    		ls.change_choice(1)
    	end
    end
    _G.LS = M;
  end,
}

