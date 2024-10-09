local vim = vim

vim.g.ignorecase = true
vim.g.smartcase = true
vim.g.autoindent = true
vim.g.cindent = true
vim.g.confirm = true
vim.g.number = true
vim.g.shiftwidth=4
vim.g.softtabstop=4
vim.g.expandtab = true
vim.g.laststatus=2
vim.g.showmode = true
vim.g.showcmd = true
vim.g.relativenumber = true
vim.g.cursorline = true
vim.g.nobackup = true
vim.g.nowritebackup = true
vim.g.noswapfile = true

local Plug = vim.fn['plug#']

vim.call('plug#begin')
    Plug('/usr/bin/fzf')
    Plug('junegunn/fzf.vim')
    Plug('fcpg/vim-fahrenheit')
    Plug('rhysd/vim-clang-format')
    Plug('vim-airline/vim-airline')
    Plug('vim-airline/vim-airline-themes')
    Plug('neovim/nvim-lspconfig')
vim.call('plug#end')

-- Color schemes should be loaded after plug#end().
-- We prepend it with 'silent!' to ignore errors when it's not yet installed.
--
vim.g.mapleader = ' '

vim.g.fzf_layout = { right = '~50%' }  -- Adjust as needed
vim.g.fzf_preview_window = ''          -- Disable preview window

vim.api.nvim_set_keymap('n', '<leader>f', ':Files<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>w', ':w<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>b', ':Buffers<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>q', ':q<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', 'gd', '<C-]>', { noremap = true })

require'lspconfig'.clangd.setup{}

vim.opt.completeopt:remove("preview")

