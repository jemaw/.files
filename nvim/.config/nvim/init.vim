let mapleader = "\<Space>"

" plugins {{{

" plug begin {{{
if &compatible
  set nocompatible
endif

if empty(glob('~/.local/share/nvim/site/autoload/plug.vim'))
    !curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs
                \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd! VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.local/share/nvim/plugged')
" }}}

" Appearance {{{
Plug 'ryanoasis/vim-devicons'
Plug 'arecarn/vim-clean-fold'
Plug 'morhetz/gruvbox'
Plug 'chriskempson/base16-vim'
Plug 'NLKNguyen/papercolor-theme'
Plug 'sonph/onehalf' " could like nice with darker background
Plug 'jemaw/vim-noctwo'
Plug 'w0ng/vim-hybrid'
    let g:hybrid_custom_term_colors = 0
" Plug 'Yggdroot/indentLine'
"     let g:indentLine_concealcursor=''
"     let g:indentLine_setColors = 0

" }}}

" misc {{{
" Plug 'lilydjwg/colorizer'
Plug 'voldikss/vim-floaterm'
    let g:floaterm_position = 'center'
    let g:floaterm_keymap_prev   = '<F9>'
    let g:floaterm_keymap_next   = '<F10>'
    let g:floaterm_keymap_toggle = '<F11>'
    let g:floaterm_keymap_new = '<F12>'
Plug 'liuchengxu/vim-which-key'
    nnoremap <silent> <leader> :WhichKey '<Space>'<CR>
Plug 'romainl/vim-cool'
Plug 'ap/vim-buftabline'
    let g:buftabline_show = 1
Plug 'scrooloose/nerdtree'
    autocmd! bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
    nnoremap <leader>nn :NERDTreeToggle<cr>
    let NERDTreeMinimalUI = 0
    let g:NERDTreeDirArrowExpandable = ' '
    let g:NERDTreeDirArrowCollapsible = ' '
    let NERDTreeIgnore = ['\.pyc$', '^__pycache__$']
    Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'dbakker/vim-projectroot'
Plug 'airblade/vim-gitgutter'
    let g:gitgutter_sign_added='┃'
    let g:gitgutter_sign_modified='┃'
    let g:gitgutter_sign_removed='◢'
    let g:gitgutter_sign_removed_first_line='◥'
    let g:gitgutter_sign_modified_removed='◢'

Plug 'majutsushi/tagbar'
    nmap <F8> :TagbarToggle<CR>

Plug 'psliwka/vim-smoothie'

Plug 'tpope/vim-commentary'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'wellle/targets.vim'
Plug 'tpope/vim-fugitive'
    " nnoremap <Leader>// :Ggrep 

Plug 'ludovicchabant/vim-gutentags'
    let g:gutentags_ctags_tagfile = ".tags"
    let g:gutentags_file_list_command = {
     \ 'markers': {
         \ '.git': 'git ls-files',
         \ '.hg': 'hg files',
         \ },
     \ }
Plug 'MarcWeber/vim-addon-local-vimrc'
    let g:local_vimrc = {'names':['.lvimrc']}
" needed for latex syntax in vimwiki
Plug 'vim-scripts/SyntaxRange'      

Plug 'editorconfig/editorconfig-vim'
" }}}

" Autocompletion {{{

" source ~/.config/nvim/completion_ncm2.vim
source ~/.config/nvim/completion_coc.vim
" source ~/.config/nvim/completion_deoplete.vim

" }}}

" Snippets  {{{

Plug 'SirVer/ultisnips' ", {'on_i':1}
    " inoremap <silent> <expr> <CR> ncm2_ultisnips#expand_or("\<CR>", 'n')
    let g:UltiSnipsExpandTrigger = "<c-l>"
    let g:UltiSnipsJumpForwardTrigger	= "<c-l>"
    let g:UltiSnipsJumpBackwardTrigger	= "<c-h>"
    let g:ultisnips_python_style = "google"

Plug 'honza/vim-snippets' ", {'on_i':1}

" }}}

" Language Specific {{{
Plug 'numirias/semshi'
    function SemshiHighlights()
        if &background == "light"
            hi semshiParameterUnused ctermfg=12 guifg=#3e999f cterm=underline
            hi semshiSelf            ctermfg=None guifg=None
            hi semshiBuiltin         ctermfg=6 guifg=#0087af
            hi semshiImported        ctermfg=None cterm=bold guifg=None 
            hi semshiParameter ctermfg=12 guifg=#4271ae
        endif
    endfunction
    autocmd FileType python call SemshiHighlights()
    " autocmd FileType * hi Normal guibg=None

