let mapleader = " "

autocmd! bufwritepost .vimrc source %
" set mouse=a
noremap <C-Z> :update<CR>
vnoremap <C-Z> <C-C>:update<CR>
inoremap <C-Z> <C-O>:update<CR>
map <c-j> <c-w>j
map <c-k> <c-w>k
map <c-l> <c-w>l
map <c-h> <c-w>h
vnoremap < <gv  " better indentation
vnoremap > >gv  " better indentation
vnoremap <C-c> "+y
map <C-v> "+P
set tw=79   " width of document (used by gd)
set colorcolumn=80
highlight ColorColumn ctermbg=233

set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'
Plugin 'fatih/vim-go'
Plugin 'nsf/gocode', {'rtp': 'vim/'}
Plugin 'SirVer/ultisnips'
Plugin 'honza/vim-snippets'
Plugin 'Valloric/YouCompleteMe'
Plugin 'auto-pairs'
Plugin 'AndrewRadev/splitjoin.vim'
Plugin 'fatih/molokai'
Plugin 'scrooloose/nerdtree'
Plugin 'vim-syntastic/syntastic'
Plugin 'itchyny/lightline.vim'
Plugin 'tomtom/tcomment_vim'
Plugin 'kien/ctrlp.vim'
Plugin 'tpope/vim-surround'
Plugin 'davidhalter/jedi-vim'
Plugin 'Chiel92/vim-autoformat'


" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
syntax on
set relativenumber number
set tabstop=4 smarttab softtabstop=4 shiftwidth=4
set autoindent smartindent
set cursorline
set wildmenu showcmd showmatch
set incsearch
set background=light
set t_Co=256

"recursive fuzzy find
set path +=**

"lightline setup
set laststatus=2

" snippet for YCM
let g:UltiSnipsExpandTrigger="<c-k>"
let g:UltiSnipsJumpForwardTrigger="<c-n>"
let g:UltiSnipsJumpBackwardTrigger="<c-p>"

"save,edit and quit file
nmap <leader>q :q<CR>
nmap <leader>Q :q!<CR>
nmap <leader>e :edit<Space>
nmap <leader>w :w<CR>
vmap <leader>q <Esc><leader>qgv
vmap <leader>Q <Esc><leader>Q
vmap <leader>e <Esc><leader>e
vmap <leader>w <Esc><leader>wgv

"NERDTree navigation
nmap <leader>n :NERDTreeToggle<CR>
vmap <leader>n <Esc><leader>ngv

"tab navigation
nmap tn :tabnew<CR>
nmap tj :tabprevious<CR>
nmap tk :tabnext<CR>
nmap th :tabfirst<CR>
nmap tl :tablast<CR>
nmap tm :tabmove<Space>
nmap te :tabedit<Space>

let g:go_version_warning = 0
let g:neocomplete#enable_at_startup = 1
syntax enable  
let g:go_disable_autoinstall = 0

" Highlight
let g:go_highlight_functions = 1  
let g:go_highlight_methods = 1  
let g:go_highlight_structs = 1  
let g:go_highlight_operators = 1  
let g:go_highlight_types = 1
let g:go_highlight_fields = 1
let g:go_highlight_build_constraints = 1 
let g:go_highlight_function_calls = 1
let g:go_textobj_include_function_doc = 1

let g:molokai_original = 1
let g:rehash256 = 1
colorscheme molokai

set rtp+=$GOROOT/misc/vim
filetype plugin indent on
syntax on

" vim-go improvements
map <C-n> :cnext<CR>
map <C-m> :cprevious<CR>
nnoremap <Leader>a :cclose<CR>:lclose<CR>
autocmd FileType go nmap <Leader>b  <Plug>(go-build)
autocmd FileType go nmap <Leader>r  <Plug>(go-run)
autocmd FileType go nmap <Leader>t  <Plug>(go-test)
autocmd FileType go nmap <Leader>c	<Plug>(go-coverage-toggle)
autocmd FileType go nmap <Leader>i <Plug>(go-info)
let g:go_list_type = "quickfix"
let g:go_test_timeout = '10s'
let g:go_metalinter_enabled = ['vet', 'golint', 'errcheck']
" let g:go_fmt_command = "goimports"
let g:go_info_mode = 'guru' 
" let g:go_updatetime = 100

" let g:go_metalinter_autosave = 1
" let g:go_metalinter_autosave_enabled = ['vet', 'errcheck']
 let g:acp_enableAtStartup = 0
 " Use neocomplete.
 let g:neocomplete#enable_at_startup = 1
 " Use smartcase.
 let g:neocomplete#enable_smart_case = 1
 set completeopt-=preview
" let g:ale_fixers = {'python': ['black', 'isort', 'autopep8', 'yapf']}
" let g:ale_fix_on_save = 1
" let g:ale_completion_enabled = 1
let g:pymode_rope_goto_definition_bind = 'gd'
let g:pymode_trim_whitespaces = 1
let g:pymode_lint_on_write = 1
let g:python_highlight_all=1
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
autocmd FileType python nnoremap <Leader>= :Autoformat<CR>:w<CR>
let g:autoformat_autoindent = 1
