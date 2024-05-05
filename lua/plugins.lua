local status, lazy = pcall(require, "lazy")
if not status then
	print("lazy is not installed")
	return
end

-- vim.cmd [[packadd lazy.nvim]]

lazy.setup({
	{
		"folke/tokyonight.nvim",
		config = function()
			require("tokyonight").setup({
				style = "moon",
				light_style = "night",
				transparent = true,
			})
			vim.cmd([[colorscheme tokyonight]])
		end,
	},
	"nvim-lualine/lualine.nvim", -- Statusline
	"nvim-lua/plenary.nvim", -- Common utilities
	"onsails/lspkind-nvim", -- vscode-like pictograms
	"hrsh7th/cmp-buffer", -- nvim-cmp source for buffer words
	"hrsh7th/cmp-nvim-lsp", -- nvim-cmp source for neovim's built-in LSP
	"hrsh7th/nvim-cmp", -- Completion
	"neovim/nvim-lspconfig", -- LSP
	"jose-elias-alvarez/null-ls.nvim", -- Use Neovim as a language server to inject LSP diagnostics, code actions, and more via Lua
	"williamboman/mason.nvim",
	"williamboman/mason-lspconfig.nvim",
	"nvimdev/lspsaga.nvim", -- LSP UIs
	"saadparwaiz1/cmp_luasnip",
	{ "L3MON4D3/LuaSnip", build = "make install_jsregexp" },
	{
		"nvim-treesitter/nvim-treesitter",
		build = function()
			-- require 'nvim-treesitter.install'.compilers = { 'zig',}
			if vim.fn.has("win32") or vim.fn.has("macunix") then
				require("nvim-treesitter.install").compilers = { "clang" }
			else
				require("nvim-treesitter.install").compilers = { "gcc" }
			end
			-- require('nvim-treesitter.install').update({ with_sync = true })
			require("nvim-treesitter.install").prefer_git = false
		end,
	},
	"nvim-tree/nvim-tree.lua",
	{
		"antosha417/nvim-lsp-file-operations",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-tree/nvim-tree.lua",
		},
	},
	{
		"folke/todo-comments.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
	},
	"kevinhwang91/nvim-bqf", -- Friendly quickfix
	"kyazdani42/nvim-web-devicons", -- File icons
	"lukas-reineke/indent-blankline.nvim",
	{
		"nvim-telescope/telescope.nvim",
		dependencies = {
			{ "nvim-telescope/telescope-live-grep-args.nvim" },
		},
	},
	"nvim-telescope/telescope-file-browser.nvim",
	"windwp/nvim-autopairs",
	"windwp/nvim-ts-autotag",
	"norcalli/nvim-colorizer.lua",
	"folke/zen-mode.nvim",
	"folke/twilight.nvim",
	"tpope/vim-surround",
	"liuchengxu/vista.vim",
	{
		"iamcco/markdown-preview.nvim",
		build = function()
			vim.fn["mkdp#util#install"]()
		end,
	},
	"rhysd/accelerated-jk",
	"akinsho/nvim-bufferline.lua",
	"numToStr/Comment.nvim",
	"JoosepAlviste/nvim-ts-context-commentstring",
	"chentoast/marks.nvim",
	"lewis6991/gitsigns.nvim",
	"dinhhuy258/git.nvim", -- For git blame & browse
	{
		"phaazon/hop.nvim",
		branch = "v2", -- optional but strongly recommended
	},

	{ -- tailwindcss-colors
		"themaxmarchuk/tailwindcss-colors.nvim",
		-- load only on require("tailwindcss-colors")
		-- module = "tailwindcss-colors",
		-- run the setup function after plugin is loaded
		config = function()
			-- pass config options here (or nothing to use defaults)
			require("tailwindcss-colors").setup()
		end,
	},

	{
		"ckipp01/nvim-jenkinsfile-linter",
		dependencies = { "nvim-lua/plenary.nvim" },
	},

	"mfussenegger/nvim-dap",
	"mfussenegger/nvim-dap-python",
	"stevearc/conform.nvim",
})