" python folding
Plug 'kalekundert/vim-coiled-snake'
    " let g:coiled_snake_set_foldtext = 0
    function! g:CoiledSnakeConfigureFold(fold)

        " Don't fold nested classes.
        if a:fold.type == 'class'
            let a:fold.max_level = 1
        
        elseif a:fold.type == 'doc'
            let a:fold.min_lines = 15

        " Don't fold nested functions, but do fold methods (i.e. functions 
        " nested inside a class).
        elseif a:fold.type == 'function'
            let a:fold.max_level = 1
            if get(a:fold.parent, 'type', '') == 'class'
                let a:fold.max_level = 2
            endif

        " Only fold imports if there are 3 or more of them.
        elseif a:fold.type == 'import'
            let a:fold.min_lines = 5
        endif

        " Don't fold anything if the whole program is shorter than 30 lines.
        if line('$') < 30
            let a:fold.ignore = 1
        endif

    endfunction




" Plug 'google/vim-ft-bzl'
Plug 'octol/vim-cpp-enhanced-highlight',{'for': 'cpp'}
" Plug 'mitsuhiko/vim-python-combined', {'for' : 'python'} 
Plug 'Vimjas/vim-python-pep8-indent'
Plug 'fatih/vim-go', {'for' : 'go'}
    " let g:go_fmt_command = "goimports"
    let g:go_fmt_fail_silently = 1
    let g:go_fmt_experimental = 1
    let g:go_fmt_autosave = 0
    let g:go_metalinter_autosave = 0
    let g:go_snippet_engine = "ultinsips"
    let g:go_metalinter_autosave_enabled = []
    let g:go_metalinter_enabled = []
    let g:go_asmfmt_autosave = 0
" Plug 'rust-lang/rust.vim'
Plug 'gabrielelana/vim-markdown'
Plug 'lervag/vimtex'
    if !exists('g:deoplete#omni#input_patterns')
        let g:deoplete#omni#input_patterns = {}
    endif
    let g:vimtex_fold_enabled = 1

" }}}

" Formatting {{{
Plug 'Chiel92/vim-autoformat'
    " let g:formatdef_clang = '"clang-format -style=\"{BasedOnStyle: llvm, IndentWidth: 4, PointerAlignment: Left}\""'
    " let g:formatters_cpp = ['clang']
    nnoremap <Leader>af :<C-u>Autoformat<CR>
    nnoremap <F3> :<C-u>Autoformat<CR>
    vnoremap <F3> :Autoformat<CR>
    vnoremap <Leader>af :Autoformat<CR>
    let g:formatters_python = ['yapf']
    " only autoformat for Specific filetypes
    let fts = ['go']
    " let fts = ['go', 'python']
    au BufWrite * if index(fts, &filetype) != -1 |:Autoformat| endif
" }}}

" file and buffer switching {{{

Plug 'junegunn/fzf', {'do': './install'}
Plug 'junegunn/fzf.vim'
    nnoremap <Leader>o :FZF<CR>
    nnoremap <Leader>g :GFiles<CR>
    nnoremap <Leader>p :Buffer<CR>

    function! s:fzf_statusline()
        " Override statusline as you like
        highlight fzf1 ctermfg=161 ctermbg=None
        highlight fzf2 ctermfg=7 ctermbg=None
        highlight fzf3 ctermfg=7 ctermbg=None
        setlocal statusline=%#fzf1#\ >\ %#fzf2#fz%#fzf3#f
    endfunction
    augroup fzf
        autocmd!
        autocmd FileType fzf tnoremap <buffer> <C-j> <Down>
        autocmd FileType fzf tnoremap <buffer> <C-k> <Up>
        autocmd User FzfStatusLine call <SID>fzf_statusline() 
    augroup END

    let $FZF_DEFAULT_OPTS .= ' --layout=reverse'

    " https://github.com/neovim/neovim/issues/9718#issuecomment-559573308
    function! CreateCenteredFloatingWindow()
        let width = min([&columns - 4, max([80, &columns - 20])])
        let height = min([&lines - 4, max([20, &lines - 10])])
        let top = ((&lines - height) / 2) - 1
        let left = (&columns - width) / 2
        let opts = {'relative': 'editor', 'row': top, 'col': left, 'width': width, 'height': height, 'style': 'minimal'}

        let top = "╭" . repeat("─", width - 2) . "╮"
        let mid = "│" . repeat(" ", width - 2) . "│"
        let bot = "╰" . repeat("─", width - 2) . "╯"
        let lines = [top] + repeat([mid], height - 2) + [bot]
        let s:buf = nvim_create_buf(v:false, v:true)
        call nvim_buf_set_lines(s:buf, 0, -1, v:true, lines)
        call nvim_open_win(s:buf, v:true, opts)
        set winhl=Normal:Floating
        let opts.row += 1
        let opts.height -= 2
        let opts.col += 2
        let opts.width -= 4
        call nvim_open_win(nvim_create_buf(v:false, v:true), v:true, opts)
        au BufWipeout <buffer> exe 'bw '.s:buf
    endfunction

    let g:fzf_layout = { 'window': 'call CreateCenteredFloatingWindow()' }


    command! -bang -nargs=* GGrep
    \ call fzf#vim#grep(
    \   'git grep --line-number '.shellescape(<q-args>), 0,
    \   fzf#vim#with_preview({'dir': systemlist('git rev-parse --show-toplevel')[0]}), <bang>0)
    nnoremap <Leader>/ :GGrep<CR>

