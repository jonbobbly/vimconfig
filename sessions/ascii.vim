"file browser settings
let g:netrw_chgwin=2  "Open files in the second window
let g:netrw_banner=0  "Don't print the banner.

on                  "close all windows but this one.
vsplit              "left column
vsplit              "and right column
1wincmd w           "Jump to the left column
vertical resize 50  "resize the column to 50 wide
3wincmd w           "jump to the last column
split               "split it into two
vertical resize 70  "resize the column to 70 wide
1wincmd w           "jump back to first window to load files
edit ~/.vim/info/mappings.txt
3wincmd w           "jump to top of last column
edit ~/.vimrc
wincmd w            "last window
resize 15           "This window doesn't need to be very tall.
edit .
normal gh
windo set tw=60     "tw=60 in all windows.
3wincmd w
set number
2wincmd w
set number          "turn on line numbers in main window.

"mappings
map ,cc :new<CR><C-w>j:close<CR>
map ,cc! :new<CR><C-w>j:q!<CR>
map ,notes :let bnum=bufnr("%")<CR>3<C-w>w:exec "b" bnum<CR>
map ,main :let bnum=bufnr("%")<CR>2<C-w>w:exec "b" bnum<CR>
map _ascii :so ~/.vim/sessions/ascii.vim<CR>

"color columns
match Error /.\%>61v/

