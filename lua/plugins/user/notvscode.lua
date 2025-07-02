return {
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
  {
    "kyazdani42/nvim-web-devicons",
    -- defaults = {
    --   lazy = true,
    --   version = 'v0.99'
    -- }
  },                           -- File icons
  "nvim-lualine/lualine.nvim", -- Statusline
  "nvim-lua/plenary.nvim",     -- Common utilities
  "onsails/lspkind-nvim",      -- vscode-like pictograms
  "hrsh7th/cmp-buffer",        -- nvim-cmp source for buffer words
  "hrsh7th/cmp-nvim-lsp",      -- nvim-cmp source for neovim's built-in LSP
  "hrsh7th/nvim-cmp",          -- Completion
  -- "jose-elias-alvarez/null-ls.nvim", -- Use Neovim as a language server to inject LSP diagnostics, code actions, and more via Lua
  "williamboman/mason.nvim",
  "williamboman/mason-lspconfig.nvim",
  "neovim/nvim-lspconfig", -- LSP
  "nvimdev/lspsaga.nvim",  -- LSP UIs
  "saadparwaiz1/cmp_luasnip",
  {
    'stevearc/aerial.nvim',
    opts = {},
    -- Optional dependencies
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "nvim-tree/nvim-web-devicons"
    },
  },
  { "L3MON4D3/LuaSnip",             build = "make install_jsregexp" },
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
  'nvim-treesitter/nvim-treesitter-context',
  "nvim-tree/nvim-tree.lua",
  "numToStr/Comment.nvim", -- Comment everything
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
  "lukas-reineke/indent-blankline.nvim",
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      { "nvim-telescope/telescope-live-grep-args.nvim" },
      { "MunifTanjim/nui.nvim" },
      { "nvim-telescope/telescope-file-browser.nvim" },
    },
  },
  "windwp/nvim-autopairs",  -- Auto closing bracket
  "windwp/nvim-ts-autotag", -- Use treesitter to autoclose and autorename html tag
  "norcalli/nvim-colorizer.lua",
  "folke/zen-mode.nvim",    -- Focus on one file
  "folke/twilight.nvim",    -- Focus on code block

  -- {
  -- 	"Exafunction/codeium.nvim",
  -- 	dependencies = {
  -- 		"nvim-lua/plenary.nvim",
  -- 		"hrsh7th/nvim-cmp",
  -- 	},
  -- 	config = function()
  -- 		require("codeium").setup({})
  -- 	end,
  -- },
  {
    "iamcco/markdown-preview.nvim",
    build = function()
      vim.fn["mkdp#util#install"]()
    end,
  },
  "akinsho/nvim-bufferline.lua",
  {
    "chentoast/marks.nvim",
    event = "VeryLazy",
    opts = {},
  },
  "lewis6991/gitsigns.nvim", -- Deep buffer integration for Git
  "dinhhuy258/git.nvim",     -- For git blame & browse

  {
    "ckipp01/nvim-jenkinsfile-linter",
    dependencies = { "nvim-lua/plenary.nvim" },
  },

  "stevearc/conform.nvim", -- Code formatter
  { "mfussenegger/nvim-dap-python", dependencies = { "mfussenegger/nvim-dap" } },
  { "rcarriga/nvim-dap-ui",         dependencies = { "mfussenegger/nvim-dap", "nvim-neotest/nvim-nio" } },
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {
      -- your configuration comes here
      -- or leave it empty to use the default settings
      -- refer to the configuration section below
    },
    keys = {
      {
        "<leader>?",
        function()
          require("which-key").show({ global = false })
        end,
        desc = "Buffer Local Keymaps (which-key)",
      },
    },
  },
  {
    'kevinhwang91/nvim-ufo', -- Folding like boss
    dependencies = { 'kevinhwang91/promise-async' }
  },
  {
    "alexpasmantier/pymple.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
      -- optional (nicer ui)
      "stevearc/dressing.nvim",
      "nvim-tree/nvim-web-devicons",
    },
    build = ":PympleBuild",
    config = function()
      require("pymple").setup()
    end,
  },
  { 'akinsho/toggleterm.nvim', version = "*", config = true }
}
