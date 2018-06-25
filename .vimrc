syntax on
colorscheme desert 
set relativenumber
set tabstop=4 smarttab softtabstop=4 shiftwidth=4
set autoindent smartindent
set cursorline
filetype indent on
set wildmenu showcmd showmatch
set incsearch 
map <Tab> <C-W>w set path+=**
:nnoremap <F5> :buffers<CR>:buffer<Space>
:nnoremap <S-F10> :w<CR>:!clear;scalac %;scala %:r<CR>
map! <F3> <C-R>=strftime('%c')<CR>
"map <C-C> <Esc>
let g:AutoPairsFlyMode = 1
