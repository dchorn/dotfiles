-- PLUGINS
return require('packer').startup(function()
  
  -- Packer can manage itself
    use 'wbthomason/packer.nvim'

  -- Tokyonight theme
    use 'folke/tokyonight.nvim'

  -- cmp for LuasSip
	use 'hrsh7th/cmp-nvim-lua'
    use 'hrsh7th/cmp-nvim-lsp'
    use 'hrsh7th/cmp-buffer'
    use 'hrsh7th/cmp-path'
    use 'hrsh7th/cmp-cmdline'
    use 'hrsh7th/nvim-cmp'
    use 'saadparwaiz1/cmp_luasnip'

  -- LuaSnip
    use {"L3MON4D3/LuaSnip", tag = "v1.*"}
  
  -- LspConfig
    use 'neovim/nvim-lspconfig'
    use 'williamboman/nvim-lsp-installer'

  -- WHICH-KEY
    use {
        'folke/which-key.nvim',
        config = function() require'which-key'.setup{} end
    }
end)
