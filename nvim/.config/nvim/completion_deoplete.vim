
" if executable('languageclient')
"     Plug 'autozimu/LanguageClient-neovim', {'branch': 'next'}
"         let g:LanguageClient_serverCommands = {
"             \ 'python': ['/usr/bin/pyls'],
"             \ }
"         nnoremap <F5> :call LanguageClient_contextMenu()<CR>
" endif

set shortmess+=c
Plug 'Shougo/deoplete.nvim'
    " autocmd InsertLeave * if pumvisible() == 0 | pclose | endif
    let g:deoplete#enable_at_startup = 1
    let g:deoplete#enable_smart_case = 1
    " let g:deoplete#auto_completion_start_length = 2
    inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"


" Plug 'zchee/deoplete-jedi',{'for' : 'python'}
"     let deoplete#sources#jedi#show_docstring=1

Plug 'Shougo/neoinclude.vim' " slows down cpp

if executable('clang')
    " use .lvimrc with let g:deoplete#sources#clang#flags = ['-I/path/to/include']
    Plug 'zchee/deoplete-clang',{'for': ['cpp','c']} 
        let g:deoplete#sources#clang#libclang_path = '/usr/lib/libclang.so'
        let g:deoplete#sources#clang#clang_header = '/usr/lib/clang'
    " Plug 'tweekmonster/deoplete-clang2'
endif

if executable("gocode")
    Plug 'zchee/deoplete-go', {'do' : 'make'}
endif
if executable("racer")
    Plug 'sebastianmarkow/deoplete-rust'
    let g:deoplete#sources#rust#racer_binary=$CARGO_BIN.'/racer'
    let g:deoplete#sources#rust#rust_source_path=$RUST_SRC_PATH
endif

Plug 'ncm2/float-preview.nvim'
    function! DisableExtras()
      call nvim_win_set_option(g:float_preview#win, 'number', v:false)
      call nvim_win_set_option(g:float_preview#win, 'relativenumber', v:false)
      call nvim_win_set_option(g:float_preview#win, 'cursorline', v:false)
    endfunction

    autocmd User FloatPreviewWinOpen call DisableExtras()

    let g:float_preview#docked = 0
    set completeopt=noinsert,menuone,noselect

Plug 'tbodt/deoplete-tabnine', { 'do': './install.sh' }
