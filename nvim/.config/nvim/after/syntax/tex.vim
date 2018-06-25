if has('conceal')
	" \mathbb characters
	syn match texMathSymbol '\\mathbb{A}' contained conceal cchar=𝔸
	syn match texMathSymbol '\\mathbb{B}' contained conceal cchar=𝔹
	syn match texMathSymbol '\\mathbb{C}' contained conceal cchar=ℂ
	syn match texMathSymbol '\\mathbb{D}' contained conceal cchar=𝔻
	syn match texMathSymbol '\\mathbb{E}' contained conceal cchar=𝔼
	syn match texMathSymbol '\\mathbb{F}' contained conceal cchar=𝔽
	syn match texMathSymbol '\\mathbb{G}' contained conceal cchar=𝔾
	syn match texMathSymbol '\\mathbb{H}' contained conceal cchar=ℍ
	syn match texMathSymbol '\\mathbb{I}' contained conceal cchar=𝕀
	syn match texMathSymbol '\\mathbb{J}' contained conceal cchar=𝕁
	syn match texMathSymbol '\\mathbb{K}' contained conceal cchar=𝕂
	syn match texMathSymbol '\\mathbb{L}' contained conceal cchar=𝕃
	syn match texMathSymbol '\\mathbb{M}' contained conceal cchar=𝕄
	syn match texMathSymbol '\\mathbb{N}' contained conceal cchar=ℕ
	syn match texMathSymbol '\\mathbb{O}' contained conceal cchar=𝕆
	syn match texMathSymbol '\\mathbb{P}' contained conceal cchar=ℙ
	syn match texMathSymbol '\\mathbb{Q}' contained conceal cchar=ℚ
	syn match texMathSymbol '\\mathbb{R}' contained conceal cchar=ℝ
	syn match texMathSymbol '\\mathbb{S}' contained conceal cchar=𝕊
	syn match texMathSymbol '\\mathbb{T}' contained conceal cchar=𝕋
	syn match texMathSymbol '\\mathbb{U}' contained conceal cchar=𝕌
	syn match texMathSymbol '\\mathbb{V}' contained conceal cchar=𝕍
	syn match texMathSymbol '\\mathbb{W}' contained conceal cchar=𝕎
	syn match texMathSymbol '\\mathbb{X}' contained conceal cchar=𝕏
	syn match texMathSymbol '\\mathbb{Y}' contained conceal cchar=𝕐
	syn match texMathSymbol '\\mathbb{Z}' contained conceal cchar=ℤ

	" \mathbb characters
	syn match texMathSymbol '\\AA' contained conceal cchar=𝔸
	syn match texMathSymbol '\\BB' contained conceal cchar=𝔹
	syn match texMathSymbol '\\CC' contained conceal cchar=ℂ
	syn match texMathSymbol '\\DD' contained conceal cchar=𝔻
	syn match texMathSymbol '\\EE' contained conceal cchar=𝔼
	syn match texMathSymbol '\\FF' contained conceal cchar=𝔽
	syn match texMathSymbol '\\GG' contained conceal cchar=𝔾
	syn match texMathSymbol '\\HH' contained conceal cchar=ℍ
	syn match texMathSymbol '\\II' contained conceal cchar=𝕀
	syn match texMathSymbol '\\JJ' contained conceal cchar=𝕁
	syn match texMathSymbol '\\KK' contained conceal cchar=𝕂
	syn match texMathSymbol '\\LL' contained conceal cchar=𝕃
	syn match texMathSymbol '\\MM' contained conceal cchar=𝕄
	syn match texMathSymbol '\\NN' contained conceal cchar=ℕ
	syn match texMathSymbol '\\OO' contained conceal cchar=𝕆
	syn match texMathSymbol '\\PP' contained conceal cchar=ℙ
	syn match texMathSymbol '\\QQ' contained conceal cchar=ℚ
	syn match texMathSymbol '\\RR' contained conceal cchar=ℝ
	syn match texMathSymbol '\\SS' contained conceal cchar=𝕊
	syn match texMathSymbol '\\TT' contained conceal cchar=𝕋
	syn match texMathSymbol '\\UU' contained conceal cchar=𝕌
	syn match texMathSymbol '\\VV' contained conceal cchar=𝕍
	syn match texMathSymbol '\\WW' contained conceal cchar=𝕎
	syn match texMathSymbol '\\XX' contained conceal cchar=𝕏
	syn match texMathSymbol '\\YY' contained conceal cchar=𝕐
	syn match texMathSymbol '\\ZZ' contained conceal cchar=ℤ

	syn match texBoldMathText '\\bar\>' contained conceal cchar=‾

	" \mathcal characters
	syn match texMathSymbol '\\mathcal{A}' contained conceal cchar=𝓐
	syn match texMathSymbol '\\mathcal{B}' contained conceal cchar=𝓑
	syn match texMathSymbol '\\mathcal{C}' contained conceal cchar=𝓒
	syn match texMathSymbol '\\mathcal{D}' contained conceal cchar=𝓓
	syn match texMathSymbol '\\mathcal{E}' contained conceal cchar=𝓔
	syn match texMathSymbol '\\mathcal{F}' contained conceal cchar=𝓕
	syn match texMathSymbol '\\mathcal{G}' contained conceal cchar=𝓖
	syn match texMathSymbol '\\mathcal{H}' contained conceal cchar=𝓗
	syn match texMathSymbol '\\mathcal{I}' contained conceal cchar=𝓘
	syn match texMathSymbol '\\mathcal{J}' contained conceal cchar=𝓙
	syn match texMathSymbol '\\mathcal{K}' contained conceal cchar=𝓚
	syn match texMathSymbol '\\mathcal{L}' contained conceal cchar=𝓛
	syn match texMathSymbol '\\mathcal{M}' contained conceal cchar=𝓜
	syn match texMathSymbol '\\mathcal{N}' contained conceal cchar=𝓝
	syn match texMathSymbol '\\mathcal{O}' contained conceal cchar=𝓞
	syn match texMathSymbol '\\mathcal{P}' contained conceal cchar=𝓟
	syn match texMathSymbol '\\mathcal{Q}' contained conceal cchar=𝓠
	syn match texMathSymbol '\\mathcal{R}' contained conceal cchar=𝓡
	syn match texMathSymbol '\\mathcal{S}' contained conceal cchar=𝓢
	syn match texMathSymbol '\\mathcal{T}' contained conceal cchar=𝓣
	syn match texMathSymbol '\\mathcal{U}' contained conceal cchar=𝓤
	syn match texMathSymbol '\\mathcal{V}' contained conceal cchar=𝓥
	syn match texMathSymbol '\\mathcal{W}' contained conceal cchar=𝓦
	syn match texMathSymbol '\\mathcal{X}' contained conceal cchar=𝓧
	syn match texMathSymbol '\\mathcal{Y}' contained conceal cchar=𝓨
	syn match texMathSymbol '\\mathcal{Z}' contained conceal cchar=𝓩

	syn match texMathSymbol '\\cA' contained conceal cchar=𝓐
	syn match texMathSymbol '\\cB' contained conceal cchar=𝓑
	syn match texMathSymbol '\\cC' contained conceal cchar=𝓒
	syn match texMathSymbol '\\cD' contained conceal cchar=𝓓
	syn match texMathSymbol '\\cE' contained conceal cchar=𝓔
	syn match texMathSymbol '\\cF' contained conceal cchar=𝓕
	syn match texMathSymbol '\\cG' contained conceal cchar=𝓖
	syn match texMathSymbol '\\cH' contained conceal cchar=𝓗
	syn match texMathSymbol '\\cI' contained conceal cchar=𝓘
	syn match texMathSymbol '\\cJ' contained conceal cchar=𝓙
	syn match texMathSymbol '\\cK' contained conceal cchar=𝓚
	syn match texMathSymbol '\\cL' contained conceal cchar=𝓛
	syn match texMathSymbol '\\cM' contained conceal cchar=𝓜
	syn match texMathSymbol '\\cN' contained conceal cchar=𝓝
	syn match texMathSymbol '\\cO' contained conceal cchar=𝓞
	syn match texMathSymbol '\\cP' contained conceal cchar=𝓟
	syn match texMathSymbol '\\cQ' contained conceal cchar=𝓠
	syn match texMathSymbol '\\cR' contained conceal cchar=𝓡
	syn match texMathSymbol '\\cS' contained conceal cchar=𝓢
	syn match texMathSymbol '\\cT' contained conceal cchar=𝓣
	syn match texMathSymbol '\\cU' contained conceal cchar=𝓤
	syn match texMathSymbol '\\cV' contained conceal cchar=𝓥
	syn match texMathSymbol '\\cW' contained conceal cchar=𝓦
	syn match texMathSymbol '\\cX' contained conceal cchar=𝓧
	syn match texMathSymbol '\\cY' contained conceal cchar=𝓨
	syn match texMathSymbol '\\cZ' contained conceal cchar=𝓩

