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
Plugin 'auto-pairs'
Plugin 'Shougo/neocomplete.vim'
Plugin 'fatih/molokai'
Plugin 'Shougo/neosnippet.vim'
Plugin 'Shougo/neosnippet-snippets'
Plugin 'scrooloose/nerdtree'
Plugin 'itchyny/lightline.vim'
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

"recursive fuzzy find
set path +=**

"lightline setup
set laststatus=2

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
let g:NERDTreeWinSize =20

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

" Note: It must be "imap" and "smap".  It uses <Plug> mappings.
 imap <C-k>     <Plug>(neosnippet_expand_or_jump)
 smap <C-k>     <Plug>(neosnippet_expand_or_jump)
 xmap <C-k>     <Plug>(neosnippet_expand_target)
"
" " SuperTab like snippets behavior.
" " Note: It must be "imap" and "smap".  It uses <Plug> mappings.
imap <expr><TAB>
 \ pumvisible() ? "\<C-n>" :
 \ neosnippet#expandable_or_jumpable() ?
 \    "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"
smap <expr><TAB> neosnippet#expandable_or_jumpable() ?
\ "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"

" For conceal markers.
if has('conceal')
  set conceallevel=2 concealcursor=niv
  endif
"
set rtp+=$GOROOT/misc/vim
filetype plugin indent on
syntax on

" vim-go improvements
set autowrite
map <C-n> :cnext<CR>
map <C-m> :cprevious<CR>
nnoremap <leader>a :cclose<CR>
autocmd FileType go nmap <leader>b  <Plug>(go-build)
autocmd FileType go nmap <leader>r  <Plug>(go-run)
autocmd FileType go nmap <leader>t  <Plug>(go-test)
autocmd FileType go nmap <Leader>c	<Plug>(go-coverage-toggle)
