local vim = vim

vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.autoindent = true
vim.o.cindent = true
vim.o.confirm = true
vim.o.number = true
vim.o.shiftwidth=4
vim.o.softtabstop=4
vim.o.expandtab = true
vim.o.laststatus=2
vim.o.showmode = true
vim.o.showcmd = true
vim.o.relativenumber = true
vim.o.cursorline = true
vim.g.nobackup = true
vim.g.nowritebackup = true
vim.g.noswapfile = true

vim.opt.relativenumber = true
vim.opt.number = true

local Plug = vim.fn['plug#']

vim.call('plug#begin')
    Plug('junegunn/fzf.vim')
    Plug('junegunn/fzf')
    Plug('fcpg/vim-fahrenheit')
    Plug('rhysd/vim-clang-format')
    Plug('vim-airline/vim-airline')
    Plug('vim-airline/vim-airline-themes')
    Plug('neovim/nvim-lspconfig')
    Plug('bluz71/vim-moonfly-colors', { as = 'moonfly'})
    -- Plug('rhysd/vim-clang-format')
    -- Plug('tpope/vim-fugitive')
    Plug('airblade/vim-gitgutter')
    Plug('ms-jpq/coq_nvim', {branch = "coq"})
vim.call('plug#end')

vim.opt.autochdir = true

vim.cmd [[colorscheme moonfly]]

-- Color schemes should be loaded after plug#end().
-- We prepend it with 'silent!' to ignore errors when it's not yet installed.
--
vim.g.mapleader = ' '

vim.g.fzf_layout = { right = '~50%' }  -- Adjust as needed
vim.g.fzf_preview_window = ''          -- Disable preview window

vim.api.nvim_set_keymap('n', '<leader>f', ':Files<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>F', ':GFiles<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>w', ':w<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>b', ':Buffers<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>q', ':q<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', 'gd', '<C-]>', { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>e', ':Commands<CR>', { noremap = true })
-- vim.api.nvim_set_keymap('i', '<C-p>', '<C-x><C-o>', { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>q', ':q<CR>', { noremap = true }) 
vim.api.nvim_set_keymap('n', '<leader>a', ':Ag<CR>', { noremap = true }) 

require'lspconfig'.clangd.setup{}
require'lspconfig'.pylsp.setup{}
require'lspconfig'.ts_ls.setup{} 

vim.opt.completeopt:remove("preview")

vim.opt.clipboard = vim.opt.clipboard + "unnamedplus"

vim.opt.signcolumn = "number"

vim.o.signcolumn="yes"
-- highlight SignColumn ctermbg=darkgray
--vim.g.gitgutter_sign_added = 'xx'
--vim.g.gitgutter_sign_modified = 'yy'
--vim.g.gitgutter_highlight_lines = 1
