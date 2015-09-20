source ~/.vim/vundlerc
"source ~/.vim/statuslinerc
source ~/.vim/mesniprc
source ~/.vim/lightlinerc







set encoding=utf-8 " set default encoding

"search"
set hlsearch

"numbers"
set relativenumber
set number 

"colors
syntax on
set background=dark
"let base16colorspace=256  " Access colors present in 256 colorspace
colorscheme noctu2
"set t_md=       "disable bold font

"cindent options:
set cindent shiftwidth=4
set cindent tabstop=4
set cindent noexpandtab


" inoremap jk <Esc>  
inoremap kj <ESC>
set ttimeoutlen=0

" navigation in long lines:
nnoremap <silent> j gj
nnoremap <silent> k gk
" set whichwrap+=<,>,h,l,[,] "last/next line with arrow and h/l 
" set backspace=2 " make backspace work like most other apps


set mouse=a " enable mouse in term

"This unsets the "last search pattern" register by hitting return
nnoremap <CR> :noh<CR><CR> 


let mapleader = "\<Space>"  " leaderkey

map <Leader>f :NERDTreeToggle<CR>

nnoremap <C-j> gT
nnoremap <C-k> gt

