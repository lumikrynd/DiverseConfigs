" Use "source full/path/to/this/file" in real _vimrc

" cursor looks
let &t_SI = "\e[6 q" "Insert mode line
let &t_SR = "\e[1 q" "Replace mode blinking block
let &t_EI = "\e[2 q" "Normal mode block (technically when exiting insert or replace mode)

set wrap  "Makes sure word wrap works.
set linebreak "Doesn't wrap mid word

set scrolloff=10
set nu rnu " Line numbers
set guifont=lucida\ console:h16

set notimeout
set ignorecase

" set undodir=~/.vim/.undo//
" set backupdir=~/.vim/.backup//
" set directory=~/.vim/.swp//

set mouse=a

let mapleader = "\<Space>"
map <space> <NOP>
map <space><esc> <NOP>

" diverse keymaps
nnoremap , ;
nnoremap ; ,
nnoremap ´ `
nnoremap ´´ ``

" some yank preferences
nnoremap Y y$
nnoremap <Leader>y "+y
vnoremap <Leader>y "+y
nmap <Leader>Y "+Y
