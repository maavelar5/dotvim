syntax on 
set ignorecase
set smartcase
set autoindent
"set confirm
set number
set shiftwidth=4
set softtabstop=4
set expandtab
set laststatus=2
"set showmode
"set showcmd
set relativenumber
set nobackup
set nowritebackup
set cursorline
"set statusline=%F%m%r%h%w\ [%{&ff}]\ [%Y]\ [%l,%v][%p%%]\ [BUFFER=%n]\ %{strftime('%D')}\ %{strftime('%T')}
set nobackup
set nowritebackup

let g:cpp_class_scope_highlight = 1
let g:cpp_member_variable_highlight = 1
let g:cpp_class_decl_highlight = 1
let g:cpp_posix_standard = 1
let g:cpp_experimental_template_highlight = 1
let g:cpp_concepts_highlight = 1

call plug#begin('~/.vim/plugged')
    Plug 'fcpg/vim-fahrenheit'
    Plug '/usr/bin/fzf'
    Plug 'junegunn/fzf.vim'
    Plug 'easymotion/vim-easymotion'
    Plug 'pangloss/vim-javascript' 
    Plug 'fxn/vim-monochrome'
    Plug 'octol/vim-cpp-enhanced-highlight'
    "Plug 'morhetz/gruvbox' 
    "Plug 'ycm-core/YouCompleteMe'
    "Plug 'vim-airline/vim-airline'
    "Plug 'ajh17/VimCompletesMe'
call plug#end()

colorscheme fahrenheit
"colorscheme monochrome

"let g:ycm_collect_identifiers_from_tags_files=1
"let g:ycm_autoclose_preview_window_after_insertion=1
"let g:airline_section_b = '%{strftime("%d/%m/%y %H:%M")}'
"let g:ycm_key_list_stop_completion = ['<CR>']

let mapleader = "\<Space>"

inoremap jj <Esc>

map  <Leader>a <Plug>(easymotion-bd-f)
nmap <Leader>a <Plug>(easymotion-overwin-f)

nmap <Leader>f :GFiles<CR>
nmap <Leader>t :Tags<CR>
nmap <Leader>b :Buffers<CR>

nmap <Leader>w :write<CR>
nmap <Leader>q :q<CR>

nmap <Leader>2 :split<CR>
nmap <Leader>3 :vsplit<CR>
nmap <Leader>1 :only<CR>
nmap <Leader>0 :close<CR>
nmap <Leader>o <C-w>w<CR>
nmap <Leader>v :e ~/.vimrc<CR>

nmap <Leader>j :tabnext<CR>
nmap <Leader>k :tabprevious<CR>

nmap <Leader>h :tabclose<CR>
nmap <Leader>l :tabnew<CR>

inoremap {<CR>  {<CR>}<Esc>O
inoremap (<CR>  (<CR>)<Esc>O
inoremap [<CR>  [<CR>]<Esc>O

autocmd BufWritePre *.cpp :%s/\s\+$//e
autocmd BufWritePre *.c :%s/\s\+$//e

nmap <F3> :call Compile_Arepg()<CR>
nmap <F4> :call Clean_Arepg()<CR>
nmap <F5> :call Run_Arepg()<CR>
nmap <F6> :call Clean_Arepg()<CR>:call Compile_Arepg()<CR>:call Run_Arepg()<CR>

function Run_Arepg()
    :!./debug/arepg
endfunction

function Compile_Arepg()
    :!make -j; 
endfunction

function Clean_Arepg()
    :!make clean; 
endfunction

autocmd FileType vim let b:vcm_tab_complete = 'vim'
