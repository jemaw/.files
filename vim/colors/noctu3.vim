" noctu.vim - Vim color scheme for 16-color terminals
" --------------------------------------------------------------
" Author:   Noah Frederick (http://noahfrederick.com/)
" Version:  1.7.0
" --------------------------------------------------------------

" Scheme setup {{{
set background=dark
hi! clear

if exists("syntax_on")
  syntax reset
endif

let colors_name="noctu"

"}}}
" Vim UI {{{
hi Cursor              ctermfg=7     ctermbg=1
hi CursorLine          ctermbg=0     cterm=NONE
"hi MatchParen          ctermfg=7     ctermbg=NONE  cterm=underline
"hi MatchParen          ctermfg=13    ctermbg=0     cterm=bold
hi Pmenu               ctermfg=15    ctermbg=0
hi PmenuThumb          ctermbg=7
hi PmenuSBar           ctermbg=8
hi PmenuSel            ctermfg=0     ctermbg=4
hi ColorColumn         ctermbg=0
hi SpellBad            ctermfg=1     ctermbg=NONE  cterm=underline
hi SpellCap            ctermfg=10    ctermbg=NONE  cterm=underline
hi SpellRare           ctermfg=11    ctermbg=NONE  cterm=underline
hi SpellLocal          ctermfg=13    ctermbg=NONE  cterm=underline
hi NonText             ctermfg=8
hi LineNr              ctermfg=8     ctermbg=NONE
hi CursorLineNr        ctermfg=11    ctermbg=0
hi Visual              ctermfg=0     ctermbg=12
hi IncSearch           ctermfg=0     ctermbg=13    cterm=NONE
hi Search              ctermfg=0     ctermbg=10
hi StatusLine          ctermfg=7     ctermbg=0     cterm=bold
hi StatusLineNC        ctermfg=8     ctermbg=0     cterm=bold
hi VertSplit           ctermfg=0     ctermbg=0     cterm=NONE
hi TabLine             ctermfg=8     ctermbg=0     cterm=NONE
hi TabLineSel          ctermfg=7     ctermbg=0
hi Folded              ctermfg=3     ctermbg=0
hi Directory           ctermfg=12
hi Title               ctermfg=3     
hi ErrorMsg            ctermfg=15    ctermbg=1
hi DiffAdd             ctermfg=0     ctermbg=2
hi DiffChange          ctermfg=0     ctermbg=3
hi DiffDelete          ctermfg=0     ctermbg=1
hi DiffText            ctermfg=0     ctermbg=11    cterm=bold
hi User1               ctermfg=15    ctermbg=5
hi User2               ctermfg=15    ctermbg=8
hi User3               ctermfg=15    ctermbg=3
hi User4               ctermfg=15    ctermbg=0
hi User5               ctermfg=15    ctermbg=13
hi User6               ctermfg=15    ctermbg=14
hi User7               ctermfg=15    ctermbg=12
hi User8               ctermfg=15    ctermbg=11
hi User9               ctermfg=15    ctermbg=8
hi! link CursorColumn  CursorLine
hi! link SignColumn    LineNr
hi! link WildMenu      Visual
hi! link FoldColumn    SignColumn
hi! link WarningMsg    ErrorMsg
hi! link MoreMsg       Title
hi! link Question      MoreMsg
hi! link ModeMsg       MoreMsg
hi! link TabLineFill   StatusLineNC
hi! link SpecialKey    NonText

"}}}
" Generic syntax {{{
hi Delimiter       ctermfg=7
hi Comment         ctermfg=8
hi Underlined      ctermfg=4   cterm=underline
hi Type            ctermfg=4
hi String          ctermfg=9
hi Keyword         ctermfg=2
hi Todo            ctermfg=15  ctermbg=NONE     cterm=bold,underline
hi Function        ctermfg=4
hi Identifier      ctermfg=7   cterm=NONE
hi Statement       ctermfg=4
"hi Statement       ctermfg=2   cterm=bold
"return def usw
hi Constant        ctermfg=13
hi Number          ctermfg=12
hi Boolean         ctermfg=4
hi Special         ctermfg=13
hi Ignore          ctermfg=0
hi! link Operator  Delimiter
hi! link PreProc   Delimiter
hi! link Error     ErrorMsg

"}}}
" HTML {{{
hi htmlTagName              ctermfg=2
hi htmlTag                  ctermfg=2
hi htmlArg                  ctermfg=10
hi htmlH1                   cterm=bold
hi htmlBold                 cterm=bold
hi htmlItalic               cterm=underline
hi htmlUnderline            cterm=underline
hi htmlBoldItalic           cterm=bold,underline
hi htmlBoldUnderline        cterm=bold,underline
hi htmlUnderlineItalic      cterm=underline
hi htmlBoldUnderlineItalic  cterm=bold,underline
hi! link htmlLink           Underlined
hi! link htmlEndTag         htmlTag

"}}}
" XML {{{
hi xmlTagName       ctermfg=4
hi xmlTag           ctermfg=12
hi! link xmlString  xmlTagName
hi! link xmlAttrib  xmlTag
hi! link xmlEndTag  xmlTag
hi! link xmlEqual   xmlTag

"}}}
" JavaScript {{{
hi! link javaScript        Normal
hi! link javaScriptBraces  Delimiter

