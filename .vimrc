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
Plugin 'Xuyuanp/nerdtree-git-plugin'
Plugin 'airblade/vim-gitgutter'
Plugin 'auto-pairs'
Plugin 'davidhalter/jedi-vim'
Plugin 'benmills/vimux'
Plugin 'christoomey/vim-tmux-navigator'
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'ervandew/supertab'
Plugin 'fatih/molokai'
Plugin 'itchyny/lightline.vim'
Plugin 'neoclide/coc.nvim', {'branch': 'release'}
Plugin 'ryanoasis/vim-devicons'
Plugin 'scrooloose/nerdtree'
Plugin 'tiagofumo/vim-nerdtree-syntax-highlight'
Plugin 'tomtom/tcomment_vim'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-surround'
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
autocmd FileType json syntax match Comment +\/\/.\+$+

"recursive fuzzy find
set path +=**

"lightline setup
set laststatus=2
let NERDTreeWinSize = 20

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


let g:molokai_original = 1
let g:rehash256 = 1
colorscheme molokai

set rtp+=$GOROOT/misc/vim
filetype plugin indent on
syntax on

set statusline+=%#warningmsg#
set statusline+=%*
set statusline^=%{coc#status()}


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
let g:NERDTreeShowIgnoredStatus = 0
let g:ctrlp_show_hidden = 1
set wildignore+=*/.git/*,*/.hg/*,*/.svn/*,*/.env/*,*.sw*       " Linux/MacOSX
let g:NERDTreeRespectWildIgnore = 1
set updatetime=100

" Cocnvim settings
nmap <leader>r <Plug>(coc-rename)
nmap <leader>d <Plug>(coc-definition)
nmap <leader>i :call CocAction("runCommand", "python.sortImports")<CR> 
nmap <leader>r <Plug>(coc-references)
nmap <leader>m <Plug>(coc-diagnostic-next)
  
