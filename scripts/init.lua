local install_path = vim.fn.stdpath 'data' .. '/site/pack/packer/start/packer.nvim'
local is_bootstrap = false

if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
  is_bootstrap = true
  vim.fn.execute('!git clone https://github.com/wbthomason/packer.nvim ' .. install_path)
  vim.cmd [[packadd packer.nvim]]
end

require('packer').startup(function(use)
  use 'wbthomason/packer.nvim'
  use 'williamboman/mason.nvim'
  use 'williamboman/mason-lspconfig.nvim'
  use 'nvim-lua/plenary.nvim'
  use 'nvim-telescope/telescope.nvim'
  use 'neovim/nvim-lspconfig'
  use 'nvim-treesitter/nvim-treesitter'
	use 'nvim-treesitter/nvim-treesitter-textobjects'
  use 'folke/tokyonight.nvim'
  use { 'folke/trouble.nvim', requires = 'kyazdani42/nvim-web-devicons' }
  use 'nvim-lualine/lualine.nvim'
  use 'akinsho/bufferline.nvim'
  use { 'goolord/alpha-nvim', requires = 'kyazdani42/nvim-web-devicons' }
  use 'lewis6991/gitsigns.nvim'
  use 'folke/which-key.nvim'
  use "windwp/nvim-autopairs"
  use 'numToStr/Comment.nvim'
  use { "jose-elias-alvarez/null-ls.nvim", requires =  "nvim-lua/plenary.nvim" }

	use 'hrsh7th/cmp-nvim-lsp'
	use 'hrsh7th/cmp-buffer'
	use 'hrsh7th/cmp-path'
	use 'hrsh7th/cmp-cmdline'
	use 'hrsh7th/nvim-cmp'

	use 'L3MON4D3/LuaSnip'
	use 'saadparwaiz1/cmp_luasnip'

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
vim.o.expandtab = true

vim.o.updatetime = 250
vim.wo.signcolumn = 'yes'
vim.o.termguicolors = true
vim.o.completeopt = 'menuone,noselect'

vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

vim.o.tabstop = 2
vim.o.shiftwidth = 2
vim.o.scrolloff = 3

require('mason').setup{}
require('mason-lspconfig').setup{
	ensure_installed = { 'sumneko_lua', 'rust_analyzer' }
}

local builtin = require('telescope.builtin')

vim.keymap.set('n', 'ff', builtin.find_files)
vim.keymap.set('n', 'fg', builtin.live_grep)
vim.keymap.set('n', 'fb', builtin.buffers)
vim.keymap.set('n', 'fh', builtin.help_tags)

require('nvim-treesitter.configs').setup{}
require('trouble').setup{}

require('lualine').setup{}
require('bufferline').setup{}

require('alpha').setup(require('alpha.themes.startify').config)
require('gitsigns').setup{}
require('which-key').setup{}
require("nvim-autopairs").setup {}
require('Comment').setup()

vim.cmd [[colorscheme tokyonight]]

local null_ls = require("null-ls")
null_ls.setup({
	sources = {
		null_ls.builtins.formatting.eslint_d,
		null_ls.builtins.code_actions.eslint_d,
		null_ls.builtins.diagnostics.eslint_d,

		null_ls.builtins.formatting.rubocop,
		null_ls.builtins.diagnostics.rubocop,
	}
})

local cmp = require'cmp'
cmp.setup({
	snippet = {
		expand = function(args)
			require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
		end,
	},
	window = {
		completion = cmp.config.window.bordered(),
		documentation = cmp.config.window.bordered(),
	},
	mapping = cmp.mapping.preset.insert({
		['<C-b>'] = cmp.mapping.scroll_docs(-4),
		['<C-f>'] = cmp.mapping.scroll_docs(4),
		['<C-Space>'] = cmp.mapping.complete(),
		['<C-e>'] = cmp.mapping.abort(),
		['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
	}),
	sources = cmp.config.sources({
		{ name = 'nvim_lsp' },
		{ name = 'luasnip' }, -- For luasnip users.
	}, {
		{ name = 'buffer' },
	})
})

-- Set configuration for specific filetype.
cmp.setup.filetype('gitcommit', {
	sources = cmp.config.sources({
		{ name = 'cmp_git' }, -- You can specify the `cmp_git` source if you were installed it.
	}, {
		{ name = 'buffer' },
	})
})

-- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline({ '/', '?' }, {
	mapping = cmp.mapping.preset.cmdline(),
	sources = {
		{ name = 'buffer' }
	}
})

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(':', {
	mapping = cmp.mapping.preset.cmdline(),
	sources = cmp.config.sources({
		{ name = 'path' }
	}, {
		{ name = 'cmdline' }
	})
})


local capabilities = require('cmp_nvim_lsp').default_capabilities()
require('lspconfig').rust_analyzer.setup{ capabilities = capabilities }
require('lspconfig').sumneko_lua.setup{ capabilities = capabilities }
