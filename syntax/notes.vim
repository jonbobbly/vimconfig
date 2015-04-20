" Vim syntax file
" Language: Note-taking
" Maintainer: Jonathon Bly
" Latest Revision: 2014 June 13

if exists("b:current_syntax")
	finish
endif

syn clear

let b:current_syntax = "notes"

"Keywords
syn match noteSubHeader /^\p*{$/ contains=noteStartFold
syn match noteFoldHeader /^[A-Z: ]* {$/ contains=noteStartFold
syn match noteStartFold /{$/
syn match noteEndFold /^}$/
syn match noteDetails /^>>/
syn region noteFile start="*" end="*"

"Highlights
hi noteFoldHeader ctermfg=green ctermbg=DarkGray
hi noteSubHeader ctermfg=blue
hi noteStartFold ctermfg=DarkGray
hi noteEndFold ctermfg=DarkGray
hi noteDetails ctermfg=blue
hi Folded ctermbg=DarkGray
hi noteFile ctermfg=magenta

set tw=60
set fdm=marker
set fmr={,}
