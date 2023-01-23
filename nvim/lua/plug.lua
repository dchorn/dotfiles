-- PLUGINS
return require('packer').startup(function()
  -- Packer can manage itself
    use 'wbthomason/packer.nvim'

  -- Tokyonight theme
    use 'folke/tokyonight.nvim'

  -- dashboard
    use {'glepnir/dashboard-nvim'}


  --lspsaga
	  use({
		"glepnir/lspsaga.nvim",
		branch = "main",
		config = function()
			local saga = require("lspsaga")

			saga.init_lsp_saga({
				-- your configuration
			})
		end,
	})

  -- cmp for LuasSip
	use 'hrsh7th/cmp-nvim-lua'
    use 'hrsh7th/cmp-nvim-lsp'
    use 'hrsh7th/cmp-buffer'
    use 'hrsh7th/cmp-path'
    use 'hrsh7th/cmp-cmdline'
    use 'hrsh7th/nvim-cmp'
    use 'saadparwaiz1/cmp_luasnip'

  -- Telescope
	use "nvim-lua/plenary.nvim"
	use {
	  'nvim-telescope/telescope.nvim', tag = '0.1.0',
	-- or                            , branch = '0.1.x',
	  requires = { {'nvim-lua/plenary.nvim'} }
	}

    use {
        'nvim-treesitter/nvim-treesitter',
        run = function()
            local ts_update = require('nvim-treesitter.install').update({ with_sync = true })
            ts_update()
        end,
	}
	use {'nvim-telescope/telescope-fzf-native.nvim', run = 'make' }

  -- LuaSnip
    use {"L3MON4D3/LuaSnip", tag = "v1.*"}

  -- LspConfig
    use 'neovim/nvim-lspconfig'
    use 'williamboman/nvim-lsp-installer'
	use { 'github/copilot.vim' }

  -- Trouble nvim
	use {
    	"folke/trouble.nvim",
		requires = "kyazdani42/nvim-web-devicons",
		config = function()
		require("trouble").setup {
		  -- your configuration comes here
		  -- or leave it empty to use the default settings
		  -- refer to the configuration section below
    	}
  	end
	}

  -- lualine
	use {
	  'nvim-lualine/lualine.nvim',
	  requires = { 'kyazdani42/nvim-web-devicons', opt = true }
	}

  -- WHICH-KEY
    use {
        'folke/which-key.nvim',
        config = function() require'which-key'.setup{} end
    }

  -- WakaTime
	use 'wakatime/vim-wakatime'

end)
