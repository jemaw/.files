" vombato.vim
" ------------------------------------------------------------------------------
" Version:  0.1.2
" Authors: Alessio 'molok' Bolognino <alessio.bolognino+vim@gmail.com>
" Last Modified: 2013-12-09
" License:  GPL (Gnu Public License)
" ------------------------------------------------------------------------------

if exists("syntax_on")
  syntax reset
endif

let colors_name = "vombato"

set background=dark

if version >= 700
    hi CursorLine    guifg=NONE     guibg=#2D2D2D  gui=NONE
    hi CursorColumn  guifg=NONE     guibg=#2D2D2D  gui=NONE
    hi MatchParen    guifg=NONE     guibg=#906000  gui=NONE
    hi Pmenu         guifg=#F6F3E8  guibg=#444444  gui=NONE
    hi PmenuSel      guifg=#000000  guibg=#8AC6F2  gui=NONE
    hi PmenuSbar     guifg=NONE     guibg=#303030  gui=NONE
    hi PmenuThumb    guifg=NONE     guibg=#808080  gui=NONE
    if version >= 703
        hi CursorLineNr guifg=#F6F3E8 guibg=NONE    gui=NONE
        hi ColorColumn  guifg=NONE    guibg=#202020 gui=NONE
        hi Conceal      guifg=#EDEA61 guibg=#303030 gui=NONE
    endif
endif

" General colors
hi Cursor       guifg=NONE    guibg=#656565 gui=NONE
hi Normal       guifg=#F6F3E8 guibg=#242424 gui=NONE
hi NonText      guifg=#404040 guibg=NONE    gui=NONE
hi LineNr       guifg=#857B6F guibg=#000000 gui=NONE
hi StatusLine   guifg=#F6F3E8 guibg=#444444 gui=NONE
hi StatusLineNC guifg=#857B6F guibg=#444444 gui=NONE
hi VertSplit    guifg=#444444 guibg=#444444 gui=NONE
hi Title        guifg=#95e454 guibg=NONE    gui=NONE
hi Visual       guifg=#F6F3E8 guibg=#444444 gui=NONE
hi SpecialKey   guifg=#353535 guibg=NONE    gui=NONE

" Syntax highlighting
hi Comment      guifg=#99968B guibg=NONE    gui=NONE
hi Todo         guifg=#FF4400 guibg=NONE    gui=NONE
hi Constant     guifg=#E5786D guibg=NONE    gui=NONE
hi String       guifg=#95E454 guibg=NONE    gui=NONE
hi Identifier   guifg=#CAE682 guibg=NONE    gui=NONE
hi Function     guifg=#CAE682 guibg=NONE    gui=NONE
hi Type         guifg=#CAE682 guibg=NONE    gui=NONE
hi Statement    guifg=#8AC6F2 guibg=NONE    gui=NONE
hi Keyword      guifg=#8AC6F2 guibg=NONE    gui=NONE
hi PreProc      guifg=#E5786D guibg=NONE    gui=NONE
hi Number       guifg=#E5786D guibg=NONE    gui=NONE
hi Special      guifg=#E7F6DA guibg=NONE    gui=NONE
hi Float        guifg=#FFAA50 guibg=NONE    gui=NONE
hi Boolean      guifg=#8AC6F2 guibg=NONE    gui=NONE

" I use guifg and reverse because using guibg allows the colorcolumn highlight
" to overwrite the bg color
hi Search       guifg=#FFFF00 guibg=NONE    gui=reverse
hi IncSearch    guifg=#8AC6F2 guibg=NONE    gui=reverse
hi DiffAdd      guifg=#CAE682 guibg=NONE    gui=reverse
hi DiffChange   guifg=#FFAA50 guibg=NONE    gui=reverse
hi DiffDelete   guifg=#e64e53 guibg=NONE    gui=reverse
hi DiffText     guifg=#FF0000 guibg=NONE    gui=reverse

hi FoldColumn   guifg=#EDEA61 guibg=#303030 gui=NONE
hi Folded       guifg=#EDEA61 guibg=#303030 gui=NONE

hi SpellBad     guisp=#FF0000 gui=undercurl
hi SpellCap     guisp=#8AC6F2 gui=undercurl
hi SpellLocal   guisp=#FFFF00 gui=undercurl
hi SpellRare    guisp=#E454BA gui=undercurl

hi SignColumn   guifg=#857B6F guibg=#000000 gui=NONE

hi Directory    guifg=#CAE682 guibg=NONE
hi ErrorMsg     guifg=#FFFFFF guibg=#FF0000 gui=NONE
hi Question     guifg=#95E454 guibg=NONE    gui=NONE

hi TabLine      guifg=#808080 guibg=#202020 gui=NONE
hi TabLineSel   guifg=#95e454 guibg=#202020 gui=underline
hi TabLineFill  guifg=#444444 guibg=#444444 gui=NONE

hi VisualNOS    guifg=NONE    guibg=NONE    gui=underline
hi WarningMsg   guifg=#FFAA50 guibg=NONE    gui=NONE
hi WildMenu     guifg=#000000 guibg=#8AC6F2 gui=NONE
hi MoreMsg      NONE
hi link MoreMsg Question

hi ModeMsg      guifg=#F6F3E8 guibg=NONE    gui=NONE

" Custom stuff
hi Modified guifg=black guibg=#FFA500 