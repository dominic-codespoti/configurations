local M = {}

M.on_attach = function(client, bufnr)
    if client.supports_method("textDocument/formatting") then
      local format_on_save = vim.api.nvim_create_augroup("LspFormatting", { clear = true })
      vim.api.nvim_create_autocmd('BufWritePre', {
        group = format_on_save,
        buffer = bufnr,
        callback = function()
          vim.lsp.buf.format({
            bufnr = bufnr,
            filter = function(_client)
              return _client.name == "null-ls"
            end
          })
        end,
      })
    end
  end

return M