" }}}

" Neomake {{{

Plug 'dense-analysis/ale'
    " for cpp use .lvimrc to set include dirs with following variable
    let g:ale_cpp_clang_options='-std=c++14 -Wall ' " -I/folder/to/include'
    let g:ale_lint_delay = 800
    let g:ale_echo_msg_format = '%linter%: %s'
    let g:ale_python_pylint_options = '--extension-pkg-whitelist=cv2'
    let g:ale_linters = {'cpp': ['clang'],
                \ 'python': ['pyflakes', 'pylint'],
                \ 'go' : ['go build'],
                \ 'lua': ['luacheck']}
    let g:ale_set_highlights = 0
    " let g:ale_set_quickfix = 1

" }}}

" Notes {{{
Plug 'vimwiki/vimwiki', {'branch' : 'dev'}
    let vimwiki_path = '$HOME/Mega/wiki/text/'
    let vimwiki_export_path = vimwiki_path.'../export/'
    let g:vimwiki_table_mappings = 0
    let g:vimwiki_global_ext = 0
    let g:vimwiki_folding = 'expr'
    let g:vimwiki_list = [{
                \ 'path': vimwiki_path,
                \ 'path_html': vimwiki_export_path,
                \ 'template_path': vimwiki_export_path.'assets/',
                \ 'template_default': 'default',
                \ 'template_ext': '.tpl',
                \ 'auto_export': 0,
                \ 'nested_syntaxes' : {'python': 'python', 'c++': 'cpp'},
                \ 'auto_toc': 0}]

    nnoremap <leader>wss :VimwikiSearch 
    imap <Plug>DisableNextS <Plug>VimwikiListNextSymbol
    imap <Plug>DisablePrevS <Plug>VimwikiListPrevSymbol
    imap <Plug>DisableToggle <Plug>VimwikiListToggle

" }}}

" plug end {{{

call plug#end()
filetype plugin indent on

" }}}

" After plugin conf {{{

" }}}

" }}}

" Line Wrap {{{

" Soft wraps lines without editing file
set wrap

" Stops words from being cut off during linebreak
set linebreak

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
" nnoremap <CR> :noh<CR><CR> 

" preview effects of substitute command
if has('nvim')
    set icm=split
endif


" }}}

" Appearance {{{

if !exists("g:syntax_on")
    syntax enable
endif
let term_profile=$TERM_BG
if term_profile == "light"
    set background=light
    try
        set termguicolors
        colorscheme PaperColor
        hi Conceal ctermfg=7 ctermbg=None
    catch
        colorscheme ron
    endtry
else
    set background=dark
    try 
        colorscheme noctwo
        " set termguicolors
        " colorscheme hybrid
    catch
        colorscheme desert
    endtry
endif

set nonumber
set norelativenumber

set laststatus=0
set noshowmode

" use normal block curosr
set guicursor=

" }}}

" Statusline {{{ 
" https://shapeshed.com/vim-statuslines/
function! GitBranch()
  return system("git rev-parse --abbrev-ref HEAD 2>/dev/null | tr -d '\n'")
endfunction

function! StatuslineGit()
  let l:branchname = GitBranch()
  return strlen(l:branchname) > 0?'  '.l:branchname.' ':''
endfunction

set statusline=
" TODO replave has nvim with exists function
" TODO colors
if has('nvim')
    set statusline+=%{fugitive#head()}
else
    set statusline+=%{StatuslineGit()}  " branch
endif
set statusline+=\ %f\                   " filename
set statusline+=\%m                     " modify
set statusline+=\%r                     " read only
" set statusline+=%#Normal#
set statusline+=%=                      " right side
" set statusline+=%##
set statusline+=%{S_gitgutter()}
set statusline+=\ %y                    " filetype
set statusline+=\ [%l/%L]               " line number/num lines
set statusline+=%#TabLine#
set statusline+=\ 

set rulerformat=%60(%=%{S_gitgutter()}\ %#Label#%{fugitive#head()}\ %#Identifier#%t%#Normal#\ %m\ [%l/%L]\ %y\ %)

" " }}}

" Folding {{{

" no unfold on { movements
set foldopen=hor,mark,percent,quickfix,search,tag,undo
set foldmethod=syntax
set foldnestmax=1
" set foldlevelstart=1
" set foldminlines=1

