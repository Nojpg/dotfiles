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
		prompt_border = "rounded", -- Border style of prompt popups.
	},
})

-- Install your plugins here
return packer.startup(function(use)
	-- My plugins here
	use("wbthomason/packer.nvim") -- Have packer manage itself
	-- Lua Development
	use("nvim-lua/plenary.nvim") -- Useful lua functions used ny lots of plugins
	use("nvim-lua/popup.nvim")
	use("christianchiarulli/lua-dev.nvim")

	--Icon
	use("kyazdani42/nvim-web-devicons")
	--	use("akinsho/bufferline.nvim")
	-- Utility
	use("moll/vim-bbye")
	use("lewis6991/impatient.nvim")
	use("ghillb/cybu.nvim")

	-- StatusLine
	use("nvim-lualine/lualine.nvim")

	-- Comment
	use("folke/todo-comments.nvim")
	use("numToStr/Comment.nvim") -- Easily comment stuff

	-- Terminal
	use("akinsho/toggleterm.nvim")

	-- Session
	use("rmagatti/auto-session")
	use("rmagatti/session-lens")

	-- Startup
	use("goolord/alpha-nvim")

	-- Color
	use("NvChad/nvim-colorizer.lua")
	use("nvim-colortils/colortils.nvim")

	-- Indent
	use("lukas-reineke/indent-blankline.nvim")

	--Project
	use("ahmedkhalf/project.nvim")
	use("windwp/nvim-spectre")
	use("antoinemadec/FixCursorHold.nvim") -- This is needed to fix lsp doc highlight
	use("folke/which-key.nvim")
	use("ur4ltz/surround.nvim")
	use("Shatur/neovim-session-manager")
	use("rcarriga/nvim-notify")
	--	use("SmiteshP/nvim-gps")
	use({ "christianchiarulli/nvim-gps", branch = "text_hl" })
	--use("matbme/JABS.nvim")
	use({ "christianchiarulli/JABS.nvim", requires = { "kyazdani42/nvim-web-devicons" } })
	use("unblevable/quick-scope")

	-- Editing Support
	use("folke/zen-mode.nvim")
	use("monaqa/dial.nvim")
	use("windwp/nvim-autopairs")
	use("nacro90/numb.nvim")
	use("andymass/vim-matchup")
	use("karb94/neoscroll.nvim")
	use("junegunn/vim-slash")

	-- Code Runner
	use("is0n/jaq-nvim")

	-- Quickfix
	use("kevinhwang91/nvim-bqf")

	-- Registers
	use("tversteeg/registers.nvim")

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
	use({ "michaelb/sniprun", run = "bash ./install.sh" })

	-- LSP
	use("neovim/nvim-lspconfig") -- enable LSP
	use("williamboman/mason.nvim") -- lsp installer
	use("williamboman/mason-lspconfig.nvim")
	--	use("tamago324/nlsp-settings.nvim") -- language server settings defined in json for
	use("jose-elias-alvarez/null-ls.nvim") -- for formatters and linters
	use("ray-x/lsp_signature.nvim")
	use({ "ShinKage/idris2-nvim", requires = { "neovim/nvim-lspconfig", "MunifTanjim/nui.nvim" } })
	use("lvimuser/lsp-inlayhints.nvim")
	use("simrat39/symbols-outline.nvim")
	use("j-hui/fidget.nvim")
	use("https://git.sr.ht/~whynothugo/lsp_lines.nvim")
	use("SmiteshP/nvim-navic")
	use("RRethy/vim-illuminate")

	-- Fuzzy Finder/Telescope
	use("nvim-telescope/telescope.nvim")
	use("nvim-telescope/telescope-media-files.nvim")
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
	use("nvim-treesitter/nvim-treesitter-textobjects")
	use("kylechui/nvim-surround")
	use({
		"abecodes/tabout.nvim",
		wants = { "nvim-treesitter" }, -- or require if not used so far
	})

  --Marks
  use "christianchiarulli/harpoon"

	-- Git
	use("lewis6991/gitsigns.nvim")
	use("f-person/git-blame.nvim")

	-- Debug
	use("mfussenegger/nvim-dap")
	use("rcarriga/nvim-dap-ui")

	-- Rust
	use("Saecki/crates.nvim")
	use({ "christianchiarulli/rust-tools.nvim", branch = "modularize_and_inlay_rewrite" })

	-- Automatically set up your configuration after cloning packer.nvim
	-- Put this at the end after all plugins
	if PACKER_BOOTSTRAP then
		require("packer").sync()
	end
end)
