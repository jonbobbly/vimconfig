function! RpgFolds()
	let thisline = getline(v:lnum)
	if match(thisline, "^#") >= 0
		return ">1"
	elseif match(thisline, "^_") >= 0
		return "0"
	else
		return "="
	endif
endfunction
function! RpgFoldText()
	return getline(v:foldstart)
endfunction

setlocal foldmethod=expr
setlocal foldexpr=RpgFolds()
setlocal foldtext=RpgFoldText()

