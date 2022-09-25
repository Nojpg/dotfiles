return {
	-- https://github.com/golang/tools/blob/master/gopls/doc/settings.md
	gopls = {
		cmd = { "gopls", "serve" },
		settings = {
			gopls = {
				staticcheck = true,
				gofumpt = true,
				linksInHover = true,
				experimentalPostfixCompletions = true,

				-- https://github.com/golang/tools/blob/master/gopls/doc/analyzers.md
				analyses = {
					fillreturns = true,
					nonewvars = true,
					undeclaredname = true,
					unusedparams = false,
					ST1000 = false,
					ST1005 = false,
					shadow = true,
				},
			},
		},
	},
	init_options = {
		usePlaceholders = true,
		completeUnimported = true,
	},
}
