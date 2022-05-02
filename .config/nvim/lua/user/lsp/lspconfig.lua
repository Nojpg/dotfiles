local status_ok, lspconfig = pcall(require, "lspconfig")
if not status_ok then
	return
end

local servers = {
	"sumneko_lua",
	"rust-analyzer",
	"null-ls",
	"gopls",
	"hls",
	"ocamllsp",
}

local handlers = require("user.lsp.handlers")

-- TODO compile idris2
--require("idris2").setup({})
for _, server in ipairs(servers) do
	require("user.lsp.settings." .. server).setup(handlers.on_attach, handlers.capabilities)
end
