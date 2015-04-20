execute pathogen#infect()
filetype plugin on
let g:task_rc_override = 'rc.defaultwidth=999'

" General settings

set nocompatible  "Compatible schmapatible.
set showmode      "Show --Insert-- etc.
set showcmd       "Show typed commands
set nowrap        "Don't wrap long lines
set incsearch     "Incremental search. Fantastic
set stl=%f\ %m\ %r\ Line:\ %l/%L[%p%%]\ Col:\ %c\ [%v]
set laststatus=2  "Always display status line
set ch=2          "lines for command-line
set ai            "turn on auto indent
set fo=w2tq       "format options
set listchars=tab:>-,trail:- "what's display when :set list
set backspace=indent,eol,start
syntax on     "syntax highlighting
"colors
colo slate
hi StatusLine ctermfg=gray ctermbg=black
hi LineNr ctermfg=blue | "Line numbers are blue
hi ColorColumn ctermbg=darkgrey ctermfg=red

vnoremap ;bc "ey:call CalcBC()<CR>
map ,ref :e ~/.vim/info/reference.txt<CR>
"Numbering Commands
map ,sl :set list!<CR>
map ,sn :set number!<CR>
map ,sr :set rnu!<CR>
"Date/Time
map <F4> "=strftime("%Y/%m/%d %H:%M:%S")<CR>p
"ASCII Related
map <F5> <ESC>:call Hr()<CR>
map ,h1 yypVr=
map ,h2 yypVr-
map ,h3 I=<ESC>A=<ESC>
map ,h4 I-<ESC>A-<ESC>
map ,sp :s/\p/& /g<CR>$x
"For use with ~/.vim/sessions/ascii.vim
map _ascii :so ~/.vim/sessions/ascii.vim<CR>
map _gtd :so ~/.vim/sessions/gtd.vim<CR>
map _notes :call NoteSplit()<CR>
"Unmapping annoyances
imap <C-p> <esc>
"gnuplot
map <F2> :silent !gnuplot %<CR>:redraw!<CR>
"word count
map <F3> :s/\i\+/&/gn<CR>
"sort entries in LaTeX dictionary
map ,ds :sort /.\{-}\ze\}/ r<CR>
"spelling
map <F6> :silent !pdflatex %<CR>:redraw!<CR>
map <F7> :setlocal spell! spelllang=en_us<CR>

map ,j {!}par -jw60<CR>

map ,b ggVGd:re !ledger -f bells.dat bal assets liab<CR>o<CR><ESC>:re !ledger -f bells.dat --invert -p today bal income expenses<CR>

"working with folds
set foldmethod=marker
set foldtext=CustomFoldText()

"nerd tree toggle
map <C-n> :NERDTreeToggle<CR>


" Functions

function Hr (...)
  if a:0>0          
    let char=a:1   
  else
    let char="_"  
  endif
  if a:0>1       
    let width=a:2 
  else
    let width=&tw 
  endif
  let i=0
  let str=""
  while i<width
    let str=str.char
    let i+=1
  endwhile
  call setline(".",str)
endfunction

"http://www.gregsexton.org/2011/03/improving-the-text-displayed-in-a-fold/
fun! CustomFoldText()
    "get first non-blank line
    let fs = v:foldstart
    while getline(fs) =~ '^\s*$' | let fs = nextnonblank(fs + 1)
    endwhile
    if fs > v:foldend
        let line = getline(v:foldstart)
	let line = substitute(line, '{', '', 'g') "My addition
    else
        let line = substitute(getline(fs), '\t', repeat(' ', &tabstop), 'g')
	let line = substitute(line, '{', '', 'g') "My addition
    endif

    let w = winwidth(0) - &foldcolumn - (&number ? 8 : 0)
    let foldSize = 1 + v:foldend - v:foldstart
    let foldSizeStr = " " . foldSize . " lines "
    let foldLevelStr = repeat("+--", v:foldlevel)
    let lineCount = line("$")
    let foldPercentage = printf("[%.1f", (foldSize*1.0)/lineCount*100) . "%] "
    let expansionString = repeat(".", w - strwidth(foldSizeStr.line.foldLevelStr.foldPercentage))
    return line . expansionString . foldSizeStr . foldPercentage . foldLevelStr
endf

fun! NoteSplit()
	NERDTreeToggle
	vertical resize 50
	wincmd l
	vsplit
	exe 3 . "wincmd w"
	vertical resize 70
	split
	set number
	wincmd j
	resize 15
	TW
	exe 2 . "wincmd w"
	set number

endf
