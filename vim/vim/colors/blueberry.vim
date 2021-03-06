"
" Full Colour and 255 Colour
" larsand@gmail.com
"
" Hex colour conversion functions borrowed from the theme "Desert256""

" Default GUI Colours

let s:contrast="low"
"let s:contrast="high"   Not yet added

"if (match(system("cat /etc/issue"), "SUbuntu") != -1)
	"let s:contrast = "high"
    "let s:line = "a12d00"
"endif

" Console 256 Colours
"if !has("gui_running")
	"let s:background = "303030"
	"let s:window = "5e5e5e"
    "let s:line = "3a3a3a"
	"let s:selection = "585858"
"end

if s:contrast == "high"

elseif s:contrast == "low"

    if &background == "light"

        " Blueberry light

        let s:background = "d7d0cc"
        let s:blue = "3040a0"
        let s:brown = "605040"
        let s:comment = "797769"
        let s:cyan = "007080"
        let s:foreground = "363436"
        let s:green = "25682d"
        let s:grey1 = "505050"
        let s:grey2 = "707070"
        let s:line = "282a2e"
        let s:orange = "de935f"
        let s:purple = "78288e"
        let s:red = "a82010"
        let s:selection = "959eaa"
        let s:steel = "304080"
        let s:violet = "a03050"
        let s:window = "a0a0a0"
        let s:yellow = "d0a654"
    else

        " Blueberry dark

        let s:background = "282828"
        let s:blue = "8090e0"
        let s:brown = "906050"
        let s:comment = "707070"
        let s:cyan = "70a0b0"
        let s:foreground = "a0a0a0"
        let s:green = "608870"
        let s:grey1 = "909090"
        let s:grey2 = "808080"
        let s:line = "a12d00"
        let s:orange = "de935f"
        let s:purple = "a880d8"
        let s:red = "b04050"
        let s:selection = "405060"
        let s:steel = "8090b0"
        let s:violet = "c06080"
        let s:window = "404040"
        let s:yellow = "d0a654"
    endif
else
    "let s:background = "ff0000"  " not implemented
endif

hi clear
syntax reset
let g:colors_name = "blueberry"

