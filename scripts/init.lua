local install_path = vim.fn.stdpath 'data' .. '/site/pack/packer/start/packer.nvim'
local is_bootstrap = false

if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
  is_bootstrap = true
  vim.fn.execute('!git clone https://github.com/wbthomason/packer.nvim ' .. install_path)
  vim.cmd [[packadd packer.nvim]]
end

require('packer').startup(function(use)
  use 'wbthomason/packer.nvim'
  use { 'williamboman/mason.nvim',
    config = function()
      require('mason').setup{}
    end
  }


  use { 'williamboman/mason-lspconfig.nvim',
    config = function()
      require('mason-lspconfig').setup{
        ensure_installed = { 'sumneko_lua', 'rust_analyzer' }
      }
    end
  }

  use 'nvim-lua/plenary.nvim'
  use {'nvim-telescope/telescope.nvim',
    config = function()
      local builtin = require('telescope.builtin')

      vim.keymap.set('n', 'ff', builtin.find_files)
      vim.keymap.set('n', 'fg', builtin.live_grep)
      vim.keymap.set('n', 'fb', builtin.buffers)
      vim.keymap.set('n', 'fh', builtin.help_tags)
    end
  }

  use { 'neovim/nvim-lspconfig',
    config = function()
      require('lspconfig').rust_analyzer.setup{}
      require('lspconfig').sumneko_lua.setup{}
    end
  }

  use {
    'nvim-treesitter/nvim-treesitter',
    'nvim-treesitter/nvim-treesitter-textobjects',
    config = function()
      require('nvim-treesitter.configs').setup{}
    end
  }

  use { 'folke/tokyonight.nvim',
    config = function()
      vim.cmd [[colorscheme tokyonight]]
    end
  }

  use { 'folke/trouble.nvim',
    requires = 'kyazdani42/nvim-web-devicons',
    config = function()
      require('trouble').setup{}
    end
  }

  use { 'echasnovski/mini.nvim',
    config = function()
      require('mini.completion').setup{}
      require('mini.indentscope').setup{}
    end
  }

  use { 'nvim-lualine/lualine.nvim',
    config = function()
      require('lualine').setup{}
    end
  }

  use { 'akinsho/bufferline.nvim',
    config = function()
      require('bufferline').setup{}
    end
  }

  use { 'goolord/alpha-nvim',
    requires = 'kyazdani42/nvim-web-devicons',
    config = function()
      require('alpha').setup(require('alpha.themes.startify').config)
    end
  }

  use { 'lewis6991/gitsigns.nvim',
    config = function()
      require('gitsigns').setup{}
    end
  }

  use { 'folke/which-key.nvim',
    config = function()
      require('which-key').setup{}
      -- TODO: botar meus keymappings aqui
    end
  }

  use {
    "windwp/nvim-autopairs",
    config = function()
      require("nvim-autopairs").setup {}
    end
  }

  use {
    'numToStr/Comment.nvim',
    config = function()
      require('Comment').setup()
    end
  }

  if is_bootstrap then
    require('packer').sync()
  end
end)

vim.o.hlsearch = false

vim.wo.number = true
vim.wo.relativenumber = true

vim.o.cursorline = true
vim.o.cursorlineopt = 'number'

vim.o.mouse = 'a'
vim.o.breakindent = true
vim.o.undofile = true
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.updatetime = 250
vim.wo.signcolumn = 'yes'
vim.o.termguicolors = true
vim.o.completeopt = 'menuone,noselect'
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

