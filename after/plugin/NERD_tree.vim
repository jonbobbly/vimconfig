call NERDTreeAddMenuItem({'text': 'e(x)ecute', 'shortcut': 'x', 'callback': 'NERDTreeExecute'})

function! NERDTreeExecute()
	let treenode = g:NERDTreeFileNode.GetSelected()
	let path = treenode.path.str()

	let cmd = shellescape(path,1)
	exe "silent !".cmd

	redraw!
endfunction
