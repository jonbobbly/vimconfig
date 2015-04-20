syn region testComment start="\/\*" end="\*\/"
syn match testTag "|\w*|" contains=testBar
syn match testLabel "\*[-0-9A-Za-z_]*\*" contains=testStar
syn match testBar contained "|"
syn match testStar contained "*"
syn match testRule "^=*$"
syn match testHead "^[A-Za-z][A-Za-z ]*»"
syn match testThingy "[A-Za-z0-9 ]*:\t"

hi def link testComment Comment
hi def link testTag Identifier
hi def link testLabel Constant
hi def link testBar Ignore
hi def link testStar Ignore
hi def link testRule Comment
hi def link testHead Special
hi def link testThingy Type
