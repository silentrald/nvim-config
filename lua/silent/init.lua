# Lazyvim setup
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

local plugins = {
  {
    'nvim-telescope/telescope.nvim', tag = '0.1.5',
    -- or                            , branch = '0.1.x',
    dependencies = { {'nvim-lua/plenary.nvim'} }
  },

  {
    'nvim-treesitter/nvim-treesitter', 
    build = ':TSUpdate'
  },
  'nvim-treesitter/playground',
  'tpope/vim-fugitive',

  {
    'VonHeikemen/lsp-zero.nvim',
    branch = 'v3.x',
    dependencies = {
      {'neovim/nvim-lspconfig'},
      {'williamboman/mason.nvim'},
      {'williamboman/mason-lspconfig.nvim'},

      -- Autocompletion
      {'hrsh7th/nvim-cmp'},
      {'hrsh7th/cmp-buffer'},
      {'hrsh7th/cmp-path'},
      {'saadparwaiz1/cmp_luasnip'},
      {'hrsh7th/cmp-nvim-lsp'},
      {'hrsh7th/cmp-nvim-lua'},

     -- Snippets
      {'L3MON4D3/LuaSnip'},
      {'rafamadriz/friendly-snippets'},
    }
  },

  -- // Custom stuff //
  -- Terminal
  'voldikss/vim-floaterm',

  -- Side file explorer
  'nvim-tree/nvim-tree.lua',
  'nvim-tree/nvim-web-devicons',

  -- Status bar
  'vim-airline/vim-airline',

  -- Cursor
  'mg979/vim-visual-multi',

  -- Auto
  'tpope/vim-surround',
  'folke/todo-comments.nvim',
  'windwp/nvim-autopairs',
  'numToStr/Comment.nvim',

  -- git
  'sindrets/diffview.nvim',
  'Xuyuanp/nerdtree-git-plugin',
  'f-person/git-blame.nvim',

  -- Linters & Formatter
  'stevearc/conform.nvim',
  'mfussenegger/nvim-lint',

  -- Theme
  -- { 'rose-pine/neovim', as = 'rose-pine' },
  'folke/tokyonight.nvim'
}

local opts = {}

require("lazy").setup(plugins, opts)
require("silent.remap")
require("silent.set")

