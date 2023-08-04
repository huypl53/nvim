local status, packer = pcall(require, "packer")
if (not status) then
  print("Packer is not installed")
  return
end

vim.cmd [[packadd packer.nvim]]

packer.startup(function(use)
  use 'wbthomason/packer.nvim'
  use {
    'folke/tokyonight.nvim',
    config = function()
      require('tokyonight').setup({
        style = 'moon',
        light_style = 'night',
        transparent = true,
      })
      vim.cmd [[colorscheme tokyonight]]
    end
  }
  use 'nvim-lualine/lualine.nvim'       -- Statusline
  use 'nvim-lua/plenary.nvim'           -- Common utilities
  use 'onsails/lspkind-nvim'            -- vscode-like pictograms
  use 'hrsh7th/cmp-buffer'              -- nvim-cmp source for buffer words
  use 'hrsh7th/cmp-nvim-lsp'            -- nvim-cmp source for neovim's built-in LSP
  use 'hrsh7th/nvim-cmp'                -- Completion
  use 'neovim/nvim-lspconfig'           -- LSP
  use 'jose-elias-alvarez/null-ls.nvim' -- Use Neovim as a language server to inject LSP diagnostics, code actions, and more via Lua
  use 'williamboman/mason.nvim'
  use 'williamboman/mason-lspconfig.nvim'
  use 'nvimdev/lspsaga.nvim' -- LSP UIs
  use 'saadparwaiz1/cmp_luasnip'
  use({ 'L3MON4D3/LuaSnip', run = "make install_jsregexp" })
  use {
    'nvim-treesitter/nvim-treesitter',
    run = function()
      -- require 'nvim-treesitter.install'.compilers = { 'zig' }
      if vim.fn.has('win32') or vim.fn.has('macunix')
      then
        require 'nvim-treesitter.install'.compilers = { 'clang' }
      else
        require 'nvim-treesitter.install'.compilers = { 'gcc' }
      end
      -- require('nvim-treesitter.install').update({ with_sync = true })
      require('nvim-treesitter.install').prefer_git = false
    end,
  }
  use { 
    'folke/todo-comments.nvim',
    dependencies = { "nvim-lua/plenary.nvim" }
  }
  use 'kevinhwang91/nvim-bqf'        -- Friendly quickfix
  use 'kyazdani42/nvim-web-devicons' -- File icons
  use 'lukas-reineke/indent-blankline.nvim'
  use {
    "nvim-telescope/telescope.nvim",
    requires = {
      { "nvim-telescope/telescope-live-grep-args.nvim" },
    }
  }
  use 'nvim-telescope/telescope-file-browser.nvim'
  use 'windwp/nvim-autopairs'
  use 'windwp/nvim-ts-autotag'
  use 'norcalli/nvim-colorizer.lua'
  use 'folke/zen-mode.nvim'
  use 'folke/twilight.nvim'
  use 'tpope/vim-surround'
  use 'liuchengxu/vista.vim'
  use({
    "iamcco/markdown-preview.nvim",
    run = function() vim.fn["mkdp#util#install"]() end,
  })
  use 'rhysd/accelerated-jk'
  use 'akinsho/nvim-bufferline.lua'
  -- use 'github/copilot.vim'
  use 'numToStr/Comment.nvim'
  use 'JoosepAlviste/nvim-ts-context-commentstring'

  use 'chentoast/marks.nvim'
  use 'lewis6991/gitsigns.nvim'
  use 'dinhhuy258/git.nvim' -- For git blame & browse
  use {
    'phaazon/hop.nvim',
    branch = 'v2', -- optional but strongly recommended
  }

  use { -- tailwindcss-colors
    "themaxmarchuk/tailwindcss-colors.nvim",
    -- load only on require("tailwindcss-colors")
    module = "tailwindcss-colors",
    -- run the setup function after plugin is loaded
    config = function()
      -- pass config options here (or nothing to use defaults)
      require("tailwindcss-colors").setup()
    end
  }

  use {
    'ckipp01/nvim-jenkinsfile-linter', 
    requires = { "nvim-lua/plenary.nvim" } 
  }
end)
