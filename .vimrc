syntax on 
set ignorecase
set smartcase
set autoindent
set cindent
set confirm
set number
set shiftwidth=4
set softtabstop=4
set expandtab
set laststatus=2
set showmode
set showcmd
set relativenumber
set nobackup
set nowritebackup
set cursorline
"set statusline=%F%m%r%h%w\ [%{&ff}]\ [%Y]\ [%l,%v][%p%%]\ [BUFFER=%n]\ %{strftime('%D')}\ %{strftime('%T')}
"set statusline=%F%m%h%w\ [%{&ff}]\ [%Y]\ [%l,%v][%p%%]\ [%{strftime('%D')}]\ [%{strftime('%T')}]
set nobackup
set nowritebackup

let g:cpp_class_scope_highlight = 1
let g:cpp_member_variable_highlight = 1
let g:cpp_class_decl_highlight = 1
let g:cpp_posix_standard = 1
let g:cpp_experimental_template_highlight = 1
let g:cpp_concepts_highlight = 1

let g:ycm_confirm_extra_conf = 0

set encoding=utf-8

call plug#begin('~/.vim/plugged')
    Plug '/usr/bin/fzf'
    Plug 'junegunn/fzf.vim'
    Plug 'fcpg/vim-fahrenheit'
    "Plug 'ajh17/VimCompletesMe'
    Plug 'rhysd/vim-clang-format'
    Plug 'prabirshrestha/vim-lsp'
    Plug 'vim-airline/vim-airline'
    Plug 'prabirshrestha/async.vim'
    Plug 'justinmk/vim-syntax-extra'
    Plug 'easymotion/vim-easymotion'
    Plug 'vim-airline/vim-airline-themes'
    Plug 'prabirshrestha/asyncomplete.vim'
    Plug 'prabirshrestha/asyncomplete-lsp.vim'
call plug#end()

colorscheme fahrenheit

let g:ycm_collect_identifiers_from_tags_files=1
let g:ycm_autoclose_preview_window_after_insertion=1
"let g:airline_section_b = '%{strftime("%d/%m/%y %H:%M")}'
let g:ycm_key_list_stop_completion = ['<CR>']

let mapleader = "\<Space>"

inoremap jj <Esc>
"inoremap ` <Esc>
"vnoremap ` <Esc>

map  <Leader>a <Plug>(easymotion-bd-f)
nmap <Leader>a <Plug>(easymotion-overwin-f)

nmap <Leader>f :GFiles<CR>
nmap <Leader>t :Ag<CR>
nmap <Leader>b :Buffers<CR>

nmap <Leader>w :write<CR>
nmap <Leader>q :q!<CR>

nmap <Leader>2 :split<CR><C-w>w:GFiles<CR>
nmap <Leader>3 :vsplit<CR><C-w>w:GFiles<CR>
nmap <Leader>1 :only<CR>
nmap <Leader>0 :close<CR>
nmap <Leader>o <C-w>w
nmap <Leader>v :e ~/.vimrc<CR>

nmap <Leader>e :Files 

nmap <Leader>g :LspWorkspaceSymbol<CR>
nmap <Leader>n :LspNextDiagnostic<CR>

nmap <Leader>s :BLines<CR>

inoremap {<CR>  {<CR>}<Esc>O
inoremap (<CR>  (<CR>)<Esc>O
inoremap [<CR>  [<CR>]<Esc>O

autocmd BufWritePre *.h :ClangFormat
autocmd BufWritePre *.c :ClangFormat
autocmd BufWritePre *.cpp :ClangFormat

let g:ycm_clangd_binary_path = "/usr/bin/clangd"

"autocmd FileType vim let b:vcm_tab_complete = 'vim'

inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
inoremap <expr> <cr>    pumvisible() ? "\<C-y>" : "\<cr>"

let g:asyncomplete_auto_completeopt = 1

if executable('clangd')
    augroup lsp_clangd
        autocmd!
        autocmd User lsp_setup call lsp#register_server({
                    \ 'name': 'clangd',
                    \ 'cmd': {server_info->['clangd']},
                    \ 'whitelist': ['c', 'cpp', 'objc', 'objcpp'],
                    \ })
        autocmd FileType c setlocal omnifunc=lsp#complete
        autocmd FileType cpp setlocal omnifunc=lsp#complete
        autocmd FileType objc setlocal omnifunc=lsp#complete
        autocmd FileType objcpp setlocal omnifunc=lsp#complete
    augroup end
endif

set guioptions-=m
set guioptions-=T
set guioptions-=r
