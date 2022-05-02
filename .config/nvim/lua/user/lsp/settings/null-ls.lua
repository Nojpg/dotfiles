local null_ls_status_ok, null_ls = pcall(require, "null-ls")
if not null_ls_status_ok then
  return
end

-- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/formatting
local formatting = null_ls.builtins.formatting
-- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/diagnostics
local diagnostics = null_ls.builtins.diagnostics

local code_actions = null_ls.builtins.code_actions

local hover = null_ls.builtins.hover
local diagnostics_code_template = "[#{c}] #{m} (#{s})"

local M = {}

M.setup = function(on_attach)
  null_ls.setup({
    debug = false,
    sources = {
      formatting.prettier.with({ extra_args = { "--no-semi", "--single-quote", "--jsx-single-quote" } }),
      formatting.black.with({ extra_args = { "--fast" } }),
      formatting.stylua,
      -- .with({
      --   condition = with_root_file(".stylua.toml"),
      -- }),
      formatting.autopep8,
      formatting.cmake_format,
      formatting.gofmt,
      formatting.shellharden,
      formatting.shfmt.with({
        filetypes = { "sh", "bash", "zsh" },
      }),
      formatting.rustfmt,
      formatting.asmfmt,
      code_actions.shellcheck,
      code_actions.gitsigns,
      diagnostics.checkmake,
      diagnostics.gitlint,
      diagnostics.pylint,
      diagnostics.luacheck,
      diagnostics.shellcheck.with({
        diagnostics_format = diagnostics_code_template,
      }),
      hover.dictionary,
    },
    --		on_attach = function(client)
    --			if client.supports_method("textDocument/formatting") then
    --				vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
    --				vim.api.nvim_create_autocmd("BufWritePre", {
    --					group = augroup,
    --					buffer = bufnr,
    --					callback = function()
    --						vim.lsp.buf.format({ bufnr = bufnr, timeout_ms = 3000 })
    --					end,
    --				})
    --			end
    --		end,
    on_attach = function(client)
      if client.resolved_capabilities.document_formatting then
        vim.cmd([[
		      augroup LspFormatting
		        autocmd! * <buffer>
		        autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync()
		      augroup END
		      ]])
      end
    end,
  })
end

return M
