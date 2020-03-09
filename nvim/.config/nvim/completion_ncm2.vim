
 " ncm2 requires nvim-yarp
Plug 'ncm2/float-preview.nvim'
    function! DisableExtras()
      call nvim_win_set_option(g:float_preview#win, 'number', v:false)
      call nvim_win_set_option(g:float_preview#win, 'relativenumber', v:false)
      call nvim_win_set_option(g:float_preview#win, 'cursorline', v:false)
    endfunction

    autocmd User FloatPreviewWinOpen call DisableExtras()

Plug 'roxma/nvim-yarp'
Plug 'ncm2/ncm2'


 " enable ncm2 for all buffers
autocmd BufEnter * call ncm2#enable_for_buffer()

" :help Ncm2PopupOpen for more information
set completeopt=noinsert,menuone,noselect

set shortmess+=c

" CTRL-C doesn't trigger the InsertLeave autocmd . map to <ESC> instead.
inoremap <c-c> <ESC>

" When the <Enter> key is pressed while the popup menu is visible, it only
" hides the menu. 
" inoremap <expr> <CR> (pumvisible() ? "\<c-y>\<cr>" : "\<CR>")

" Use <TAB> to select the popup menu:
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

Plug 'ncm2/ncm2-bufword'
Plug 'ncm2/ncm2-path'
Plug 'ncm2/ncm2-jedi'
Plug 'ncm2/ncm2-tern'
Plug 'filipekiss/ncm2-look.vim'
Plug 'ncm2/ncm2-ultisnips'
Plug 'ncm2/ncm2-racer'
Plug 'ncm2/float-preview.nvim' " when neovim has floating window feature enable this and add set completopt+=preview
    let g:float_preview#docked = 0
" Plug 'ncm2/ncm2-match-highlight'


" latex support
au User Ncm2Plugin call ncm2#register_source({
        \ 'name' : 'vimtex',
        \ 'priority': 1,
        \ 'subscope_enable': 1,
        \ 'complete_length': 1,
        \ 'scope': ['tex'],
        \ 'matcher': {'name': 'combine',
        \           'matchers': [
        \               {'name': 'abbrfuzzy', 'key': 'menu'},
        \               {'name': 'prefix', 'key': 'word'},
        \           ]},
        \ 'mark': 'tex',
        \ 'word_pattern': '\w+',
        \ 'complete_pattern': g:vimtex#re#ncm,
        \ 'on_complete': ['ncm2#on_complete#omni', 'vimtex#complete#omnifunc'],
        \ })
