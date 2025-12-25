vim.lsp.enable({'clangd'})
vim.lsp.enable({'lua_ls'})
vim.lsp.enable({'texlab'})
vim.lsp.enable({'rust_analyzer'})

--vim.api.nvim_create_autocmd('LspAttach', {
--  callback = function(ev)
--    local client = vim.lsp.get_client_by_id(ev.data.client_id)
--    if client and client:supports_method(vim.lsp.protocol.Methods.textDocument_completion) then
--      vim.opt.completeopt = { 'menu', 'menuone', 'noinsert', 'fuzzy', 'popup' }
--      vim.lsp.completion.enable(true, client.id, ev.buf, { autotrigger = true })
--      vim.keymap.set('i', '<C-Space>', function()
--        vim.lsp.completion.get()
--      end)
--    end
--  end,
--})
vim.api.nvim_create_autocmd('LspAttach', {
  callback = function(ev)
    local client = vim.lsp.get_client_by_id(ev.data.client_id)
    -- NO activar completion nativo de LSP
    -- Blink.cmp se encarga de todo.
    -- NO llamar a vim.lsp.completion.enable
    -- NO tocar completeopt aquí
  end,
})
vim.lsp.config("*", {
  --capabilities = require("cmp_nvim_lsp").default_capabilities();
  capabilities = require("blink.cmp").get_lsp_capabilities();
})





local severity = vim.diagnostic.severity
vim.diagnostic.config({
  signs = {
    text = {
      [severity.ERROR] = " ",
      [severity.WARN] = " ",
      [severity.HINT] = "󰠠 ",
      [severity.INFO] = " ",
    },
  },
})




