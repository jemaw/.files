" noctwo.vim - Vim color scheme for 16-color terminals
" --------------------------------------------------------------
" OriginalAuthor:   Noah Frederick (http://noahfrederick.com/)
" Modified:         Jean Wanka     (http://github.com/jemaw)
" --------------------------------------------------------------

" {{{
" termonal colors:
" if you forget meaning of a number jump with gd

0  " black
8  " lightblack
1  " red
9  " lightred
2  " green
10 " lightgreen
3  " darkyellow/brown
11 " yellow
4  " blue
12 " lightblue
5  " magenta
13 " lightmagenta
6  " cyan
14 " lightcyan
7  " gray
15 " white

" }}}
" Scheme setup {{{
set background=dark
hi! clear

if exists("syntax_on")
  syntax reset
endif

let colors_name="noctwo"

"}}}
" Vim UI {{{
hi Cursor              ctermfg=7  ctermbg=1
hi CursorLine          ctermbg=0  cterm=NONE
hi MatchParen          ctermfg=1  ctermbg=NONE cterm=bold
hi Pmenu               ctermfg=15 ctermbg=None
hi PmenuThumb          ctermbg=7
hi PmenuSBar           ctermbg=8
hi PmenuSel            ctermfg=7  cterm=bold
hi ColorColumn         ctermbg=0
hi SpellBad            ctermfg=1  ctermbg=NONE cterm=underline
hi SpellCap            ctermfg=10 ctermbg=NONE cterm=underline
hi SpellRare           ctermfg=11 ctermbg=NONE cterm=underline
hi SpellLocal          ctermfg=13 ctermbg=NONE cterm=underline
hi NonText             ctermfg=8
hi LineNr              ctermfg=8  ctermbg=NONE
hi CursorLineNr        ctermfg=11 ctermbg=0
hi Visual              ctermfg=15  ctermbg=8
hi IncSearch           ctermfg=0  ctermbg=13   cterm=NONE
hi Search              ctermfg=0  ctermbg=10
hi StatusLine          ctermfg=7  ctermbg=0    cterm=None
hi StatusLineNC        ctermfg=8  ctermbg=None cterm=bold
hi VertSplit           ctermfg=0  ctermbg=0    cterm=NONE
hi TabLine             ctermfg=8  ctermbg=0    cterm=NONE
hi TabLineSel          ctermfg=7  ctermbg=0
hi Folded              ctermfg=4  ctermbg=none
hi Directory           ctermfg=12
hi Title               ctermfg=3  cterm=bold
hi ErrorMsg            ctermfg=15 ctermbg=1
hi DiffAdd             ctermfg=0  ctermbg=2
hi DiffChange          ctermfg=0  ctermbg=3
hi DiffDelete          ctermfg=0  ctermbg=1
hi DiffText            ctermfg=0  ctermbg=11   cterm=bold
hi! link CursorColumn             CursorLine
hi! link SignColumn               LineNr
hi! link WildMenu                 Visual
hi! link FoldColumn               SignColumn
hi! link WarningMsg               ErrorMsg
hi! link MoreMsg                  Title
hi! link Question                 MoreMsg
hi! link ModeMsg                  MoreMsg
hi! link TabLineFill              StatusLineNC
hi! link SpecialKey               NonText

"}}}
" Generic syntax {{{
hi Delimiter       ctermfg=7
hi Comment         ctermfg=8
hi Underlined      ctermfg=12 cterm=underline
hi Type            ctermfg=6
hi String          ctermfg=2
hi Keyword         ctermfg=12
hi Todo            ctermfg=15 ctermbg=NONE cterm=bold,underline
hi Function        ctermfg=12
hi Identifier      ctermfg=7  cterm=NONE
hi Statement       ctermfg=15 cterm=bold
hi Constant        ctermfg=13
hi Number          ctermfg=1
hi Boolean         ctermfg=9
hi Special         ctermfg=13
hi Ignore          ctermfg=0
hi! link Operator  Delimiter
hi! link PreProc   Delimiter
hi! link Error     ErrorMsg

"}}}
" HTML {{{

hi! link htmlTagName        Normal
hi! link htmlTag            Normal
hi htmlArg            cterm=bold

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
hi SyntasticWarningSign  ctermfg=3 ctermbg=NONE
hi SyntasticErrorSign    ctermfg=1 ctermbg=NONE

"}}}
" Ale {{{
hi ALEErrorSign   ctermfg=1 ctermbg=NONE
hi ALEWarningSign ctermfg=8 ctermbg=NONE

" }}}
" Netrw {{{
hi netrwExe       ctermfg=9
hi netrwClassify  ctermfg=8  cterm=bold

"}}}
" Denite {{{
hi deniteMatchedChar ctermbg=0 ctermfg=1

"}}}

" vim: fdm=marker:sw=2:sts=2:et