if &rtp =~ 'vim-clean-fold'
    set foldtext=clean_fold#fold_text('\ ')
else
    set foldtext=MyFoldText()
endif

" }}}

" Indent options {{{

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

set timeoutlen=300
set ttimeoutlen=0
inoremap kj <c-c>`^
inoremap kjs <c-c>`^:w<CR>

" terminal
if has('nvim')
    " jk conflitcts with ranger, esc conflicts with zsh vi mode
    " tnoremap kj <C-\><C-n>
    nnoremap <leader>t :sp<cr><C-w>j:resize 15<cr>:term<cr>
    tnoremap <C-\> <C-\><C-n>
    tnoremap <C-h> <C-\><C-n><C-w>h
    tnoremap <C-j> <C-\><C-n><C-w>j
    tnoremap <C-k> <C-\><C-n><C-w>k
    tnoremap <C-l> <C-\><C-n><C-w>l
    " tnoremap <Leader>. <C-\><C-n>gt
    " tnoremap <Leader>, <C-\><C-n>gT
endif

" nnoremap <Space> <NOP>

" easy saving
inoremap <c-s> <esc>:w<cr>
nnoremap <c-s> :w<cr>

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
nnoremap <leader>e :e **/*
nnoremap <leader>f :find *

" source vimrc
nnoremap <leader>cs :so $MYVIMRC<CR>
nnoremap <leader>ce :tabe<CR>:e $MYVIMRC<CR>

" }}}

" Buffers  {{{

set hidden
" buffer switching
" nnoremap <leader>p :b <C-d>
nnoremap <a-right> :bn<CR>
nnoremap <a-left> :bp<CR>
" quickswitch
nnoremap <bs> <c-^>

" }}}

" Autocommands {{{

augroup filetypes
    au!
    au FileType *       setlocal formatoptions-=c formatoptions-=r formatoptions-=o " Disable comment new line
    au FileType c       setlocal commentstring=//\ %s
    au FileType cpp     setlocal commentstring=//\ %s
    " au FileType python  setlocal fdm=indent formatprg=autopep8\ -
    au FileType python  setlocal formatprg=autopep8\ -
    au FileType python  nnoremap <leader>bp Oimport pdb; pdb.set_trace()<Esc>:w<CR>
    " au FileType python PyFoldEnable 
    " au FileType python setlocal foldnestmax=10
    au FileType tex     inoremap <buffer> <c-space> <esc>bi\<esc>ea
    " au Filetype python    vnoremap <buffer> gq gq:%retab!<CR>
    au Filetype vimwiki     UltiSnipsAddFiletypes vimwiki.tex
    au Filetype vimwiki     call SyntaxRange#Include('\$', '\$', 'tex') " for inline math greek symbols

    au FileType yaml setlocal ts=2 sts=2 sw=2 expandtab
    au BufRead,BufNewFile *.tf setlocal ts=2 sts=2 sw=2 expandtab
augroup END

augroup miscau
    autocmd!
    autocmd BufWinEnter,WinEnter term://* startinsert
    autocmd TermOpen * setlocal nonumber norelativenumber
augroup END

" }}}

" wildmenu {{{

set wildmenu 
set wildmode=full
set wildignore+=*.swp,.tags,*.bak,*.pyc,*.class,*.jar
set wildignore+=*.gif,*.png,*.jpg,*.ico
set wildignore+=*.pdf,*.psd
set wildignore+=node_modules/*

set wildignorecase

" }}}

" Misc {{{

" tag file name
set tags=./tags;,tags;

" automatically change working directory
set autochdir

" changes window title
set title

" use * clipboard
set clipboard+=unnamed

" somehow needed for gitgutter
set updatetime=100

" conceallevel used e.g. in latex
set conceallevel=2

" }}}

" gui {{{ 

set guioptions-=m  "remove menu bar
set guioptions-=T  "remove toolbar
set guioptions-=r  "remove right-hand scroll bar
set guioptions-=L  "remove left-hand scroll bar
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

" Functions {{{

" https://github.com/NerdyPepper/dotfiles/blob/master/vim/.vimrc
function! S_gitgutter()  " formatted git hunk summary for statusline
	if exists('b:gitgutter')
        if has_key(b:gitgutter, 'summary')
            let l:summary = b:gitgutter.summary
            if l:summary[0] != 0 || l:summary[1] != 0 || l:summary[2] != 0
                return ' +'.l:summary[0].' ~'.l:summary[1].' -'.l:summary[2].' '
            endif
        endif
	endif
	return ''
endfunction

" find include dir for cpp
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

" show highlight group https://gist.github.com/mattsacks/1544768
function! Syn()
  for id in synstack(line("."), col("."))
    echo synIDattr(id, "name")
  endfor
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
