let mapleader = "\<Space>"
" {{{ dein
if &compatible
  set nocompatible
endif

set runtimepath^=/home/jean/.config/nvim/dein/repos/github.com/Shougo/dein.vim

call dein#begin(expand('/home/jean/.config/nvim/dein'))
call dein#add('Shougo/dein.vim')

call dein#add('Shougo/deoplete.nvim')
	autocmd InsertLeave * if pumvisible() == 0 | pclose | endif
	let g:deoplete#enable_at_startup = 1
	let g:deoplete#enable_smart_case = 1
	let g:deoplete#auto_completion_start_length = 2
	" inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"

call dein#add('zchee/deoplete-jedi',{'on_ft' : 'python'})
	let deoplete#sources#jedi#show_docstring=1
call dein#add('rip-rip/clang_complete',{'on_ft': ['cpp','c'],'build' : 'make'})
	let g:clang_complete_auto = 0
	let g:clang_auto_select = 0
	let g:clang_omnicppcomplete_compliance = 0
	let g:clang_make_default_keymappings = 0
	let g:clang_use_library = 1
" call dein#add('zchee/deoplete-clang') "too slow somehow
" 	let g:deoplete#sources#clang#libclang_path = '/usr/lib/libclang.so'
" 	let g:deoplete#sources#clang#clang_header = '/usr/lib/clang'

call dein#add('Shougo/neosnippet.vim',{'on_i': 1})
	if has('conceal')
	  set conceallevel=2 concealcursor=niv
	endif
	" let g:neosnippet#enable_completed_snippet = 1
	imap <C-l>     <Plug>(neosnippet_expand_or_jump)
	smap <C-l>     <Plug>(neosnippet_expand_or_jump)
	xmap <C-l>     <Plug>(neosnippet_expand_target)
	imap <expr><TAB>
		\ pumvisible() ? "\<C-n>" :
		\ neosnippet#expandable_or_jumpable() ?
		\    "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"
	smap <expr><TAB> neosnippet#expandable_or_jumpable() ?
		\ "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"
	
" call dein#add('honza/vim-snippets',{'on_i':1})
" 	let g:neosnippet#disable_runtime_snippets = {
" 	\   '_' : 1,
" 	\ }
" 	let g:neosnippet#snippets_directory='~/.config/nvim/dein/repos/github.com/honza/vim-snippets/snippets'
call dein#add('Shougo/neosnippet-snippets',{'on_i': 1})

call dein#add('w0ng/vim-hybrid')
call dein#add('octol/vim-cpp-enhanced-highlight',{'on_ft': 'cpp'})
call dein#add('tpope/vim-commentary')
call dein#add('kana/vim-smartinput',{'on_i' :1})
call dein#add('rbgrouleff/bclose.vim')
call dein#add('francoiscabrol/ranger.vim')
	let g:ranger_map_keys = 0
	nnoremap <Leader>r :Ranger<CR>


" TODO replace with unite
call dein#add('rking/ag.vim',{'on_cmd': ['Ag','Ag!']})
call dein#add('ctrlpvim/ctrlp.vim',{'on_cmd' : ['CtrlP','CtrlPBuffer']})
  	let g:ctrlp_match_window = 'bottom,order:btt,min:1,max:30,results:30'
	let g:ctrlp_use_caching = 0
	nnoremap <Leader>o :CtrlP<CR>
	nnoremap <Leader>p :CtrlPBuffer<CR>



" call dein#add('xolox/vim-notes',{'on_cmd': 'Note'})
" 	let g:notes_directories = ['~/Dropbox/notes']
" 	let g:notes_suffix = '.md'
	" let g:notes_shadowdir = '~/Dropbox/notes/shadow'

" call dein#add('majutsushi/tagbar')
" 	nmap <leader>tt :TagbarToggle<CR>
" 	nmap <leader>to :TagbarOpenAutoClose<CR>
call dein#add('xolox/vim-easytags') " ,{'on_cmd' : 'write'})
call dein#add('xolox/vim-misc')

if dein#check_install()
  call dein#install()
endif

call dein#end()

