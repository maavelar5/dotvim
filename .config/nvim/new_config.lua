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

  -- nvim-tree
  {"nvim-tree/nvim-tree.lua"},
  {"nvim-tree/nvim-web-devicons"},


  -- dart
  { "dart-lang/dart-vim-plugin" },

{
  "hrsh7th/nvim-cmp",
  event = "InsertEnter",
  dependencies = {
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-path",
    "hrsh7th/cmp-cmdline",
    "L3MON4D3/LuaSnip",
    "saadparwaiz1/cmp_luasnip",
    "rafamadriz/friendly-snippets",
    "onsails/lspkind-nvim", -- optional: adds icons
  },
  config = function()
    local cmp = require("cmp")
    local luasnip = require("luasnip")

    require("luasnip.loaders.from_vscode").lazy_load()

    cmp.setup({
      snippet = {
        expand = function(args)
          luasnip.lsp_expand(args.body)
        end,
      },
      mapping = {
        ["<C-j>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
        ["<C-k>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
        ["<CR>"] = cmp.mapping.confirm({ select = true }),
        ["<Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_next_item()
          elseif luasnip.expand_or_jumpable() then
            luasnip.expand_or_jump()
          else
            fallback()
          end
        end, { "i", "s" }),
        ["<S-Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_prev_item()
          elseif luasnip.jumpable(-1) then
            luasnip.jump(-1)
          else
            fallback()
          end
        end, { "i", "s" }),
      },
      sources = cmp.config.sources({
        { name = "nvim_lsp" },
        { name = "luasnip" },
      }, {
        { name = "buffer" },
        { name = "path" },
      }),
      formatting = {
        format = require("lspkind").cmp_format({
          mode = "symbol_text",
          maxwidth = 50,
          ellipsis_char = "...",
        }),
      },
      window = {
        completion = cmp.config.window.bordered(),
        documentation = cmp.config.window.bordered(),
      },
    })
  end,
}
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
vim.keymap.set("n", "gr", require("telescope.builtin").lsp_references, {})

-- LSP SETUP
local lspconfig = require("lspconfig")
lspconfig.clangd.setup({})
lspconfig.pylsp.setup({})
-- lspconfig.tsserver.setup({})


require("nvim-tree").setup({
  view = {
    width = 30,
    relativenumber = true,
  },
  renderer = {
    icons = {
      show = {
        git = true,
        folder = true,
        file = true,
        folder_arrow = true,
      },
    },
  },
  filters = {
    dotfiles = false,
  },
})

vim.keymap.set("n", "<f12>", require("nvim-tree.api").tree.toggle, { noremap = true })

local lspconfig = require("lspconfig")
local capabilities = require("cmp_nvim_lsp").default_capabilities()

lspconfig.dartls.setup({
  capabilities = capabilities,
  on_attach = function(_, bufnr)
    print("✅ Dart LSP attached with nvim-cmp")
  end,
})

vim.api.nvim_create_autocmd("BufWritePost", {
  pattern = "*.dart",
  callback = function()
    vim.fn.jobstart({ "dart", "format", vim.fn.expand("%") }, {
      stdout_buffered = true,
      on_exit = function(_, code)
        if code == 0 then
          vim.cmd("edit!")  -- reload buffer after formatting
        else
          vim.notify("dart format failed", vim.log.levels.ERROR)
        end
      end,
    })
  end,
})


vim.keymap.set("n", "<leader>l", function() vim.lsp.buf.code_action() end, { desc = "LSP Code Action" })


