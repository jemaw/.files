let mapleader = "\<Space>"
" plugins {{{

" dein begin{{{
if &compatible
  set nocompatible
endif

if has('nvim')
" install dein
if empty(glob('~/.config/nvim/dein/repos/github.com/Shougo/dein.vim'))
	silent !mkdir -p ~/.config/nvim/dein/repos/github.com/Shougo/dein.vim
	silent !git clone https://github.com/Shougo/dein.vim.git ~/.config/nvim/dein/repos/github.com/Shougo/dein.vim
	autocmd VimEnter * if !dein#util#_is_sudo() call dein#install() | call dein#remote_plugins() | nested source $MYVIMRC | endif
endif

if !empty(glob('~/.config/nvim/dein'))
set runtimepath^=~/.config/nvim/dein/repos/github.com/Shougo/dein.vim

call dein#begin(expand('~/.config/nvim/dein'))
call dein#add('Shougo/dein.vim')
" }}}

" misc {{{
call dein#add('tpope/vim-commentary')
call dein#add('wellle/targets.vim')
call dein#add('airblade/vim-gitgutter')

call dein#add('ludovicchabant/vim-gutentags')
	let g:gutentags_ctags_tagfile = ".tags"
call dein#add('MarcWeber/vim-addon-local-vimrc.git')
    let g:local_vimrc = {'names':['.lvimrc']}
" }}}

" Autocompletion {{{
call dein#add('Shougo/deoplete.nvim')
	autocmd InsertLeave * if pumvisible() == 0 | pclose | endif
	let g:deoplete#enable_at_startup = 1
	let g:deoplete#enable_smart_case = 1
	let g:deoplete#auto_completion_start_length = 2
	inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"

call dein#add('zchee/deoplete-jedi',{'on_ft' : 'python'})
	let deoplete#sources#jedi#show_docstring=1

call dein#add('Shougo/neoinclude.vim')
if executable('clang')
call dein#add('zchee/deoplete-clang',{'on_ft': ['cpp','c']} )
	let g:deoplete#sources#clang#libclang_path = '/usr/lib/libclang.so'
	let g:deoplete#sources#clang#clang_header = '/usr/lib/clang'
endif

if executable("gocode")
    call dein#add("zchee/deoplete-go", {'build' : 'make'})
endif

call dein#add('Shougo/neosnippet.vim',{'on_i': 1})
	if has('conceal')
	  set conceallevel=2 concealcursor=niv
	endif
	" let g:neosnippet#enable_completed_snippet = 1
	imap <C-l>     <Plug>(neosnippet_expand_or_jump)
	smap <C-l>     <Plug>(neosnippet_expand_or_jump)
	xmap <C-l>     <Plug>(neosnippet_expand_target)

call dein#add('Shougo/neosnippet-snippets')
	let g:neosnippet#snippets_directory = "~/.config/nvim/snippets"
" }}}

" Language Specific {{{
call dein#add('google/vim-ft-bzl')
call dein#add('octol/vim-cpp-enhanced-highlight',{'on_ft': 'cpp'})
" call dein#add('vim-scripts/a.vim', {'on_ft': 'cpp'})
call dein#add('mitsuhiko/vim-python-combined', {'on_ft' : 'python'})
call dein#add('fatih/vim-go', {'on_ft' : 'go'})
    " let g:go_fmt_command = "goimports"
    let g:go_fmt_fail_silently = 1
    let g:go_fmt_experimental = 1
    let g:go_metalinter_autosave = 0
    let g:go_snippet_engine = "neosnippet"
    let g:go_metalinter_autosave_enabled = []
    let g:go_metalinter_enabled = []
    let g:go_asmfmt_autosave = 0
" }}}

" file and buffer switching {{{
call dein#add('bling/vim-bufferline')
  let g:bufferline_echo = 0
  let g:bufferline_active_buffer_left = ' '
  let g:bufferline_active_buffer_right = ' '
  let g:bufferline_modified = ' +'
  set statusline=%r
  autocmd VimEnter * 
    \ let &statusline.='%{bufferline#refresh_status()}'
      \ .bufferline#get_status_string()