" 	syn match texMathSymbol '\\mathcal{A}' contained conceal cchar=A
" 	syn match texMathSymbol '\\mathcal{B}' contained conceal cchar=B
" 	syn match texMathSymbol '\\mathcal{C}' contained conceal cchar=C
" 	syn match texMathSymbol '\\mathcal{D}' contained conceal cchar=D
" 	syn match texMathSymbol '\\mathcal{E}' contained conceal cchar=E
" 	syn match texMathSymbol '\\mathcal{F}' contained conceal cchar=F
" 	syn match texMathSymbol '\\mathcal{G}' contained conceal cchar=G
" 	syn match texMathSymbol '\\mathcal{H}' contained conceal cchar=H
" 	syn match texMathSymbol '\\mathcal{I}' contained conceal cchar=I
" 	syn match texMathSymbol '\\mathcal{J}' contained conceal cchar=J
" 	syn match texMathSymbol '\\mathcal{K}' contained conceal cchar=K
" 	syn match texMathSymbol '\\mathcal{L}' contained conceal cchar=L
" 	syn match texMathSymbol '\\mathcal{M}' contained conceal cchar=M
" 	syn match texMathSymbol '\\mathcal{N}' contained conceal cchar=N
" 	syn match texMathSymbol '\\mathcal{O}' contained conceal cchar=O
" 	syn match texMathSymbol '\\mathcal{P}' contained conceal cchar=P
" 	syn match texMathSymbol '\\mathcal{Q}' contained conceal cchar=Q
" 	syn match texMathSymbol '\\mathcal{R}' contained conceal cchar=R
" 	syn match texMathSymbol '\\mathcal{S}' contained conceal cchar=S
" 	syn match texMathSymbol '\\mathcal{T}' contained conceal cchar=T
" 	syn match texMathSymbol '\\mathcal{U}' contained conceal cchar=U
" 	syn match texMathSymbol '\\mathcal{V}' contained conceal cchar=V
" 	syn match texMathSymbol '\\mathcal{W}' contained conceal cchar=W
" 	syn match texMathSymbol '\\mathcal{X}' contained conceal cchar=X
" 	syn match texMathSymbol '\\mathcal{Y}' contained conceal cchar=Y
" 	syn match texMathSymbol '\\mathcal{Z}' contained conceal cchar=Z