"}}}
" PHP {{{
hi phpSpecialFunction    ctermfg=5
hi phpIdentifier         ctermfg=11
hi! link phpVarSelector  phpIdentifier
hi! link phpHereDoc      String
hi! link phpDefine       Statement

"}}}
" Markdown {{{
hi! link markdownHeadingRule        NonText
hi! link markdownHeadingDelimiter   markdownHeadingRule
hi! link markdownLinkDelimiter      Delimiter
hi! link markdownURLDelimiter       Delimiter
hi! link markdownCodeDelimiter      NonText
hi! link markdownLinkTextDelimiter  markdownLinkDelimiter
hi! link markdownUrl                markdownLinkText
hi! link markdownAutomaticLink      markdownLinkText
hi! link markdownCodeBlock          String
hi markdownCode                     cterm=bold
hi markdownBold                     cterm=bold
hi markdownItalic                   cterm=underline

"}}}
" Ruby {{{
hi! link rubyDefine                 Statement
hi! link rubyLocalVariableOrMethod  Identifier
hi! link rubyConstant               Constant
hi! link rubyInstanceVariable       Number
hi! link rubyStringDelimiter        rubyString

"}}}
" Git {{{
hi gitCommitBranch               ctermfg=3
hi gitCommitSelectedType         ctermfg=10
hi gitCommitSelectedFile         ctermfg=2
hi gitCommitUnmergedType         ctermfg=9
hi gitCommitUnmergedFile         ctermfg=1
hi! link gitCommitFile           Directory
hi! link gitCommitUntrackedFile  gitCommitUnmergedFile
hi! link gitCommitDiscardedType  gitCommitUnmergedType
hi! link gitCommitDiscardedFile  gitCommitUnmergedFile

"}}}
" Vim {{{
hi! link vimSetSep    Delimiter
hi! link vimContinue  Delimiter
hi! link vimHiAttrib  Constant

"}}}
" LESS {{{
hi lessVariable             ctermfg=11
hi! link lessVariableValue  Normal

"}}}
" NERDTree {{{
hi! link NERDTreeHelp      Comment
hi! link NERDTreeExecFile  String

"}}}
" Vimwiki {{{
hi! link VimwikiHeaderChar  markdownHeadingDelimiter
hi! link VimwikiList        markdownListMarker
hi! link VimwikiCode        markdownCode
hi! link VimwikiCodeChar    markdownCodeDelimiter

"}}}
" Help {{{
hi! link helpExample         String
hi! link helpHeadline        Title
hi! link helpSectionDelim    Comment
hi! link helpHyperTextEntry  Statement
hi! link helpHyperTextJump   Underlined
hi! link helpURL             Underlined

"}}}
" CtrlP {{{
hi! link CtrlPMatch    String
hi! link CtrlPLinePre  Comment

"}}}
" Mustache {{{
hi mustacheSection           ctermfg=14  cterm=bold
hi mustacheMarker            ctermfg=6
hi mustacheVariable          ctermfg=14
hi mustacheVariableUnescape  ctermfg=9
hi mustachePartial           ctermfg=13

"}}}
" Shell {{{
hi shDerefSimple     ctermfg=11
hi! link shDerefVar  shDerefSimple

"}}}
" Syntastic {{{
hi SyntasticWarningSign  ctermfg=3   ctermbg=NONE
hi SyntasticErrorSign    ctermfg=1   ctermbg=NONE

"}}}
" Netrw {{{
hi netrwExe       ctermfg=9
hi netrwClassify  ctermfg=8  cterm=bold

"}}}

hi Float           ctermfg=3
hi Include         ctermfg=5
hi Define          ctermfg=2
hi Macro           ctermfg=13
hi PreProc         ctermfg=10
hi PreCondit       ctermfg=13
hi NonText         ctermfg=6
hi Directory       ctermfg=6
hi SpecialKey      ctermfg=11
hi Type            ctermfg=6
hi String          ctermfg=2
hi Constant        ctermfg=13
hi Special         ctermfg=10
hi SpecialChar     ctermfg=9
hi Number          ctermfg=14
hi Identifier      ctermfg=13
hi Conditional     ctermfg=14
hi Repeat          ctermfg=9
hi Statement       ctermfg=4
hi Label           ctermfg=13
hi Operator        ctermfg=3
hi Keyword         ctermfg=9   
hi StorageClass    ctermfg=11  
hi Structure       ctermfg=5
hi Typedef         ctermfg=6
hi Function        ctermfg=11
hi Exception       ctermfg=1
hi Underlined      ctermfg=4
hi Title           ctermfg=3   
hi Tag             ctermfg=11
hi Delimiter       ctermfg=12  
hi SpecialComment  ctermfg=9
hi Boolean         ctermfg=3
hi Todo            ctermfg=9	ctermbg=None
hi Debug           ctermfg=1	ctermbg=None
hi ErrorMsg        ctermfg=1    ctermbg=None
hi WildMenu        ctermfg=5    ctermbg=15
hi Search          ctermfg=1    ctermbg=15
hi IncSearch       ctermfg=1    ctermbg=15
hi WarningMsg      ctermfg=1    ctermbg=15
hi Question        ctermfg=10   ctermbg=15
hi Visual          ctermfg=8    ctermbg=15
" vim: fdm=marker:sw=2:sts=2:et