" }}}

" Neomake {{{

    call dein#add("neomake/neomake")
        autocmd! BufWritePost * Neomake
        let g:neomake_cpp_enabled_makers = []
	" call dein#add('w0rp/ale.git')
        " let g:ale_lint_delay = 600
        " let g:ale_echo_msg_format = '%linter%: %s'
        " let g:ale_sign_error = 'x'
        " let g:ale_sign_warning = '⚠'

" }}}

" Notes {{{
"TODO better mappings
call dein#add('vimwiki/vimwiki')
	let g:vimwiki_table_mappings = 0
	let g:vimwiki_folding = 'expr'
	let g:vimwiki_list = [{
				\ 'path': '$HOME/Dropbox/wiki',
				\ 'template_path': '$HOME/Dropbox/wiki/templates',
				\ 'template_default': 'default',
				\ 'template_ext': '.html',
				\ 'auto_export': 1,
				\ 'nested_syntaxes' : {'python': 'python', 'c++': 'cpp'} }]


" }}}

" dein end {{{
if dein#check_install()
  call dein#install()
endif

call dein#end()

endif
endif

filetype plugin indent on
" }}}

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
" This unsets the last search pattern register by hitting return
nnoremap <CR> :noh<CR><CR> 

" }}}
" Appearance {{{

syntax on
set background=dark
colorscheme noctu2

set number
set relativenumber

set laststatus=2
set noshowmode

" }}}
" Folding {{{

" no unfold on { movements
set foldopen=hor,mark,percent,quickfix,search,tag,undo
set foldmethod=syntax
set foldnestmax=1
" set foldlevelstart=0
" set foldminlines=1
set foldtext=FoldText()

" }}}
" Indent options{{{

set ts=4 sts=4 sw=4 expandtab

" cindent options
set cino=i0,N-s,g0

set list lcs=tab:\ \ ,extends:›,precedes:‹,nbsp:·,trail:·

" }}}
" Movement {{{
set mouse=a

" Movement in long lines
nnoremap <silent> j gj
nnoremap <silent> k gk

" cursor position stays the same
set nostartofline
set so=10
set sidescroll=1

" }}}
" Mappings {{{