filetype plugin indent on
" }}}
"{{{ Notes
" let notesdir = '~/Dropbox/notes/'
nnoremap <Leader>nm :e ~/Dropbox/notes/main.md<cr>
nnoremap <Leader>nn :e ~/Dropbox/notes/
nnoremap <Leader>nt :tabe ~/Dropbox/notes/main.md<cr>
nnoremap <Leader>ns :CtrlP ~/Dropbox/notes/<cr>
nnoremap <Leader>nf :e ~/Dropbox/notes/<cfile><cr>


"}}}
" {{{ Ag
" The Silver Searcher
if executable('ag')
	" Use ag over grep
	set grepprg=ag\ --nogroup\ --nocolor\ --ignore-case\ --column
	set grepformat=%f:%l:%c:%m,%f:%l:%m

	" Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
	let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'

endif
" }}}
" Line Wrap {{{

" Soft wraps lines without editing file
set wrap

" Stops words from being cut off during linebreak
set linebreak

" Set textwidth to 80 characters
"set textwidth=80

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

set laststatus=2

"folding settings
set foldmethod=syntax
set foldnestmax=1
"set foldlevel=99
set foldtext=NeatFoldText()

nnoremap <Leader><Leader> za
vnoremap <Leader><Leader> za

" }}}
" Indent options{{{

set ts=4 sts=4 sw=4 noexpandtab

set list lcs=tab:\ \ ,extends:›,precedes:‹,nbsp:·,trail:·

" }}}
" Movement {{{
set mouse=a
inoremap kj <ESC>
set ttimeoutlen=0

" Movement in long lines
nnoremap <silent> j gj
nnoremap <silent> k gk

" scrolling
" cursor position stays the same
"set nostartofline
set so=999
nnoremap <C-U> 4k
nnoremap <C-D> 4j
set sidescroll=1

" " Paragraph jumping not on empty lines
" nnoremap <expr> { len(getline(line('.')-1)) > 0 ? '{+' : '{-'
" nnoremap <expr> } len(getline(line('.')+1)) > 0 ? '}-' : '}+'

" }}}
" Mappings {{{
noremap ; :
noremap : ;

nnoremap <Space> <NOP>

" Split moving
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

"Quickly paste from +reg
nnoremap <Leader>v "+p
vnoremap <Leader>v "+p

" avoid ex mode
nmap Q q

"easy yank to end of line
nnoremap Y y$
" }}}
" Filetupe {{{


au FileType *		setlocal formatoptions-=c formatoptions-=r formatoptions-=o " Disable comment new line
au FileType c		setlocal commentstring=//\ %s
au FileType cpp		setlocal commentstring=//\ %s
au FileType python	setlocal fdm=indent formatprg=autopep8\ -
" au Filetype python	vnoremap <buffer> gq gq:%retab!<CR>
" }}}
" Buffers  {{{
set hidden
nnoremap <tab> <c-^>
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
set tags=./tags;,tags;

" }}}
"  Backup {{{
set backupdir=~/.vim/backup//
set directory=~/.vim/swap//
" set undodir=~/.vim/undo//
" set undofile
"}}}
" Functions{{{
function! NeatFoldText()
  let line = ' ' . substitute(getline(v:foldstart), '^\s*"\?\s*\|\s*"\?\s*{{' . '{\d*\s*', '', 'g') . ' '
  let lines_count = v:foldend - v:foldstart + 1
  let lines_count_text = '| ' . printf("%10s", lines_count . ' lines') . ' |'
  let foldchar = matchstr(&fillchars, 'fold:\zs.')
  let foldtextstart = strpart('+' . repeat(foldchar, v:foldlevel*2) . line, 0, (winwidth(0)*2)/3)
  let foldtextend = lines_count_text . repeat(foldchar, 8)
  let foldtextlength = strlen(substitute(foldtextstart . foldtextend, '.', 'x', 'g')) + &foldcolumn
  return foldtextstart . repeat(foldchar, winwidth(0)-foldtextlength) . foldtextend
endfunction

function! MyFoldText()
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
" }}}
" vim: fdm=marker:fdl=0
