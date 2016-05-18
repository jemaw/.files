" Plugins{{{
let mapleader = "\<Space>"

set nocompatible
filetype off                  " required
 
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'gmarik/Vundle.vim'

Plugin 'octol/vim-cpp-enhanced-highlight'
Plugin 'tpope/vim-commentary'

Plugin 'scroloose/nerdtree'

Plugin 'prendradjaja/vim-vertigo'
	nnoremap <silent> <Leader>j :<C-U>VertigoDown n<CR>
	vnoremap <silent> <Leader>j :<C-U>VertigoDown v<CR>
	onoremap <silent> <Leader>j :<C-U>VertigoDown o<CR>
	nnoremap <silent> <Leader>k :<C-U>VertigoUp n<CR>
	vnoremap <silent> <Leader>k :<C-U>VertigoUp v<CR>
	onoremap <silent> <Leader>k :<C-U>VertigoUp o<CR>

Plugin 'terryma/vim-expand-region'
	vmap v <Plug>(expand_region_expand)
	vmap <C-v> <Plug>(expand_region_shrink)

Plugin 'majutsushi/tagbar'
	nmap <leader>tt :TagbarToggle<CR>
	nmap <leader>to :TagbarOpenAutoClose<CR>
Plugin 'xolox/vim-easytags'
Plugin 'xolox/vim-misc'

Plugin 'ctrlpvim/ctrlp.vim'
  	let g:ctrlp_match_window = 'bottom,order:btt,min:1,max:20,results:20'
	nnoremap <Leader>o :CtrlP<CR>
	nnoremap <Leader>p :CtrlPBuffer<CR>

Plugin 'Valloric/YouCompleteMe'
	nnoremap <leader>g :YcmCompleter GoTo<CR>
	let g:ycm_autoclose_preview_window_after_insertion = 1
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

Plugin 'SirVer/ultisnips'
Plugin 'honza/vim-snippets'

Plugin 'vimwiki/vimwiki'
	let g:vimwiki_list = [{
	  \ 'path': '$HOME/Dropbox/wiki',
	  \ 'template_path': '$HOME/Dropbox/wiki/templates',
	  \ 'template_default': 'default',
	  \ 'template_ext': '.html',
	  \ 'auto_export': 1,
	  \ 'nested_syntaxes' : {'python': 'python', 'c++': 'cpp'} }]
call vundle#end()            " required
filetype plugin indent on    " required
"}}}
" Line Wrap {{{

" Soft wraps lines without editing file
set wrap

" Stops words from being cut off during linebreak
set linebreak

" Set textwidth to 80 characters
set textwidth=80

" }}}
" Searching{{{

 "highlight search
set hlsearch
" Show search results as you type
set incsearch
" Ignore case in searches if query doesn't include capitals
set ignorecase
set smartcase

" search replace cs
vnoremap <silent> s //e<C-r>=&selection=='exclusive'?'+1':''<CR><CR>
    \:<C-u>call histdel('search',-1)<Bar>let @/=histget('search',-1)<CR>gv
omap s :normal vs<CR>

" This unsets the "last search pattern" register by hitting return
nnoremap <CR> :noh<CR><CR> 

" }}}
" Appearance {{{

syntax on
set background=dark
colorscheme noctu2

set number
set relativenumber

set laststatus=2

"folding settings
set foldmethod=syntax   "fold based on indent
set foldlevel=99
"set foldtext=MyFoldText2()

nnoremap <Leader><Leader> za
vnoremap <Leader><Leader> za

" }}}
" Indent options{{{

set ts=4 sts=4 sw=4 noexpandtab " default settings
" cindent options:
set cindent shiftwidth=4
set cindent tabstop=4
set cindent noexpandtab

set listchars=tab:»\ ,extends:›,precedes:‹,nbsp:·,trail:·

" }}}
" Movement {{{
set mouse=a
inoremap kj <ESC>
set ttimeoutlen=0

" Movement in long lines
nnoremap <silent> j gj
nnoremap <silent> k gk

" scrolling
map <C-U> 2<C-Y>
map <C-D> 2<C-E>

" Paragraph jumping not on empty lines
nnoremap <expr> { len(getline(line('.')-1)) > 0 ? '{+' : '{-'
nnoremap <expr> } len(getline(line('.')+1)) > 0 ? '}-' : '}+'

" }}}
" Mappings {{{
nnoremap <Space> <NOP>

" Split moving
nnoremap <C-h> <C-w>h
" nnoremap <C-j> <C-w>j
" nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

"Quickly paste from +reg
nnoremap <Leader>v "+p
vnoremap <Leader>v "+p

" avoid ex mode
nmap Q q
" }}}
" Filetupe {{{

" Disable comment new line
au FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o

au FileType python setlocal formatprg=autopep8\ -
au Filetype python vnoremap <buffer> gq gq:%retab!<CR>
au FileType python setlocal tabstop=4 noexpandtab 
" }}}
" Buffers  {{{

set hidden
nnoremap <tab> <c-^>
nnoremap <c-j> :bp<CR> 
nnoremap <c-k> :bn<CR> 

" }}}
" gui {{{ 
set guioptions-=m  "remove menu bar
set guioptions-=T  "remove toolbar
set guioptions-=r  "remove right-hand scroll bar
set guioptions-=L  "remove left-hand scroll bar
set guiheadroom=0
set guicursor+=a:blinkon0
if has("gui_running")
  colorscheme hybrid
endif
" Fix borders of fullscreen GUI
if has('gui_gtk') && has('gui_running')
  let s:border = synIDattr(synIDtrans(hlID('Normal')), 'bg', 'gui')
  exe 'silent !echo ''style "vimfix" { bg[NORMAL] = "' . escape(s:border, '#') . '" }'''.
			  \' > ~/.gtkrc-2.0'
  exe 'silent !echo ''widget "vim-main-window.*GtkForm" style "vimfix"'''.
			  \' >> ~/.gtkrc-2.0'
endif
" }}}
" Misc {{{

set wildmenu 
set encoding=utf-8 " set default encoding
"language en_US
set tags=./tags;,tags;

" }}}
" Functions{{{

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

" vim: fdm=marker:fdl=0
" }}}
