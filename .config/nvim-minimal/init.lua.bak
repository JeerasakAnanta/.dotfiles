-- ============================================================
-- Jeerasak's minimal fast nvim config (target: startup < 30ms)
-- ============================================================

-- 1) Options ------------------------------------------------
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.mouse = "a"
vim.opt.clipboard = "unnamedplus"
vim.opt.expandtab = true
vim.opt.shiftwidth = 2
vim.opt.tabstop = 2
vim.opt.smartindent = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.termguicolors = true
vim.opt.scrolloff = 8
vim.opt.updatetime = 200
vim.opt.timeoutlen = 300
vim.opt.undofile = true
vim.opt.signcolumn = "yes"
vim.opt.completeopt = { "menu", "menuone", "noselect" }

-- disable unused builtins = faster + lighter
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.g.loaded_man = 1
vim.g.loaded_zipPlugin = 1
vim.g.loaded_tarPlugin = 1
vim.g.loaded_tutor_mode_plugin = 1

-- 2) Keymaps ------------------------------------------------
local map = vim.keymap.set
map("n", "<Esc>", "<cmd>nohlsearch<CR>")          -- clear search highlight
map("n", "<C-s>", "<cmd>w<CR>")
map("n", "<C-q>", "<cmd>q<CR>")
map("n", "J", "mzJ`z")                             -- keep cursor when joining lines
map("n", "<C-d>", "<C-d>zz")
map("n", "<C-u>", "<C-u>zz")
map("n", "n", "nzzzv")
map("n", "N", "Nzzzv")
map("v", "J", ":m '>+1<CR>gv=gv")                  -- move selection down
map("v", "K", ":m '<-2<CR>gv=gv")                  -- move selection up
map("x", "<leader>p", '"_dP')                      -- paste without yanking

-- 3) Plugins (lazy.nvim, only essentials) -------------------
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.uv.fs_stat(lazypath) then
  vim.fn.system({
    "git", "clone", "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git", "--branch=stable", lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  -- colorscheme (tiny, fast)
  { "folke/tokyonight.nvim", lazy = false, priority = 1000 },

  -- statusline written in lua, ~0ms
  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    opts = { options = { section_separators = "", component_separators = "" } },
  },

  -- syntax highlighting (lazy-loaded per filetype)
  {
    "nvim-treesitter/nvim-treesitter",
    event = { "BufReadPre", "BufNewFile" },
    build = ":TSUpdate",
    opts = {
      ensure_installed = {},   -- install on demand with :TSInstall <lang>
      auto_install = true,
      highlight = { enable = true },
    },
  },

  -- fuzzy find files / grep
  {
    "ibhagwan/fzf-lua",
    cmd = { "FzfLua" },
    keys = {
      { "<leader>ff", function() require("fzf-lua").files() end },
      { "<leader>fg", function() require("fzf-lua").live_grep() end },
      { "<leader>fb", function() require("fzf-lua").buffers() end },
    },
  },

  -- LSP (built-in nvim 0.11 API only — no heavy framework)
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      local maplsp = vim.keymap.set
      vim.diagnostic.config({ virtual_text = true })
      vim.api.nvim_create_autocmd("LspAttach", {
        callback = function(args)
          maplsp("n", "gd", vim.lsp.buf.definition, { buffer = args.buf })
          maplsp("n", "K", vim.lsp.buf.hover, { buffer = args.buf })
          maplsp("n", "gr", vim.lsp.buf.references, { buffer = args.buf })
          maplsp("n", "<leader>rn", vim.lsp.buf.rename, { buffer = args.buf })
          maplsp("n", "<leader>ca", vim.lsp.buf.code_action, { buffer = args.buf })
        end,
      })
      -- install servers you need via :Mason or system packages, e.g.:
      -- vim.lsp.config("pyright", {}); vim.lsp.enable("pyright")
    end,
  },
}, {
  defaults = { lazy = true },        -- lazy-load everything by default
  install = { colorscheme = { "tokyonight" } },
  performance = {
    rtp = { disabled_plugins = { "gzip", "tarPlugin", "tohtml", "tutor", "zipPlugin" } },
  },
})

vim.cmd.colorscheme("tokyonight")
