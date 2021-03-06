local fn = vim.fn

-- Automatically install packer
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
	PACKER_BOOTSTRAP = fn.system({
		"git",
		"clone",
		"--depth",
		"1",
		"https://github.com/wbthomason/packer.nvim",
		install_path,
	})
	print("Installing packer close and reopen Neovim...")
	vim.cmd([[packadd packer.nvim]])
end

-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]])

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
	return
end

-- Have packer use a popup window
packer.init({
	display = {
		open_fn = function()
			return require("packer.util").float({ border = "rounded" })
		end,
	},
})

-- Install your plugins here
return packer.startup(function(use)
	-- My plugins here
	use("wbthomason/packer.nvim") -- Have packer manage itself
	use("nvim-lua/popup.nvim") -- An implementation of the Popup API from vim in Neovim
	use("nvim-lua/plenary.nvim") -- Useful lua functions used ny lots of plugins
	use("windwp/nvim-autopairs") -- Autopairs, integrates with both cmp and treesitter
	use("numToStr/Comment.nvim") -- Easily comment stuff
	use("kyazdani42/nvim-web-devicons")
	use("akinsho/bufferline.nvim")
	use("moll/vim-bbye")
	use("nvim-lualine/lualine.nvim")
	use("akinsho/toggleterm.nvim")
	use("ahmedkhalf/project.nvim")
	use("lewis6991/impatient.nvim")
	use("lukas-reineke/indent-blankline.nvim")
	use("goolord/alpha-nvim")
	use("antoinemadec/FixCursorHold.nvim") -- This is needed to fix lsp doc highlight
	use("folke/which-key.nvim")
	use("karb94/neoscroll.nvim")
	use("ur4ltz/surround.nvim")
	use("Shatur/neovim-session-manager")
	use("folke/zen-mode.nvim")
	use("folke/todo-comments.nvim")
	use("norcalli/nvim-colorizer.lua")
	use("rcarriga/nvim-notify")
	--	use("SmiteshP/nvim-gps")
	use({ "christianchiarulli/nvim-gps", branch = "text_hl" })
	--use("matbme/JABS.nvim")
	use({ "christianchiarulli/JABS.nvim", requires = { "kyazdani42/nvim-web-devicons" } })
	use("unblevable/quick-scope")
	use("tversteeg/registers.nvim")
	use("kevinhwang91/nvim-bqf")
	use({
		"ghillb/cybu.nvim",
		branch = "v1.x", -- won't receive breaking changes
		-- branch = "main", -- timely updates
		requires = { "kyazdani42/nvim-web-devicons" }, --optional
	})

	-- File explorer
	use("tamago324/lir.nvim")
	use("kyazdani42/nvim-tree.lua")

	-- Colorschemes
	-- use "lunarvim/darkplus.nvim"
	use("lunarvim/colorschemes") -- A bunch of colorschemes you can try out
	use("folke/tokyonight.nvim")
	use("catppuccin/nvim")
	use("rose-pine/neovim")

	-- cmp plugins
	use({
		"hrsh7th/nvim-cmp",
		requires = {
			"hrsh7th/cmp-buffer", -- buffer completions
			"hrsh7th/cmp-path", -- path completions
			"hrsh7th/cmp-cmdline", -- cmdline completions
			"saadparwaiz1/cmp_luasnip", -- snippet completions
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-nvim-lua",
			"hrsh7th/cmp-emoji",
			"rcarriga/cmp-dap",
			"hrsh7th/cmp-vsnip",
			"hrsh7th/vim-vsnip",
		},
	}) -- The completion plugin

	-- snippets
	use("L3MON4D3/LuaSnip") --snippet engine
	use("rafamadriz/friendly-snippets") -- a bunch of snippets to use
	use("filipdutescu/renamer.nvim")
	use("simrat39/symbols-outline.nvim")
	use({ "michaelb/sniprun", run = "bash ./install.sh" })

	-- LSP
	use("neovim/nvim-lspconfig") -- enable LSP
	use("williamboman/nvim-lsp-installer") -- simple to use language server installer
	use("tamago324/nlsp-settings.nvim") -- language server settings defined in json for
	use("jose-elias-alvarez/null-ls.nvim") -- for formatters and linters
	use("ray-x/lsp_signature.nvim")
	use({ "ShinKage/idris2-nvim", requires = { "neovim/nvim-lspconfig", "MunifTanjim/nui.nvim" } })

	-- Telescope
	use("nvim-telescope/telescope.nvim")
	use({
		"folke/trouble.nvim",
		cmd = "TroubleToggle",
	})
	-- Treesitter
	use({
		"nvim-treesitter/nvim-treesitter",
		run = ":TSUpdate",
	})
	use("JoosepAlviste/nvim-ts-context-commentstring")
	use("ChristianChiarulli/nvim-ts-rainbow")
	use("nvim-treesitter/playground")

	-- Git
	use("lewis6991/gitsigns.nvim")

	-- Debug
	use("mfussenegger/nvim-dap")
	--	use("leoluz/nvim-dap-go")
	use("theHamsta/nvim-dap-virtual-text")
	use("rcarriga/nvim-dap-ui")
	use("Pocco81/DAPInstall.nvim")

	-- Automatically set up your configuration after cloning packer.nvim
	-- Put this at the end after all plugins
	if PACKER_BOOTSTRAP then
		require("packer").sync()
	end
end)
