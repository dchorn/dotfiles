local g   = vim.g
local o   = vim.o
local t = vim.opt
local A   = vim.api

-- Encoding
t.encoding = 'utf-8'

-- Spaces and tabs
t.smarttab = true
t.tabstop = 4
t.expandtab = false
t.shiftwidth = 4

-- Highlight current line
t.cursorline = true

-- Line numbers
t.number = true
t.relativenumber = true

-- Visual bell
t.visualbell = true

-- Color mode
t.termguicolors = true

-- NetRW Config
g.netrw_keepdir = 0
g.netrw_winsize = 20

-- MD Languages
g.markdown_fenced_languages = {'bash=sh', 'javascript', 'json=javascript', 'typescript', 'html', 'rust', 'css', 'cpp', 'python', 'php'}

------------------------------------
-- Source Plugins
require('plug')
------------------------------------

-- KEYBINDINGS
vim.cmd [[packadd packer.nvim]]
local function map(m, k, v)
    vim.keymap.set(m, k, v, { silent = true })
end

-- KEY-REMAPS
map('n', '<F5>', '<Esc>:!python %<CR>')

map('i', '<C-d>', '<Bs>')
map('i', '<C-h>', '<Left>')
map('i', '<C-j>', '<Down>')
map('i', '<C-k>', '<Up>')
map('i', '<C-l>', '<Right>')
map('c', '<C-h>', '<Left>')
map('c', '<C-j>', '<Down>')
map('c', '<C-k>', '<Up>')
map('c', '<C-l>', '<Right>')
map('i', '{<CR>', '{<CR>}<Esc><S-O>')
map('i', '<S-Tab>', '<Esc><<i')
map('x', '<Tab>', '>')
map('x', '<S-Tab>', '<')
map('x', '"', 'c""<Esc>P')
map('x', "'", "c''<Esc>P")
map('x', '(', 'c()<Esc>P')
map('x', '{', 'c{}<Esc>P')
map('x', '[', 'c[]<Esc>P')
map('x', '*', 'c**<Esc>P')

map('i', '<C-b>', '<Esc>:Lexplore<CR>')
map('n', '<C-b>', '<Esc>:Lexplore<CR>')

-- PLUGIN CONFIGS AND INITS
-- ====================================================================
-- TOOOOKYYYOOO - "ThePrimeagen"
g.tokynight_transparent_sidebar = true
g.tokynight_transparent = true
t.background = "dark"
vim.cmd("colorscheme tokyonight")

-- DON'T FORGET AFTER INSTALL :: TSInstall html/php/etc... + TSEnable autotag !!
require('nvim-ts-autotag').setup()

-- TELESCOPE FINDER AND IT'S KEY-MAPPING
require('telescope').setup()
map('n', '<C-f>f', '<Esc>:Telescope find_files <CR>')
map('n', '<C-f>g', '<Esc>:Telescope live_grep <CR>')
map('n', '<C-f>b', '<Esc>:Telescope buffers <CR>')
map('n', '<C-f>h', '<Esc>:Telescope help_tags <CR>')

-- Lua line, very nice - "Borat"
require('lualine').setup{ options = { theme = 'gruvbox' }}
vim.cmd("set encoding=UTF-8")

-- Block commenting
require('kommentary.config').use_extended_mappings()

-- SETUP CMP AUTOCOMPLETE
-- ====================================================================

require("luasnip.loaders.from_vscode").lazy_load()

local luasnip = require'luasnip'
local cmp = require'cmp'
  cmp.setup({
    mapping = cmp.mapping.preset.insert({
    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-e>'] = cmp.mapping.close(),
    ['<c-y>'] = cmp.mapping.confirm({ 
       behavior = cmp.ConfirmBehavior.Insert,
       select = true 
   }), --cmp.confirm, 
   }), -- mapping,
    
   sources = cmp.config.sources({
      { name = 'gh_issues'},
      { name = 'nvim_lsp' },
      { name = 'path'},
      { name = 'luasnip'},
      { name = 'buffer', keyword_length = 3},
      }), --sources
   
    snippet = ({
      expand = function(args)
       require'luasnip'.lsp_expand(args.body)
     end
     }), -- snippet


    experimental = {
        native_menu = false,
        ghost_text = true,
    }, --experimental
}) -- setup

local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
require'lspconfig'.pyright.setup { capabilities = capabilities }
require'lspconfig'.eslint.setup { capabilities = capabilities }
require'lspconfig'.intelephense.setup { capabilities = capabilities }

-- WhichKey keybinds setup
-- wk.register({key1 = {name, more_keys = {cmd, help}}}, predix_key)
local wk = require("which-key")
wk.register({
    t = {
        name = "telescope",
        f = {"<cmd>lua require('telescope.builtin').find_files()<cr>", "find files"},
        g = {"<cmd>lua require('telescope.builtin').live_grep()<cr>", "grep"},
        b = {"<cmd>lua require('telescope.builtin').buffers()<cr>", "buffer list"},
        h = {"<cmd>lua require('telescope.builtin').help_tags()<cr>", "help tags"},
        t = {"<cmd>lua require('telescope.builtin').treesitter()<cr>", "treesiter"}
    },
    b = {
        name = "buffer",
        c = {"<cmd>bdelete<cr>", "delete buffer"},
        p = {"<cmd>bprevious<cr>", "previous buffer"},
        n = {"<cmd>bnext<cr>", "next buffer"}
    }
}, { prefix = "<leader>" })

-- PLUGINS

