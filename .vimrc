let mapleader = " "
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
" Plugin 'Shougo/neocomplete.vim'
Plugin 'Valloric/YouCompleteMe'
Plugin 'auto-pairs'
Plugin 'AndrewRadev/splitjoin.vim'
Plugin 'fatih/molokai'
Plugin 'scrooloose/nerdtree'
Plugin 'itchyny/lightline.vim'
Plugin 'tomtom/tcomment_vim'
Plugin 'kien/ctrlp.vim'
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
nnoremap <leader>a :cclose<CR>
autocmd FileType go nmap <leader>b  <Plug>(go-build)
autocmd FileType go nmap <leader>r  <Plug>(go-run)
autocmd FileType go nmap <leader>t  <Plug>(go-test)
autocmd FileType go nmap <Leader>c	<Plug>(go-coverage-toggle)
autocmd FileType go nmap <Leader>i <Plug>(go-info)
let g:go_list_type = "quickfix"
let g:go_test_timeout = '10s'
let g:go_metalinter_enabled = ['vet', 'golint', 'errcheck']
" let g:go_fmt_command = "goimports"
let g:go_info_mode = 'gocode' 
" let g:go_updatetime = 100

" let g:go_metalinter_autosave = 1
" let g:go_metalinter_autosave_enabled = ['vet', 'errcheck']
 let g:acp_enableAtStartup = 0
 " Use neocomplete.
 let g:neocomplete#enable_at_startup = 1
 " Use smartcase.
 let g:neocomplete#enable_smart_case = 1
 " Set minimum syntax keyword length.
"  let g:neocomplete#sources#syntax#min_keyword_length = 3

"  " Plugin key-mappings.
"  inoremap <expr><C-g>     neocomplete#undo_completion()
"  inoremap <expr><C-l>     neocomplete#complete_common_string()
"
"  " Recommended key-mappings.
"  " <CR>: close popup and save indent.
"  inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
"  function! s:my_cr_function()
"      return neocomplete#close_popup() . "\<CR>"
"  endfunction
"  " <TAB>: completion.
"  inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
"  " <C-h>, <BS>: close popup and delete backword char.
"  inoremap <expr><C-h> neocomplete#smart_close_popup()."\<C-h>"
"  inoremap <expr><BS> neocomplete#smart_close_popup()."\<C-h>"
"  inoremap <expr><C-y>  neocomplete#close_popup()
"  inoremap <expr><C-e>  neocomplete#cancel_popup()

 " Go related mappings
 " au FileType go nmap <Leader>i <Plug>(go-info)
 " au FileType go nmap <Leader>gd <Plug>(go-doc)
 " au FileType go nmap <Leader>r <Plug>(go-run)
 " au FileType go nmap <Leader>b <Plug>(go-build)
 " au FileType go nmap <Leader>t <Plug>(go-test)
 " au FileType go nmap gd <Plug>(go-def-tab)
