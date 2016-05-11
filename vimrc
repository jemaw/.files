" Plugins{{{
let mapleader = "\<Space>"

set nocompatible
filetype off                  " required
 
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'gmarik/Vundle.vim'

Plugin 'octol/vim-cpp-enhanced-highlight'
Plugin 'tpope/vim-commentary'

Plugin 'terryma/vim-expand-region'
	vmap v <Plug>(expand_region_expand)
	vmap <C-v> <Plug>(expand_region_shrink)

Plugin 'ctrlpvim/ctrlp.vim'
  	let g:ctrlp_match_window = 'bottom,order:btt,min:1,max:20,results:20'
	nnoremap <leader>t :CtrlPTag<cr>
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

" cindent options:
set cindent shiftwidth=4
set cindent tabstop=4
set cindent noexpandtab

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
nnoremap <Leader>s :w<CR>
nnoremap <Leader>q :q<CR>
nnoremap <Leader>wq :wq<CR>
"nnoremap <Leader>Q :wq<CR>
" }}}
" Filetupe {{{

" Disable comment new line
au FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o

au FileType python setlocal formatprg=autopep8\ -
" }}}
" Buffers  {{{

set hidden
nnoremap <tab> <c-^>
nnoremap <c-j> :bp<CR> 
nnoremap <c-k> :bn<CR> 

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

function! MyFoldText1()
    let line = getline(v:foldstart)

    let nucolwidth = &fdc + &number * &numberwidth
    let windowwidth = winwidth(0) - nucolwidth - 3
    let foldedlinecount = v:foldend - v:foldstart

    " expand tabs into spaces
    let onetab = strpart('          ', 0, &tabstop)
    let line = substitute(line, '\t', onetab, 'g')

    let line = strpart(line, 0, windowwidth - 2 -len(foldedlinecount))
    let fillcharcount = windowwidth - len(line) - len(foldedlinecount)
    return line . '…' . repeat(" ",fillcharcount) . foldedlinecount . '…' . ' '
endfunction 

function! MyFoldText2() 
  let line = ' ' . substitute(getline(v:foldstart), '^\s*"\?\s*\|\s*"\?\s*{{' . '{\d*\s*', '', 'g') . ' '
  let lines_count = v:foldend - v:foldstart + 1
  let lines_count_text = '| ' . printf("%10s", lines_count . ' lines') . ' |'
  let foldchar = matchstr(&fillchars, 'fold:\zs.')
  let foldtextstart = strpart('+' . repeat(foldchar, v:foldlevel*2) . line, 0, (winwidth(0)*2)/3)
  let foldtextend = lines_count_text . repeat(foldchar, 8)
  let foldtextlength = strlen(substitute(foldtextstart . foldtextend, '.', 'x', 'g')) + &foldcolumn
  return foldtextstart . repeat(foldchar, winwidth(0)-foldtextlength) . foldtextend
endfunction


function! MyFoldText3() " 
    let suba = getline(v:foldstart)
    let suba = substitute(suba, '{{{\d\=\|}}}\d\=', '', 'g')
    let suba = substitute(suba, '\s*$', '', '')
    " let subb = getline(v:foldend)
    " let subb = substitute(subb, '{{{\d\=\|}}}\d\=', '', 'g')
    " let subb = substitute(subb, '^\s*', '', '')
    " let subb = substitute(subb, '\s*$', '', '')
    let lines = v:foldend - v:foldstart + 1
    let text = suba
    " if lines > 1 && strlen(subb) > 0
    "   let text .= ' ... '.subb
    " endif
    let fillchar = matchstr(&fillchars, 'fold:\zs.')
    if strlen(fillchar) == 0
      let fillchar = '-'
    endif
    let lines = repeat(fillchar, 4).' ' . lines . ' lines '.repeat(fillchar, 3)
    if has('float')
      let nuw = max([float2nr(log10(line('$')))+3, &numberwidth])
    else
      let nuw = &numberwidth
    endif
    let n = winwidth(winnr()) - &foldcolumn - nuw - strlen(lines)
    let text = text[:min([strlen(text), n])]
    if text[-1:] != ' '
      if strlen(text) < n
        let text .= ' '
      else
        let text = substitute(text, '\s*.$', '', '')
      endif
    endif
    let text .= repeat(fillchar, n - strlen(text))
    let text .= lines
    return text
  endfunction

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
language en_US
set tags=./tags;,tags;

" vim: fdm=marker:fdl=0
" }}}
