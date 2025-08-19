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
  "dinhhuy258/git.nvim",     -- For git blame & browse

  {
    "ckipp01/nvim-jenkinsfile-linter",
    dependencies = { "nvim-lua/plenary.nvim" },
  },

  "stevearc/conform.nvim", -- Code formatter
  { "mfussenegger/nvim-dap-python", dependencies = { "mfussenegger/nvim-dap" } },
  { "rcarriga/nvim-dap-ui",         dependencies = { "mfussenegger/nvim-dap", "nvim-neotest/nvim-nio" } },
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
  { 'akinsho/toggleterm.nvim', version = "*", config = true }, -- Terminal inside vim
  {
    "yetone/avante.nvim",
    -- if you want to build from source then do `make BUILD_FROM_SOURCE=true`
    -- ⚠️ must add this setting! ! !
    build = function()
      -- conditionally use the correct build system for the current OS
      if vim.fn.has("win32") == 1 then
        return "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false"
      else
        return "make"
      end
    end,
    event = "VeryLazy",
    version = false, -- Never set this value to "*"! Never!
    dependencies = {
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
      --- The below dependencies are optional,
      "echasnovski/mini.pick",         -- for file_selector provider mini.pick
      "nvim-telescope/telescope.nvim", -- for file_selector provider telescope
      "hrsh7th/nvim-cmp",              -- autocompletion for avante commands and mentions
      "ibhagwan/fzf-lua",              -- for file_selector provider fzf
      "stevearc/dressing.nvim",        -- for input provider dressing
      "folke/snacks.nvim",             -- for input provider snacks
      "nvim-tree/nvim-web-devicons",   -- or echasnovski/mini.icons
      "zbirenbaum/copilot.lua",        -- for providers='copilot'
      {
        -- support for image pasting
        "HakonHarnes/img-clip.nvim",
        event = "VeryLazy",
        opts = {
          -- recommended settings
          default = {
            embed_image_as_base64 = false,
            prompt_for_file_name = false,
            drag_and_drop = {
              insert_mode = true,
            },
            -- required for Windows users
            use_absolute_path = true,
          },
        },
      },
      {
        -- Make sure to set this up properly if you have lazy=true
        'MeanderingProgrammer/render-markdown.nvim',
        opts = {
          file_types = { "markdown", "Avante" },
        },
        ft = { "markdown", "Avante" },
      },
    },
  },
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
    config = function()
      require 'window-picker'.setup()
    end,
  }
}