if has("gui_running") || &t_Co == 88 || &t_Co == 256
	" Returns an approximate grey index for the given grey level
	fun <SID>grey_number(x)
		if &t_Co == 88
			if a:x < 23
				return 0
			elseif a:x < 69
				return 1
			elseif a:x < 103
				return 2
			elseif a:x < 127
				return 3
			elseif a:x < 150
				return 4
			elseif a:x < 173
				return 5
			elseif a:x < 196
				return 6
			elseif a:x < 219
				return 7
			elseif a:x < 243
				return 8
			else
				return 9
			endif
		else
			if a:x < 14
				return 0
			else
				let l:n = (a:x - 8) / 10
				let l:m = (a:x - 8) % 10
				if l:m < 5
					return l:n
				else
					return l:n + 1
				endif
			endif
		endif
	endfun

	" Returns the actual grey level represented by the grey index
	fun <SID>grey_level(n)
		if &t_Co == 88
			if a:n == 0
				return 0
			elseif a:n == 1
				return 46
			elseif a:n == 2
				return 92
			elseif a:n == 3
				return 115
			elseif a:n == 4
				return 139
			elseif a:n == 5
				return 162
			elseif a:n == 6
				return 185
			elseif a:n == 7
				return 208
			elseif a:n == 8
				return 231
			else
				return 255
			endif
		else
			if a:n == 0
				return 0
			else
				return 8 + (a:n * 10)
			endif
		endif
	endfun

	" Returns the palette index for the given grey index
	fun <SID>grey_colour(n)
		if &t_Co == 88
			if a:n == 0
				return 16
			elseif a:n == 9
				return 79
			else
				return 79 + a:n
			endif
		else
			if a:n == 0
				return 16
			elseif a:n == 25
				return 231
			else
				return 231 + a:n
			endif
		endif
	endfun

	" Returns an approximate colour index for the given colour level
	fun <SID>rgb_number(x)
		if &t_Co == 88
			if a:x < 69
				return 0
			elseif a:x < 172
				return 1
			elseif a:x < 230
				return 2
			else
				return 3
			endif
		else
			if a:x < 75
				return 0
			else
				let l:n = (a:x - 55) / 40
				let l:m = (a:x - 55) % 40
				if l:m < 20
					return l:n
				else
					return l:n + 1
				endif
			endif
		endif
	endfun

	" Returns the actual colour level for the given colour index
	fun <SID>rgb_level(n)
		if &t_Co == 88
			if a:n == 0
				return 0
			elseif a:n == 1
				return 139
			elseif a:n == 2
				return 205
			else
				return 255
			endif
		else
			if a:n == 0
				return 0
			else
				return 55 + (a:n * 40)
			endif
		endif
	endfun

	" Returns the palette index for the given R/G/B colour indices
	fun <SID>rgb_colour(x, y, z)
		if &t_Co == 88
			return 16 + (a:x * 16) + (a:y * 4) + a:z
		else
			return 16 + (a:x * 36) + (a:y * 6) + a:z
		endif
	endfun

	" Returns the palette index to approximate the given R/G/B colour levels
	fun <SID>colour(r, g, b)
		" Get the closest grey
		let l:gx = <SID>grey_number(a:r)
		let l:gy = <SID>grey_number(a:g)
		let l:gz = <SID>grey_number(a:b)

		" Get the closest colour
		let l:x = <SID>rgb_number(a:r)
		let l:y = <SID>rgb_number(a:g)
		let l:z = <SID>rgb_number(a:b)

		if l:gx == l:gy && l:gy == l:gz
			" There are two possibilities
			let l:dgr = <SID>grey_level(l:gx) - a:r
			let l:dgg = <SID>grey_level(l:gy) - a:g
			let l:dgb = <SID>grey_level(l:gz) - a:b
			let l:dgrey = (l:dgr * l:dgr) + (l:dgg * l:dgg) + (l:dgb * l:dgb)
			let l:dr = <SID>rgb_level(l:gx) - a:r
			let l:dg = <SID>rgb_level(l:gy) - a:g
			let l:db = <SID>rgb_level(l:gz) - a:b
			let l:drgb = (l:dr * l:dr) + (l:dg * l:dg) + (l:db * l:db)
			if l:dgrey < l:drgb
				" Use the grey
				return <SID>grey_colour(l:gx)
			else
				" Use the colour
				return <SID>rgb_colour(l:x, l:y, l:z)
			endif
		else
			" Only one possibility
			return <SID>rgb_colour(l:x, l:y, l:z)
		endif
	endfun

	" Returns the palette index to approximate the 'rrggbb' hex string
	fun <SID>rgb(rgb)
		let l:r = ("0x" . strpart(a:rgb, 0, 2)) + 0
		let l:g = ("0x" . strpart(a:rgb, 2, 2)) + 0
		let l:b = ("0x" . strpart(a:rgb, 4, 2)) + 0

		return <SID>colour(l:r, l:g, l:b)
	endfun

	" Sets the highlighting for the given group
	fun <SID>X(group, fg, bg, attr)
		if a:fg != ""
			exec "hi " . a:group . " guifg=#" . a:fg . " ctermfg=" . <SID>rgb(a:fg)
		endif
		if a:bg != ""
			exec "hi " . a:group . " guibg=#" . a:bg . " ctermbg=" . <SID>rgb(a:bg)
		endif
		if a:attr != ""
			exec "hi " . a:group . " gui=" . a:attr . " cterm=" . a:attr
		endif
	endfun

	" Vim Highlighting
	call <SID>X("Comment", s:comment, "", "")
	call <SID>X("Conditional", s:blue, "", "none")
	call <SID>X("Constant", s:purple, "", "")
	call <SID>X("Define", s:grey2, "", "none")
	call <SID>X("Directory", s:blue, "", "")
	call <SID>X("FoldColumn", "", s:background, "")
	call <SID>X("Folded", s:comment, s:background, "")
	call <SID>X("Identifier", s:steel, "", "none")
	call <SID>X("Include", s:brown, "", "")
	call <SID>X("NonText", s:selection, "", "")
	call <SID>X("Normal", s:foreground, s:background, "")
	call <SID>X("PreProc", s:red, "", "")
	call <SID>X("Special", s:purple, "", "")
	call <SID>X("SpecialKey", s:selection, "", "")
	call <SID>X("Statement", s:blue, "", "none")
	call <SID>X("String", s:green, "", "")
	call <SID>X("Structure", s:blue, "", "")
	call <SID>X("TabLine", s:foreground, s:background, "reverse")
	call <SID>X("Terminal", s:grey1, "", "")
	call <SID>X("Type", s:cyan, "", "none")
	call <SID>X("VertSplit", s:window, s:window, "none")
	call <SID>X("Visual", "", s:selection, "")
    call <SID>X("ColorColumn", "", s:line, "none")
    call <SID>X("CursorColumn", "", s:line, "none")
    call <SID>X("Function", s:foreground , "", "")
    call <SID>X("Number", s:violet, "", "")
    call <SID>X("PMenu", s:foreground, s:selection, "none")        " completion menu entries
    call <SID>X("PMenuSel", s:foreground, s:selection, "reverse") 
    call <SID>X("Repeat", s:blue, "", "")
    call <SID>X("SignColumn", "", s:background, "none")

    if (s:contrast == "high")
        " TODO
        call <SID>X("LineNr", "505050", "181818", "")
    else
        if &background == "light"
            call <SID>X("CtrlPMatch", "ffffff", "", "")
            call <SID>X("Cursor", "df0000", s:background, "reverse")
            call <SID>X("CursorLine", "e0e0e0", "505050", "none")          " ctrl-p selection etc
            call <SID>X("ErrorMsg", "b03030", s:background, "")
            call <SID>X("FoldColumn", "", s:background, "")
            call <SID>X("LineNr", "707070", "c7c0bc", "")
            call <SID>X("MatchParen", "ff5010", "202020", "")
            call <SID>X("ModeMsg", "c04010", "", "")
            call <SID>X("MoreMsg", "e0e0e0", "", "")
            call <SID>X("Question", "e0e0e0", "", "")
            call <SID>X("Search", "c0c0c0", "303060", "")
            call <SID>X("StatusLine", "3f683f", "", "")
            call <SID>X("StatusLineNC", "484848", "c0c0c0", "")
            call <SID>X("StatusLineTerm", "000000", "3f683f", "")
            call <SID>X("StatusLineTermNC", "c0c0c0", "484848", "")
            call <SID>X("Title", "2f7fa7", "", "")
            call <SID>X("Todo", "d02000", s:background, "")
            call <SID>X("WarningMsg", "805000", "", "")
            call <SID>X("qfError", "8f0000", "d0d0d0", "reverse")
            call <SID>X("qfLineNr", "d0d0d0", "", "")
        else
            call <SID>X("CtrlPMatch", "ffffff", "", "")
            call <SID>X("Cursor", "df0000", s:background, "reverse")
            call <SID>X("CursorLine", "e0e0e0", "505050", "none")          " ctrl-p selection etc
            call <SID>X("FoldColumn", "", s:background, "")
            call <SID>X("LineNr", "606060", "323232", "")
            call <SID>X("MatchParen", "ff5010", "202020", "")
            call <SID>X("ModeMsg", "c04010", "", "")
            call <SID>X("MoreMsg", "e0e0e0", "", "")
            call <SID>X("Question", "e0e0e0", "", "")
            call <SID>X("Search", "c0c0c0", "303060", "")
            call <SID>X("StatusLine", "4f7858", "", "")
            call <SID>X("StatusLineNC", "484848", "a0a0a0", "")
            call <SID>X("StatusLineTerm", "000000", "5f5f88", "")
            call <SID>X("StatusLineTermNC", "c0c0c0", "484848", "")
            call <SID>X("Title", "5fafd7", "", "")
            call <SID>X("Todo", "d7d75f", s:background, "")
            call <SID>X("WarningMsg", "f08040", "", "")
            call <SID>X("qfError", "8f0000", "d0d0d0", "reverse")
            call <SID>X("qfLineNr", "d0d0d0", "", "")
        endif
    endif


    " VimScript Highlighting 
    "call <SID>X("VimParenSep", s:foreground2, "", "")
    call <SID>X("VimVar", s:foreground, "", "")
    call <SID>X("VimFuncVar", s:purple, "", "")
    call <SID>X("VimOption", s:grey1, "", "")
	call <SID>X("vimCommand", s:steel, "", "none")


	" C/C++ Highlighting

    hi link cConditional Conditional
    hi link cCustomFunc Function
    hi link cDefine Define
    hi link cFormat String
    hi link cInclude Include
    hi link cNumber Number
    hi link cOperator Operator
    hi link cPreCondit Define
    hi link cPreProc PreProc
    hi link cRepeat Repeat
    hi link cStatement Statement
    hi link cStucture Structure
    hi link cType Type
    hi link cppNumber Number
    hi link cppStatement Statement
    hi link cppStructure Structure
    hi link cppType Type

    hi clear cppModifier
    

	""call <SID>X("cCppOutElse", "ffc8c8", "", "")
    "call <SID>X("cCustomClass", "909090", "", "")
    "call <SID>X("cFormat", "90bf90", "", "")
    "call <SID>X("cLabel", s:foreground2, "", "")
    "call <SID>X("cSpecial", "90bf90", "", "")
    call <SID>X("cBlock", "ffff00", "", "")
    call <SID>X("cBracket", "ffff00", "", "")
    call <SID>X("cCustomClass", s:grey1, "", "")
    call <SID>X("cCustomScope", s:grey2, "", "")
    call <SID>X("cPreCondit", s:red, "", "")
    call <SID>X("cStorageClass", s:purple, "", "")
    call <SID>X("cppCast", s:red, "", "")
    call <SID>X("cppExceptions", s:violet, "", "")
    call <SID>X("cppModifier", s:foreground, "", "")


	" Python Highlighting
	""call <SID>X("pythonOperator", "c080c0", "", "")
	"call <SID>X("PythonStatement", "8090ff", "", "")
	"call <SID>X("pythonConditional", "8090ff", "", "")
	"call <SID>X("pythonException", "c06080", "", "")
	"call <SID>X("pythonExceptions", "f07080", "", "")
	"call <SID>X("pythonInclude", "7080ff", "", "")
	"call <SID>X("pythonOperator", "8090ff", "", "")
	"call <SID>X("pythonRepeat", "8090ff", "", "")
	"call <SID>X("pythonStatement", s:purple, "", "")
    "call <SID>X("pythonDecorator", "e06080", "", "")
    "call <SID>X("pythonNumber", "e06080", "", "")

    "hi link pythonFunction Function
    hi link PythonNumber Number
    hi link Repeat Statement
    hi link pythonConditional Conditional
    hi link pythonRepeat Repeat
    hi link pythonStatement Statement
 
	call <SID>X("pythonBuiltin", s:purple, "", "")
	call <SID>X("pythonInclude", s:purple, "", "")
    call <SID>X("pythonDecoratorName", s:red, "", "")
    call <SID>X("pythonFunction", s:cyan, "", "")
    call <SID>X("pythonSelf", s:grey2, "", "")


	" JavaScript Highlighting
    "
	call <SID>X("javaScriptBraces", s:foreground, "", "")
	call <SID>X("javaScriptFunction", s:purple, "", "")
	call <SID>X("javaScriptConditional", s:purple, "", "")
	call <SID>X("javaScriptRepeat", s:purple, "", "")
	call <SID>X("javaScriptNumber", s:orange, "", "")
	call <SID>X("javaScriptMember", s:orange, "", "")
    call <SID>X("jsThis", "a0a0a0", "", "")
    hi link jsNumber Number
    call <SID>X("jsOperator", "d0d0d0", "", "")
	"call <SID>X("jsFunction", "8080e0", "", "")


	" HTML Highlighting
	"call <SID>X("htmlTag", "c0c0c0", "", "")
	"call <SID>X("htmlEndTag", "c0c0c0", "", "")
	"call <SID>X("htmlTitle", "c050c0", "", "")
	"call <SID>X("htmlH1", "ff5050", "", "")
	"call <SID>X("htmlValue", "d060a0", "", "")
    "call <SID>X("htmlTagName", "8090ff", "", "")
    "call <SID>X("htmlSpecialTagName", "d06090", "", "")
    "hi link htmlTagName Statement
	"call <SID>X("htmlArg", "60b0f0", "", "")
	"call <SID>X("htmlScriptTag", "d0d0d0", "", "")
	" Go Highlighting
	"call <SID>X("goStatement", s:purple, "", "")
	"call <SID>X("goConditional", s:purple, "", "")
	"call <SID>X("goRepeat", s:purple, "", "")
	"call <SID>X("goException", s:purple, "", "")
	"call <SID>X("goDeclaration", s:blue, "", "")
	"call <SID>X("goConstants", s:yellow, "", "")
	"call <SID>X("goBuiltins", s:orange, "", "")

	" CoffeeScript Highlighting
	call <SID>X("coffeeKeyword", s:purple, "", "")
	call <SID>X("coffeeConditional", s:purple, "", "")

    "
    " Rust highlighting
    " Hardcoded, rusty look
    "
    "call <SID>X("rustString", "80af80", "", "")
    "call <SID>X("rustSelf", "9e9e9e", "", "")
    "call <SID>X("rustModPath",   "9e9e9e", "", "")
    "call <SID>X("rustModPathSep",   "87af85", "", "")
    "call <SID>X("rustStorage", "ff9330", "", "")
    "call <SID>X("rustKeyword", "b98053", "", "")
    "call <SID>X("rustIdentifier", "e9a073", "", "")
    "call <SID>X("rustConditional", "b98053", "", "")
    "call <SID>X("rustMacro",       "d06050 ", "", "")
    "call <SID>X("rustOperator",       "e0e0e0", "", "")
    "call <SID>X("rustAttribute",       "a0a0a0", "", "")
    "call <SID>X("rustDerive",       "a0a0a0", "", "")
    "call <SID>X("rustSigil",       "e0e0e0", "", "")
    "call <SID>X("rustFloat",       "f4e1d4", "", "")
    ""call <SID>X("rustDecNumber",       "f4e1d4", "", "")
    "call <SID>X("rustDecNumber",       "80a0d0", "", "")
    "call <SID>X("rustFloat",       "80a0d0", "", "")
    "call <SID>X("rustEnum",       "e8a820", "", "")
    "call <SID>X("rustEnumVariant",       "e8a820", "", "")
    "call <SID>X("rustType",       "d06030", "", "")
    "call <SID>X("rustTypeDef",       "d06030", "", "")
    "call <SID>X("rustRepeat", "b98053", "", "")
    ""call <SID>X("rustRepeat",       "80afd7", "", "")
    ""call <SID>X("rustBoolean",       "f4e1d4", "", "")
    "call <SID>X("rustBoolean",       "80a0d0", "", "")
    "call <SID>X("rustStructure",       "87af87", "", "")
    "call <SID>X("rustLifeTime", "70b0d0", "", "")
    "call <SID>X("rustFuncCall", "a0a0a0", "", "")
    "call <SID>X("rustFunction", "d7af87", "", "")
    "call <SID>X("rustFuncName", "d7af87", "", "")

    "hi link rustMacro Normal
    hi link rustDecNumber Number
    hi link rustFuncCall Normal
    hi link rustFuncName Function
    hi link rustKeyword Statement
    hi link rustModPath Normal
    hi link rustOperator Normal
    hi link rustString String

    call <SID>X("rustEnumVariant", s:grey1, "", "")
    call <SID>X("rustMacro", s:red, "", "")


	" Diff Highlighting
    let s:diffbackground = "494e56"
	call <SID>X("diffAdded", s:green, "", "")
	call <SID>X("diffRemoved", s:red, "", "")
    call <SID>X("DiffAdd", s:green, s:diffbackground, "")
    call <SID>X("DiffDelete", s:red, s:diffbackground, "")
    call <SID>X("DiffChange", s:yellow, s:diffbackground, "")
    call <SID>X("DiffText", s:diffbackground, s:orange, "")

    " ShowMarks Highlighting
    call <SID>X("ShowMarksHLl", s:orange, s:background, "none")
    call <SID>X("ShowMarksHLo", s:purple, s:background, "none")
    call <SID>X("ShowMarksHLu", s:yellow, s:background, "none")
    "call <SID>X("ShowMarksHLm", s:aqua, s:background, "none")

	" Delete Functions
	delf <SID>X
	delf <SID>rgb
	delf <SID>colour
	delf <SID>rgb_colour
	delf <SID>rgb_level
	delf <SID>rgb_number
	delf <SID>grey_colour
	delf <SID>grey_level
	delf <SID>grey_number
endif
