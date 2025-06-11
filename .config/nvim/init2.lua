-- BOOTSTRAP lazy.nvim (auto-installs on first run)
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git", "clone", "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    lazypath
  })
end
vim.opt.rtp:prepend(lazypath)

-- BASIC OPTIONS
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.autoindent = true
vim.opt.cindent = true
vim.opt.confirm = true
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.shiftwidth = 4
vim.opt.softtabstop = 4
vim.opt.expandtab = true
vim.opt.laststatus = 2
vim.opt.showmode = true
vim.opt.showcmd = true
vim.opt.cursorline = true
vim.opt.autochdir = true
vim.opt.signcolumn = "yes"
vim.opt.clipboard:append("unnamedplus")
vim.opt.completeopt:remove("preview")

vim.g.mapleader = ' '
vim.g.nobackup = true
vim.g.nowritebackup = true
vim.g.noswapfile = true

-- LAZY.NVIM PLUGIN SETUP
require("lazy").setup({
  { "fcpg/vim-fahrenheit" },
  { "rhysd/vim-clang-format" },
  { "vim-airline/vim-airline" },
  { "vim-airline/vim-airline-themes" },
  { "neovim/nvim-lspconfig" },
  { "bluz71/vim-moonfly-colors", name = "moonfly" },
  { "airblade/vim-gitgutter" },
  { "ms-jpq/coq_nvim", branch = "coq" },
  { "subnut/nvim-ghost.nvim" },

  -- telescope
  { "nvim-telescope/telescope.nvim", dependencies = { "nvim-lua/plenary.nvim" } },
  { "nvim-telescope/telescope-fzf-native.nvim", build = "make", cond = vim.fn.executable("make") == 1 },
})

-- COLORSCHEME
vim.cmd.colorscheme("moonfly")

-- KEYMAPS (Telescope powered)
local builtin = require("telescope.builtin")
vim.keymap.set("n", "<leader>f", builtin.find_files, {})
vim.keymap.set("n", "<leader>F", builtin.git_files, {})
vim.keymap.set("n", "<leader>b", builtin.buffers, {})
vim.keymap.set("n", "<leader>e", builtin.commands, {})
vim.keymap.set("n", "<leader>a", builtin.live_grep, {})
vim.keymap.set("n", "<leader>w", ":w<CR>", { noremap = true })
vim.keymap.set("n", "<leader>q", ":q<CR>", { noremap = true })
vim.keymap.set("n", "gd", "<C-]>", { noremap = true })

-- LSP SETUP
local lspconfig = require("lspconfig")
lspconfig.clangd.setup({})
lspconfig.pylsp.setup({})
lspconfig.tsserver.setup({})

vim.keymap.set("n", "gr", require("telescope.builtin").lsp_references, {})