set ttimeoutlen=0
inoremap kj <c-c>`^

" terminal
if has('nvim')
	" jk conflitcts with ranger, esc conflicts with zsh vi mode
	" tnoremap kj <C-\><C-n>
	tnoremap <C-\> <C-\><C-n>
	tnoremap <C-h> <C-\><C-n><C-w>h
	tnoremap <C-j> <C-\><C-n><C-w>j
	tnoremap <C-k> <C-\><C-n><C-w>k
	tnoremap <C-l> <C-\><C-n><C-w>l
	" tnoremap <Leader>. <C-\><C-n>gt
	" tnoremap <Leader>, <C-\><C-n>gT
	au BufWinEnter,WinEnter term://* startinsert
endif

nnoremap <Space> <NOP>

" Split moving
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

"Quickly paste from +reg
nnoremap <Leader>v "+p
vnoremap <Leader>v "+p
"Quickly yank to +reg
nnoremap <Leader>c "+y
vnoremap <Leader>c "+y

"easy yank to end of line
nnoremap Y y$

" toglle folds
nnoremap <Leader><Leader> za
vnoremap <Leader><Leader> za

" quick save and exit
nnoremap <leader>q :q<CR>
nnoremap <leader>w :w<CR>
nnoremap <leader>wq :wq<CR>

" easy search for visual selection
vnoremap // y/<C-R>"<CR>

" file opening
nnoremap <leader>e :e **/

" }}}
" Buffers  {{{

set hidden
" buffer switching
nnoremap <leader>p :b <C-d>
" quickswitch
nnoremap <leader>s :b#<cr>
nnoremap <bs> <c-^>

" }}}
" Filetupe {{{

au FileType *		setlocal formatoptions-=c formatoptions-=r formatoptions-=o " Disable comment new line
au FileType c		setlocal commentstring=//\ %s
au FileType cpp		setlocal commentstring=//\ %s
" au FileType cpp		call Findinclude()
au FileType python	setlocal fdm=indent formatprg=autopep8\ -
" au Filetype python	vnoremap <buffer> gq gq:%retab!<CR>
au FileType vimwiki		setlocal nowrap

au FileType yaml setlocal ts=2 sts=2 sw=2 expandtab
au BufRead,BufNewFile *.tf setlocal ts=2 sts=2 sw=2 expandtab

" }}}
" gui {{{ 

set guioptions-=m  "remove menu bar
set guioptions-=T  "remove toolbar
set guioptions-=r  "remove right-hand scroll bar
set guioptions-=L  "remove left-hand scroll bar
set guiheadroom=0
set guicursor+=a:blinkon0
if has("gui_running")
	try
		colorscheme hybrid
	catch /E185/
		colorscheme desert
	endtry
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
set autochdir

" }}}
" Backup {{{

"ensure directories exist
if empty(glob('~/.config/nvim/backup'))
	silent !mkdir -p ~/.config/nvim/backup
endif
if empty(glob('~/.config/nvim/swap'))
	silent !mkdir -p ~/.config/nvim/swap
endif

set backupdir=~/.config/nvim/backup//
set directory=~/.config/nvim/swap//
" set undodir=~/.vim/undo//
" set undofile

"}}}
" Functions{{{

"find include dir for cpp
function! Findinclude()
    let b:gitfolder = finddir('.git', ',;')
    echo "in findinclude"
    if b:gitfolder =~ ''
        let b:oldpath = &path
        let b:root =  split(b:gitfolder,'/')
        let b:path = join(b:root[0:-2], '/')
        set path=**;b:path
        let b:inc =  finddir('include')
        if b:inc =~ ''
            let b:neomake_cpp_clang_args = [ '-I'. b:inc ]
        endif
        set path=b:oldpath
    endif
endfunction

"Display the numbered registers, press a key and paste it to the buffer
function! Reg()
    reg
    echo "Register: "
    let char = nr2char(getchar())
    if char != "\<Esc>"
        execute "normal! \"".char."p"
    endif
    redraw
endfunction

" Foldtexts {{{
function! FoldText()
	let l:lpadding = &fdc
	redir => l:signs
	  execute 'silent sign place buffer='.bufnr('%')
	redir End
	let l:lpadding += l:signs =~ 'id=' ? 2 : 0

	if exists("+relativenumber")
	  if (&number)
		let l:lpadding += max([&numberwidth, strlen(line('$'))]) + 1
	  elseif (&relativenumber)
		let l:lpadding += max([&numberwidth, strlen(v:foldstart - line('w0')), strlen(line('w$') - v:foldstart), strlen(v:foldstart)]) + 1
	  endif
	else
	  if (&number)
		let l:lpadding += max([&numberwidth, strlen(line('$'))]) + 1
	  endif
	endif

	" expand tabs
	let l:start = substitute(getline(v:foldstart), '\t', repeat(' ', &tabstop), 'g')
	let l:end = substitute(substitute(getline(v:foldend), '\t', repeat(' ', &tabstop), 'g'), '^\s*', '', 'g')

	let l:info = ' (' . (v:foldend - v:foldstart) . ')'
	let l:infolen = strlen(substitute(l:info, '.', 'x', 'g'))
	let l:width = winwidth(0) - l:lpadding - l:infolen

	let l:separator = ' … '
	let l:separatorlen = strlen(substitute(l:separator, '.', 'x', 'g'))
	let l:start = strpart(l:start , 0, l:width - strlen(substitute(l:end, '.', 'x', 'g')) - l:separatorlen)
	" let l:text = l:start . ' … ' . l:end
	let l:text = l:start . '…'
	return l:text . repeat(' ', l:width - strlen(substitute(l:text, ".", "x", "g"))) . l:info
endfunction

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

" }}}
" Commands {{{

"Reg paste
command! -nargs=0 Reg call Reg()
" sudo write
cnoremap w!! w !sudo tee % >/dev/null

" }}}
" vim: fdm=marker:fdl=0:fml=1