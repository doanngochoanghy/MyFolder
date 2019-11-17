let mapleader = " "

autocmd! bufwritepost .vimrc source %
set mouse=a
noremap <C-Z> :update<CR>
vnoremap <C-Z> <C-C>:update<CR>
inoremap <C-Z> <C-O>:update<CR>
map <c-j> <c-w>j
map <c-k> <c-w>k
map <c-l> <c-w>l
map <c-h> <c-w>h
map gst :Gstatus<CR>
map gd :Gvdiffsplit<CR>
map gw :Gwrite<CR>
map gcm :Gcommit<CR>
map gp :Gpush<CR>
vnoremap < <gv  " better indentation
vnoremap > >gv  " better indentation
vnoremap <C-c> "+y
set colorcolumn=80
highlight ColorColumn ctermbg=233

" automatically rebalance windows on vim resize
autocmd VimResized * :wincmd =

" zoom a vim pane, <C-w>= to re-balance
nnoremap <leader>- :wincmd _<cr>:wincmd \|<cr>
nnoremap <leader>= :wincmd =<cr>


set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'
Plugin 'davidhalter/jedi-vim'
Plugin 'ervandew/supertab'
Plugin 'fatih/molokai'
Plugin 'itchyny/lightline.vim'
Plugin 'kien/ctrlp.vim'
Plugin 'scrooloose/nerdtree'
Plugin 'tomtom/tcomment_vim'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-surround'
Plugin 'auto-pairs'
Plugin 'dense-analysis/ale'
Plugin 'autozimu/LanguageClient-neovim'
Plugin 'Shougo/deoplete.nvim'
Plugin 'roxma/nvim-yarp'
Plugin 'roxma/vim-hug-neovim-rpc'
Plugin 'christoomey/vim-tmux-navigator'
Plugin 'benmills/vimux'
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
let NERDTreeWinSize = 22

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
nmap <leader>p :NERDTreeToggle<CR>
vmap <leader>p <Esc><leader>ngv

"tab navigation
nmap tn :tabnew<CR>
nmap tj :tabprevious<CR>
nmap tk :tabnext<CR>
nmap tt :tabnext<CR>
nmap th :tabfirst<CR>
nmap tl :tablast<CR>
nmap tm :tabmove<Space>
nmap te :tabedit<CR><C-p>
nmap <leader>t :!pytest -vs<CR>
nmap <leader>T :!pytest -vs %<CR>

" Split window
nmap ss :split<Return><C-w>w
nmap sv :vsplit<Return><C-w>w


let g:go_version_warning = 0
let g:neocomplete#enable_at_startup = 0
syntax enable  
let g:go_disable_autoinstall = 0
let g:jedi#completions_enabled = 0

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

let g:ale_fixers = {'python': [ 'yapf', 'autopep8','black', 'isort']}
let g:ale_linters = {'python': ['pyls']}
let g:ale_fix_on_save = 1
let g:ale_linters_explicit = 1
let g:ale_completion_enabled = 0
let g:ale_sign_column_always = 1
let g:ale_python_auto_pipenv = 1
let g:ale_python_pylint_auto_pipenv = 1
let g:ale_python_pycodestyle_auto_pipenv = 1
let g:ale_completion_max_suggestions = 20
let g:ale_change_sign_column_color = 1
let g:ale_open_list = 0

""" setup pylint_venv
" pip install pylint-venv
" Create file ~/.pylintrc
" init-hook="
"     from pylint_venv import inithook
"     inithook()"
" 
" 


set statusline+=%#warningmsg#
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
autocmd FileType python nnoremap <Leader>= :Autoformat<CR>:w<CR>
let g:autoformat_autoindent = 1
let g:ctrlp_custom_ignore = '\v[\/]\.(git|hg|svn)$'
let g:ctrlp_custom_ignore = 'env\|htmlcov'
set complete-=i

"""Settings LanguageClientServer
""" sudo pip install python-language-server
" set hidden

let g:LanguageClient_serverCommands = {'python' : ['pyls']}
source /home/ngochoang/.vim/bundle/LanguageClient-neovim/plugin/LanguageClient.vim
set rtp+=~/.vim/bundle/LanguageClient-neovim
let g:LanguageClient_autoStart = 1
nnoremap <silent> K :call LanguageClient#textDocument_hover()<CR>
nnoremap <silent> <Leader>d :call LanguageClient#textDocument_definition()<CR>
nnoremap <silent> <Leader>n :call LanguageClient#textDocument_references()<CR>
nnoremap <silent> <F2> :call LanguageClient#textDocument_rename()<CR>
let g:LanguageClient_selectionUI  = "location-list"


""" Settings deoplete
let g:deoplete#enable_at_startup = 1 "pip3 install --user pynvim"
let g:deoplete#ignore_sources = {}
let g:deoplete#ignore_sources._ = ['around', 'LanguageClient']

""" Settings supertab
let g:SuperTabDefaultCompletionType = "<c-n>"

""" Settings Vimux
" Run the current file with rspec
 map <Leader>rb :call VimuxRunCommand("clear; rspec " . bufname("%"))<CR>

 " Prompt for a command to run
 map <Leader>vp :VimuxPromptCommand<CR>

 " Run last command executed by VimuxRunCommand
 map <Leader>vl :VimuxRunLastCommand<CR>

 " Inspect runner pane
 map <Leader>vi :VimuxInspectRunner<CR>

 " Close vim tmux runner opened by VimuxRunCommand
 map <Leader>vq :VimuxCloseRunner<CR>

 " Interrupt any command running in the runner pane
 map <Leader>vx :VimuxInterruptRunner<CR>

 " Zoom the runner pane (use <bind-key> z to restore runner pane)
 map <Leader>vz :call VimuxZoomRunner()<CR>

let g:VimuxHeight = "30"
