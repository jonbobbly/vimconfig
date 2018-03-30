filetype plugin indent on


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"  Appearance settings
"
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
syntax on
set nocompatible  "Compatible schmapatible.
set showmode      "Show --Insert-- etc.
set showcmd       "Show typed commands
set nowrap
set incsearch     "Incremental search. Fantastic
set stl=%f\ %m\ %r\ Line:\ %l/%L[%p%%]\ Col:\ %c\ [%v]
set laststatus=2  "Always display status line
set ch=2          "lines for command-line
set ai            "turn on auto indent
set fo=w2tq       "format options
set listchars=tab:>-,trail:- "what's displayed when :set list
set backspace=indent,eol,start
set foldmethod=marker
set foldtext=CustomFoldText()


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"  Dealing with vimturds
"
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set dir=~/vimswap//



""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"  Colors
"
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function s:fix_colors()
	hi StatusLine ctermfg=gray ctermbg=black
	hi LineNr ctermfg=blue 
endfunction
autocmd! ColorScheme my_slate call s:fix_colors()
colorscheme my_slate
hi! Folded ctermbg=black


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"  Simple Mappings
"
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
map ,h1 yypVr=
map ,h2 yypVr-
map ,h3 I=<ESC>A=<ESC>
map ,h4 I-<ESC>A-<ESC>
map ,sl :set list!<CR>
map ,sn :set number!<CR>
map ,sp :s/\p/& /g<CR>$x
map ,sr :set rnu!<CR>
map <F2> :silent !gnuplot %<CR>:redraw!<CR>
map <F4> "=strftime("%Y-%m-%d %H:%M:%S")<CR>p
map <F6> :silent !pdflatex %<CR>:redraw!<CR>
map <F7> :setlocal spell! spelllang=en_us<CR>
nmap ,ml Go<ESC>60i_<ESC>o vim:tw=60<ESC>:w<CR>:e<CR>
nnoremap <Leader>p :set paste<CR>o<esc>"*p<esc>:set nopaste<cr>
"Unmapping annoyances
imap <C-p> <esc>


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"  Functions
"
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"  Horizontal Rule
map <F5> <ESC>:call Hr()<CR>
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

"  Live word count
let g:word_count="<unknown>"
set statusline+=\ %{WordCount()}\ words
function! WordCount()
	return g:word_count
endfunction
function! UpdateWordCount()
	let lnum = 1
	let n = 0
	while lnum <= line('$')
		let n = n + len(split(getline(lnum)))
		let lnum = lnum + 1
	endwhile
	let g:word_count = n
endfunction
set updatetime=1000
augroup WordCounter
	au! CursorHold,CursorHoldI * call UpdateWordCount()
augroup END


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"  NERD Tree settings
"
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
map <C-n> :NERDTreeToggle<CR>


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"  GoYo -- writeroom-like environment.
"
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
map ,g :Goyo<CR>

let g:goyo_width=62
let g:goyo_height=30

fun! s:goyo_enter()
	set scrolloff=999
	set tw=60
	if exists('$TMUX')
		silent !tmux set status off
	endif
endf
fun! s:goyo_leave()
	set scrolloff=0
	if exists('$TMUX')
		silent !tmux set status on
	endif
	colorscheme my_slate
endf
autocmd! User GoyoEnter nested call <SID>goyo_enter()
autocmd! User GoyoLeave nested call <SID>goyo_leave()
