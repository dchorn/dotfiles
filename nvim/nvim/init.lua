-- =====================================
-- GLOBAL VARIABLES
-- =====================================
local g   = vim.g
-- local o   = vim.o
local t   = vim.opt
-- local A   = vim.api
local keymap = vim.keymap.set
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
-- Plenary 
----------------------------------------
local a = require "plenary.async"

local read_file = function(path)
  local err, fd = a.uv.fs_open(path, "r", 438)
  assert(not err, err)

  local err, stat = a.uv.fs_fstat(fd)
  assert(not err, err)

  local err, data = a.uv.fs_read(fd, stat.size, 0)
  assert(not err, err)

  local err = a.uv.fs_close(fd)
  assert(not err, err)

  return data
end
----------------------------------------


----------------------------------------
-- lspsaga 
-- local saga = require('lspsaga')

--saga.init_lsp_saga()

-- Lsp finder find the symbol definition implement reference
-- if there is no implement it will hide
-- when you use action in finder like open vsplit then you can
-- use <C-t> to jump back
keymap("n", "gh", "<cmd>Lspsaga lsp_finder<CR>", { silent = true })

-- Code action
keymap({"n","v"}, "<leader>ca", "<cmd>Lspsaga code_action<CR>", { silent = true })

-- Rename
keymap("n", "gr", "<cmd>Lspsaga rename<CR>", { silent = true })

-- Peek Definition
-- you can edit the definition file in this flaotwindow
-- also support open/vsplit/etc operation check definition_action_keys
-- support tagstack C-t jump back
keymap("n", "gd", "<cmd>Lspsaga peek_definition<CR>", { silent = true })

-- Show line diagnostics
keymap("n", "<leader>cd", "<cmd>Lspsaga show_line_diagnostics<CR>", { silent = true })

-- Show cursor diagnostic
keymap("n", "<leader>cd", "<cmd>Lspsaga show_cursor_diagnostics<CR>", { silent = true })

-- Diagnsotic jump can use `<c-o>` to jump back
keymap("n", "[e", "<cmd>Lspsaga diagnostic_jump_prev<CR>", { silent = true })
keymap("n", "]e", "<cmd>Lspsaga diagnostic_jump_next<CR>", { silent = true })

-- Only jump to error
keymap("n", "[E", function()
  require("lspsaga.diagnostic").goto_prev({ severity = vim.diagnostic.severity.ERROR })
end, { silent = true })
keymap("n", "]E", function()
  require("lspsaga.diagnostic").goto_next({ severity = vim.diagnostic.severity.ERROR })
end, { silent = true })

-- Outline
keymap("n","<leader>o", "<cmd>LSoutlineToggle<CR>",{ silent = true })

-- Hover Doc
keymap("n", "K", "<cmd>Lspsaga hover_doc<CR>", { silent = true })

-- Float terminal
keymap("n", "<A-d>", "<cmd>Lspsaga open_floaterm<CR>", { silent = true })
-- if you want pass somc cli command into terminal you can do like this
-- open lazygit in lspsaga float terminal
keymap("n", "<A-d>", "<cmd>Lspsaga open_floaterm lazygit<CR>", { silent = true })
-- close floaterm
keymap("t", "<A-d>", [[<C-\><C-n><cmd>Lspsaga close_floaterm<CR>]], { silent = true })
----------------------------------------


----------------------------------------
-- Trouble
----------------------------------------
vim.keymap.set("n", "<leader>xx", "<cmd>TroubleToggle<cr>",
  {silent = true, noremap = true}
)
vim.keymap.set("n", "<leader>xw", "<cmd>TroubleToggle workspace_diagnostics<cr>",
  {silent = true, noremap = true}
)
vim.keymap.set("n", "<leader>xd", "<cmd>TroubleToggle document_diagnostics<cr>",
  {silent = true, noremap = true}
)
vim.keymap.set("n", "<leader>xl", "<cmd>TroubleToggle loclist<cr>",
  {silent = true, noremap = true}
)
vim.keymap.set("n", "<leader>xq", "<cmd>TroubleToggle quickfix<cr>",
  {silent = true, noremap = true}
)
vim.keymap.set("n", "gR", "<cmd>TroubleToggle lsp_references<cr>",
  {silent = true, noremap = true}
)
----------------------------------------


----------------------------------------
-- LuaSnip 
----------------------------------------

require('telescope').setup { }
require('telescope').load_extension('fzf')
----------------------------------------

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

local lspconfig = require('lspconfig')
require'nvim-lsp-installer'.setup {}

local function on_attach(client, bufnr)
	-- set up buffer keymaps, etc
end

lspconfig.tailwindcss.setup { on_attach = on_attach }
lspconfig.angularls.setup { on_attach = on_attach }
lspconfig.html.setup { on_attach = on_attach }
lspconfig.tsserver.setup { on_attach = on_attach }
lspconfig.pyright.setup { on_attach = on_attach }
lspconfig.eslint.setup { on_attach = on_attach }
lspconfig.intelephense.setup { on_attach = on_attach }
lspconfig.clangd.setup { on_attach = on_attach }

----------------------------------------
-- WhichKey
----------------------------------------
require('lualine').setup()
----------------------------------------


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
