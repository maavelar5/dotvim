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
  { "nvim-telescope/telescope.nvim", dependencies = { "nvim-lua/plenary.nvim", "nvim-lua/popup.nvim" } },
  { "nvim-telescope/telescope-fzf-native.nvim", build = "make", cond = vim.fn.executable("make") == 1 },
  { "nvim-telescope/telescope-media-files.nvim" },
  {
      "kelly-lin/telescope-ag",
      dependencies = { "nvim-telescope/telescope.nvim" },
  },

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
  },
  { "nyoom-engineering/oxocarbon.nvim" },
  {
      "lewis6991/hover.nvim",
      config = function()
          require("hover").setup {
              init = function()
                  -- Add providers here
                  require("hover.providers.lsp")
                  -- require("hover.providers.gh")  -- GitHub
                  -- require("hover.providers.dap") -- Debug Adapter
                  -- etc.
              end,
              preview_opts = { border = "single" },
              title = true,
          }

          -- Keymaps
          vim.keymap.set("n", "<leader>k", require("hover").hover, { desc = "Hover" })
          vim.keymap.set("n", "<C-p>", function() require("hover").hover_switch("previous") end,
          { desc = "Previous Hover" })
          vim.keymap.set("n", "<C-n>", function() require("hover").hover_switch("next") end,
          { desc = "Next Hover" })
      end,
  },
  { "miikanissi/modus-themes.nvim", priority = 1000 },
  {
      "lervag/vimtex",
      ft = "tex",
      init = function()
          -- General
          vim.g.vimtex_view_method = "zathura"     -- or skim / sioyek / okular
          vim.g.vimtex_compiler_method = "latexmk"
          vim.g.vimtex_quickfix_mode = 0           -- don’t auto-open quickfix
          vim.g.vimtex_syntax_conceal_disable = 1  -- keep math symbols visible

          -- Compiler options
          vim.g.vimtex_compiler_latexmk = {
              build_dir = "build",
              options = {
                  "-pdf",
                  "-interaction=nonstopmode",
                  "-synctex=1",
              },
          }
      end
  },
  -- install without yarn or npm
  {
      "iamcco/markdown-preview.nvim",
      cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
      ft = { "markdown" },
      build = function() vim.fn["mkdp#util#install"]() end,
  },
})

vim.opt.background = "dark"

-- COLORSCHEME
vim.cmd.colorscheme("moonfly")
-- vim.cmd.colorscheme("oxocarbon")

-- vim.cmd.colorscheme("modus")

-- Make sure cursorline is enabled
-- vim.opt.cursorline = true

-- Set highlight for the current line
-- vim.api.nvim_set_hl(0, "CursorLine", { bg = "#000055" })  -- bright blue

-- KEYMAPS (Telescope powered)
local builtin = require("telescope.builtin")
vim.keymap.set("n", "<leader>F", builtin.find_files, {})
vim.keymap.set("n", "<leader>f", builtin.git_files, {})
vim.keymap.set("n", "<leader>b", builtin.buffers, {})
vim.keymap.set("n", "<leader>e", builtin.commands, {})
vim.keymap.set("n", "<leader>g", builtin.live_grep, {})
vim.keymap.set("n", "<leader>w", ":w<CR>", { noremap = true })
vim.keymap.set("n", "<leader>q", ":q<CR>", { noremap = true })
vim.keymap.set("n", "gd", "<C-]>", { noremap = true })
vim.keymap.set("n", "gr", require("telescope.builtin").lsp_references, {})


local telescope = require("telescope")

vim.keymap.set("n", "<leader>i", "<cmd>Telescope lsp_document_symbols<cr>", {
  desc = "Document symbols (imenu-like)"
})

local telescope_actions = require("telescope.actions")

require("telescope").setup({
  defaults = {
    mappings = {
      i = {
        ["<C-j>"] = telescope_actions.move_selection_next,
        ["<C-k>"] = telescope_actions.move_selection_previous,
      },
      n = {
        ["<C-j>"] = telescope_actions.move_selection_next,
        ["<C-k>"] = telescope_actions.move_selection_previous,
      },
    },
  },
  extensions = {
      media_files = {
          filetypes = {"png", "jpg", "mp4", "webm", "pdf"},
          find_cmd = "rg"
      }
  },
})

telescope.load_extension("ag")
telescope.load_extension('media_files')

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

-- init.lua (assuming you already set up clangd with nvim-lspconfig)
local patterns = { "*.c","*.h","*.cpp","*.hpp","*.cc","*.cxx","*.ixx" }
vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = patterns,
  callback = function()
    vim.lsp.buf.format({
      async = false,
      timeout_ms = 1000,
      filter = function(client) return client.name == "clangd" end,
    })
  end,
})
