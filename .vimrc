syntax on 
set ignorecase
set smartcase
set autoindent
set confirm
set number
set shiftwidth=4
set softtabstop=4
set expandtab
set laststatus=2
set showmode
set showcmd
set statusline=%F%m%r%h%w\ [%{&ff}]\ [%Y]\ [%l,%v][%p%%]\ [BUFFER=%n]\ %{strftime('%D')}\ %{strftime('%T')}

call plug#begin('~/.vim/plugged')
    Plug 'fcpg/vim-fahrenheit'
    Plug '/usr/bin/fzf'
    Plug 'junegunn/fzf.vim'
    Plug 'octol/vim-cpp-enhanced-highlight'
    Plug 'morhetz/gruvbox' 
    Plug 'easymotion/vim-easymotion'

call plug#end()

colorscheme fahrenheit

map  <Leader>f <Plug>(easymotion-bd-f)
nmap <Leader>f <Plug>(easymotion-overwin-f)
cmap <Leader>f <Plug>(easymotion-overwin-f)

map <Leader>pf :GFiles<CR>
map <Leader>pt :Tags<CR>
