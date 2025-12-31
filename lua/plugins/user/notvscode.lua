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
  "kyazdani42/nvim-web-devicons", -- File icons
  "nvim-lualine/lualine.nvim",    -- Statusline
  "nvim-lua/plenary.nvim",        -- Common utilities
  "onsails/lspkind-nvim",         -- vscode-like pictograms
  "hrsh7th/cmp-buffer",           -- nvim-cmp source for buffer words
  "hrsh7th/cmp-nvim-lsp",         -- nvim-cmp source for neovim's built-in LSP
  "hrsh7th/nvim-cmp",             -- Completion
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
  {
    "L3MON4D3/LuaSnip",
    build = "make install_jsregexp"
  },
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
  'nvim-treesitter/nvim-treesitter-context', -- Sticky scroll keeps higher indent context
  "nvim-tree/nvim-tree.lua",
  "numToStr/Comment.nvim",                   -- Comment everything
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
  -- "dinhhuy258/git.nvim",     -- For git blame & browse

  {
    "ckipp01/nvim-jenkinsfile-linter",
    dependencies = { "nvim-lua/plenary.nvim" },
  },

  "stevearc/conform.nvim", -- Code formatter
  { "mfussenegger/nvim-dap-python", dependencies = { "mfussenegger/nvim-dap" } },
  -- { "rcarriga/nvim-dap-ui",         dependencies = { "mfussenegger/nvim-dap", "nvim-neotest/nvim-nio" } },
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
      require("pymple").setup({
        keymaps = {
          -- Resolves import for symbol under cursor.
          -- This will automatically find and add the corresponding import to
          -- the top of the file (below any existing doctsring)
          resolve_import_under_cursor = {
            desc = "Resolve import under cursor",
            keys = "<C-space>" -- feel free to change this to whatever you like
          }
        },
      })
    end,
  },
  {
    'akinsho/toggleterm.nvim',
    version = "*",
    config = true
  },                             -- Terminal inside vim
  {
    "nosduco/remote-sshfs.nvim", -- neovim SSH like vscode but using fs
    dependencies = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim" },
  },
  'Vigemus/iron.nvim',      -- REPL python
  {
    "nvim-neotest/neotest", --Testing integration
    dependencies = {
      "nvim-neotest/neotest-python",
      "nvim-neotest/nvim-nio",
      "nvim-lua/plenary.nvim",
      "antoinemadec/FixCursorHold.nvim",
      "nvim-treesitter/nvim-treesitter"
    }
  },
  {
    's1n7ax/nvim-window-picker',
    name = 'window-picker',
    event = 'VeryLazy',
    version = '2.*',
  },
  {
    "y3owk1n/time-machine.nvim", -- Undo. Redo. Time travel. Take control of your edit history like never before.
    version = "*",               -- remove this if you want to use the `main` branch
    opts = {
      -- your configuration comes here
      -- or leave it empty to use the default settings
      -- refer to the configuration section below
    }
  },
  "hat0uma/csvview.nvim",
  ---@module "csvview"
  ---@type CsvView.Options
  opts = {
    parser = { comments = { "#", "//" } },
    keymaps = {
      -- Text objects for selecting fields
      textobject_field_inner = { "if", mode = { "o", "x" } },
      textobject_field_outer = { "af", mode = { "o", "x" } },
      -- Excel-like navigation:
      -- Use <Tab> and <S-Tab> to move horizontally between fields.
      -- Use <Enter> and <S-Enter> to move vertically between rows and place the cursor at the end of the field.
      -- Note: In terminals, you may need to enable CSI-u mode to use <S-Tab> and <S-Enter>.
      jump_next_field_end = { "<Tab>", mode = { "n", "v" } },
      jump_prev_field_end = { "<S-Tab>", mode = { "n", "v" } },
      jump_next_row = { "<Enter>", mode = { "n", "v" } },
      jump_prev_row = { "<S-Enter>", mode = { "n", "v" } },
    },
  },
  cmd = { "CsvViewEnable", "CsvViewDisable", "CsvViewToggle" },
}
