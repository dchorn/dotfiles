-- =====================================
-- GLOBAL VARIABLES
-- =====================================
local g   = vim.g
local o   = vim.o
local t   = vim.opt
local A   = vim.api
----------------------------------------

-- =====================================
-- GENERAL NVIM CONFIG 
-- =====================================
t.encoding = 'utf-8'

-- Spaces and tabs
t.smarttab = true
t.tabstop = 4
t.expandtab = false
t.shiftwidth = 4

-- Highlight current line
t.cursorline = true

-- Line numbers (Numeros relativos a tu posicion, los numeros que aparecen a la izquierda)
t.number = true
t.relativenumber = true

-- NetRW Config ('Navegador de archivos de vim')
g.netrw_keepdir = 0
g.netrw_winsize = 20
----------------------------------------

-- =====================================
-- IMPORTAR EL ARHCHIVO DE PLUGINS 
-- =====================================
require('plug')
----------------------------------------


-- =====================================
-- PLUGIN CONFIGS AND INITS
-- =====================================

----------------------------------------
-- TOOOOKYYYOOO - "ThePrimeagen"
----------------------------------------

g.tokynight_transparent_sidebar = true
g.tokynight_transparent = true
t.background = "dark"
vim.cmd("colorscheme tokyonight")


----------------------------------------
-- LuaSnip 
----------------------------------------

require("luasnip.loaders.from_vscode").lazy_load()

local luasnip = require'luasnip'
local cmp = require'cmp'
  cmp.setup({
    mapping = cmp.mapping.preset.insert({
    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-e>'] = cmp.mapping.close(),
    ['<CR>'] = cmp.mapping.confirm({
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
       luasnip.lsp_expand(args.body)
     end
     }), -- snippet

    experimental = {
        native_menu = false,
        ghost_text = true,
    }, --experimental
}) -- setup


----------------------------------------
-- LSPCONFIG
----------------------------------------

require'nvim-lsp-installer'.setup {}
local lspconfig = require('lspconfig')

local function on_attach(client, bufnr)
	-- set up buffer keymaps, etc
end

lspconfig.sumneko_lua.setup { on_attach = on_attach }
lspconfig.html.setup { on_attach = on_attach }
lspconfig.tsserver.setup { on_attach = on_attach }
lspconfig.pyright.setup { on_attach = on_attach }
lspconfig.eslint.setup { on_attach = on_attach }
lspconfig.intelephense.setup { on_attach = on_attach }


----------------------------------------
-- WhichKey
----------------------------------------

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

----------------------------------------
