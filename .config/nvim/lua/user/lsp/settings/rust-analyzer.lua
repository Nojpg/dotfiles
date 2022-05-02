local M = {}

local settings = {
	cargo = {
		loadOutDirsFromCheck = true,
	},
	cheeckOnSave = {
		command = "clippy",
	},
	experimental = {
		procAttrMacros = true,
	},
}

M.setup = function(on_attach, capabilities)
	local lspconfig = require("lspconfig")

	lspconfig.rust_analyzer.setup({
		on_attach = on_attach,
		capabilities = capabilities,
		settings = settings,
	})
end

return M
