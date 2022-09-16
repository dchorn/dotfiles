local Plug = vim.fn['plug#'];
vim.call('plug#begin', '~/.config/nvim/plugged')
-- Plug 'neovim/nvim-lspconfig'
Plug('dense-analysis/ale')
Plug('j-hui/fidget.nvim')
Plug('nvim-treesitter/nvim-treesitter', {['do'] = vim.fn['TSUpdate']})
Plug('ojroques/nvim-hardline')
Plug('jiangmiao/auto-pairs')
Plug('machakann/vim-sandwich')
Plug('simrat39/symbols-outline.nvim')
Plug('mattn/emmet-vim')
Plug('tpope/vim-vinegar')
Plug('nvim-lua/plenary.nvim')
Plug('kyazdani42/nvim-web-devicons')
Plug('nvim-telescope/telescope.nvim', {['tag'] = '0.1.0' })
Plug('nvim-telescope/telescope-fzf-native.nvim', {['do'] = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build' })
Plug('folke/which-key.nvim')
Plug('folke/tokyonight.nvim', { ['branch'] = 'main' })
Plug ('Valloric/YouCompleteMe', {['do'] = './install.py --tern-completer' })
vim.call('plug#end')