" 	syn match texMathSymbol '\\cA' contained conceal cchar=A
" 	syn match texMathSymbol '\\cB' contained conceal cchar=B
" 	syn match texMathSymbol '\\cC' contained conceal cchar=C
" 	syn match texMathSymbol '\\cD' contained conceal cchar=D
" 	syn match texMathSymbol '\\cE' contained conceal cchar=E
" 	syn match texMathSymbol '\\cF' contained conceal cchar=F
" 	syn match texMathSymbol '\\cG' contained conceal cchar=G
" 	syn match texMathSymbol '\\cH' contained conceal cchar=H
" 	syn match texMathSymbol '\\cI' contained conceal cchar=I
" 	syn match texMathSymbol '\\cJ' contained conceal cchar=J
" 	syn match texMathSymbol '\\cK' contained conceal cchar=K
" 	syn match texMathSymbol '\\cL' contained conceal cchar=L
" 	syn match texMathSymbol '\\cM' contained conceal cchar=M
" 	syn match texMathSymbol '\\cN' contained conceal cchar=N
" 	syn match texMathSymbol '\\cO' contained conceal cchar=O
" 	syn match texMathSymbol '\\cP' contained conceal cchar=P
" 	syn match texMathSymbol '\\cQ' contained conceal cchar=Q
" 	syn match texMathSymbol '\\cR' contained conceal cchar=R
" 	syn match texMathSymbol '\\cS' contained conceal cchar=S
" 	syn match texMathSymbol '\\cT' contained conceal cchar=T
" 	syn match texMathSymbol '\\cU' contained conceal cchar=U
" 	syn match texMathSymbol '\\cV' contained conceal cchar=V
" 	syn match texMathSymbol '\\cW' contained conceal cchar=W
" 	syn match texMathSymbol '\\cX' contained conceal cchar=X
" 	syn match texMathSymbol '\\cY' contained conceal cchar=Y
" 	syn match texMathSymbol '\\cZ' contained conceal cchar=Z

	syn match texStatement '``' contained conceal cchar=“
	syn match texStatement '\'\'' contained conceal cchar=”
	syn match texStatement '\\item\>' contained conceal cchar=•
	syn match texMathSymbol '\\dd' contained conceal cchar=d
	syn match texDelimiter '\\{' contained conceal cchar={
	syn match texDelimiter '\\}' contained conceal cchar=}
	syn match texMathSymbol '\\setminus\>' contained conceal cchar=\
	syn match texMathSymbol '\\coloneqq\>' contained conceal cchar=≔
	syn match texMathSymbol '\\,' contained conceal cchar= 
	syn match texMathSymbol '\\ ' contained conceal cchar= 
	syn match texMathSymbol '\\quad' contained conceal cchar= 
	syn match texMathSymbol '\\sqrt' contained conceal cchar=√
	syn match texMathSymbol '\\where\>' contained conceal cchar=|
	syn match texMathSymbol '\\\!' contained conceal
	"syn match texStatement '\\\[' contained conceal cchar=⟦
	"syn match texStatement '\\\]' contained conceal cchar=⟧

	" hide \text delimiter etc inside math mode
	" if !exists("g:tex_nospell") || !g:tex_nospell
	"  syn region texMathText matchgroup=texStatement start='\\\(\(inter\)\=mathrm\)\s*{'	end='}'	concealends keepend contains=@texFoldGroup,
	"  syn region texMathText matchgroup=texStatement start='\\\(\(inter\)\=text\|mbox\)\s*{'	end='}'	concealends keepend contains=@texFoldGroup,@Spell
	" else
	"  syn region texMathText matchgroup=texStatement start='\\\(\(inter\)\=text\|mbox\|mathrm\)\s*{'	end='}'	concealends keepend contains=@texFoldGroup
	" endif

	" syn region texBoldMathText matchgroup=texStatement start='\\\(mathbf\|bm\){' end='}' concealends keepend contains=@texMathZoneGroup
 	" syn cluster texMathZoneGroup add=texBoldMathText

	" syn region texBoldItalStyle	matchgroup=texTypeStyle start="\\emph\s*{" end="}" concealends contains=@texItalGroup
	" syn region texItalStyle	 matchgroup=texTypeStyle start="\\emph\s*{" end="}" concealends contains=@texItalGroup
	" syn region texItalStyle	 matchgroup=texTypeStyle start="\\emph\s*{" end="}" concealends contains=@texItalGroup

	" set ambiwidth=single
	" hi texBoldMathText ctermfg=4 guifg=white cterm=bold gui=bold
	" hi texRefZone ctermfg=4
	" hi texInputFile ctermfg=4
	" hi texMathZoneE ctermfg=4
	" hi texMathZoneX ctermfg=4
endif
