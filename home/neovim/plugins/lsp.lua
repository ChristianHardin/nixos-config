config = function()
  local capabilities = require('blink.cmp').get_lsp_capabilities()

	-- LSP (Downloaded in ../default.nix)
  require("lspconfig").lua_ls.setup { capabilities = capabilities }
	require('lspconfig').nil_ls.setup { capabilities = capabilities }

  vim.api.nvim_create_autocmd('LspAttach', {
    callback = function(args)
      local client = vim.lsp.get_client_by_id(args.data.client_id)
      if not client then return end

      if client:supports_method('textDocument/formatting') then
        -- Format the current buffer on save
        vim.api.nvim_create_autocmd('BufWritePre', {
          buffer = args.buf,
          callback = function()
            vim.lsp.buf.format({ bufnr = args.buf, id = client.id })
          end,
        })
      end
    end,
  })
end
