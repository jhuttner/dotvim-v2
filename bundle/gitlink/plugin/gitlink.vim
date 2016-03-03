function! s:gitlink()
	echo system("git link " . expand("%") . " " . line("."))
	call system("which pbcopy")
	if ! v:shell_error
		call system("git link " . expand("%") . " " . line(".") . " | pbcopy")
	endif
endfunction

command! -nargs=0 -bar Gitlink call s:gitlink()
