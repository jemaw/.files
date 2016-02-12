" Plugins{{{
set nocompatible
filetype off                  " required

 
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'gmarik/Vundle.vim'

Plugin 'octol/vim-cpp-enhanced-highlight'

Plugin 'scrooloose/syntastic'
	let g:syntastic_cpp_compiler_options = '-std=c++11'

Plugin 'kien/ctrlp.vim'

Plugin 'Valloric/YouCompleteMe'
	let g:ycm_global_ycm_extra_conf = '~/.vim/bundle/YouCompleteMe/third_party/ycmd/cpp/ycm/.ycm_extra_conf.py' " you complete me conf
	let g:ycm_show_diagnostics_ui = 0
	if !exists("g:UltiSnipsJumpForwardTrigger")
	  let g:UltiSnipsJumpForwardTrigger = "<tab>"
	endif

	if !exists("g:UltiSnipsJumpBackwardTrigger")
	  let g:UltiSnipsJumpBackwardTrigger="<s-tab>"
	endif

	au InsertEnter * exec "inoremap <silent> " . g:UltiSnipsExpandTrigger     . " <C-R>=g:UltiSnips_Complete()<cr>"
	au InsertEnter * exec "inoremap <silent> " .     g:UltiSnipsJumpBackwardTrigger . " <C-R>=g:UltiSnips_Reverse()<cr>"

	autocmd CompleteDone * pclose

Plugin 'SirVer/ultisnips'
Plugin 'honza/vim-snippets'

call vundle#end()            " required
filetype plugin indent on    " required
"}}}

" Line Wrap {{{

" Soft wraps lines without editing file
set wrap

" Stops words from being cut off during linebreak
set linebreak

" Set textwidth to 80 characters
set textwidth=0
set nolist
set wrapmargin=0

" }}}

" Searching{{{

 "highlight search
set hlsearch

" Show search results as you type
set incsearch

" Ignore case in searches if query doesn't include capitals
set ignorecase
set smartcase

" This unsets the "last search pattern" register by hitting return
nnoremap <CR> :noh<CR><CR> 

" }}}

" Appearance {{{

syntax on
set background=dark
colorscheme noctu2

set number
set relativenumber

set laststatus=0

set foldmethod=marker

" }}}

" Indent options{{{

" cindent options:
set cindent shiftwidth=4
set cindent tabstop=4
set cindent noexpandtab

" }}}

" Movement {{{
inoremap kj <ESC>
set ttimeoutlen=0

" Movement in long lines
nnoremap <silent> j gj
nnoremap <silent> k gk

" Easily move to start/end of line
" nnoremap H 0
" vnoremap H 0
" nnoremap L $
" vnoremap L $

" za/az toggle folds
" ezpz to spam open/close folds now
" nmap az za

" scrolling
map <C-U> <C-Y><C-Y><C-Y><C-Y><C-Y><C-Y>
map <C-D> <C-E><C-E><C-E><C-E><C-E><C-E>

" }}}

" Filetupe {{{

" Disable comment new line
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o
" }}}

" Searching{{{

 "highlight search
set hlsearch

" Show search results as you type
set incsearch

" Ignore case in searches if query doesn't include capitals
set ignorecase
set smartcase

" This unsets the "last search pattern" register by hitting return
nnoremap <CR> :noh<CR><CR> 

" }}}

" Buffers  {{{

set hidden
nnoremap <tab> :bn<CR> 
nnoremap <s-tab> :bp<CR> 

" }}}

" functions{{{

function! g:UltiSnips_Complete()
  call UltiSnips#ExpandSnippet()
  if g:ulti_expand_res == 0
    if pumvisible()
      return "\<C-n>"
    else
      call UltiSnips#JumpForwards()
      if g:ulti_jump_forwards_res == 0
        return "\<TAB>"
      endif
    endif
  endif
  return ""
endfunction

function! g:UltiSnips_Reverse()
  call UltiSnips#JumpBackwards()
  if g:ulti_jump_backwards_res == 0
    return "\<C-P>"
  endif

  return ""
endfunction

"}}}

" Misc {{{

set clipboard+=unnamedplus
set encoding=utf-8 " set default encoding

" }}}
