execute pathogen#infect()
syntax on
filetype plugin indent on

let mapleader = ","

set nocompatible
set modelines=10
set modeline

set viminfo='100,\"1000,:100,%,n~/.viminfo

function! ResCur()
  if line("'\"") <= line("$")
    normal! g`"
    return 1
  endif
endfunction

augroup resCur
  autocmd!
  autocmd BufWinEnter * call ResCur()
augroup END

let g:syntastic_mode_map = { 'mode': 'active',
    \ 'active_filetypes': [],
    \ 'passive_filetypes': [] }

let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_warning_symbol = 'WW'
let g:syntastic_error_symbol = 'EE'

function! Change_dir ()
	let path = expand('%:p:h')
	let adnxs_dir = system('dirgetter.sh ' . path)
	if adnxs_dir != ''
		execute  'lcd ' . adnxs_dir
	endif
endfunction
"au! BufEnter * call Change_dir()

augroup filetype
	au!
	au! BufRead,BufNewFile *.phtml set ft=php.html " For SnipMate
	au! BufRead,BufNewFile *.tpl set ft=html " For SnipMate
	au BufNewFile,BufRead .tmux.conf*,tmux.conf*,tmux.* setf tmux
augroup END

au FileType puppet set noexpandtab
au FileType jinja set filetype=python
au FileType txt set tabstop=2 shiftwidth=2 expandtab
au FileType python set tabstop=2 shiftwidth=2 expandtab
au FileType coffee set tabstop=2 shiftwidth=2 expandtab
au FileType php set tabstop=2 shiftwidth=2
au FileType md set tabstop=2 shiftwidth=2 expandtab
au FileType markdown set tabstop=2 shiftwidth=2 expandtab
au FileType * vmap y y`]

"File type for autoclose tag to work on phtml files
au FileType xhtml,phtml,xml ru ftplugin/html/autoclosetag.vim

" from tpope
set cmdheight=2
set complete-=i     " Searching includes can be slow
set dictionary+=/usr/share/dict/words
set display=lastline
set nofoldenable

" new stuff - http://stevelosh.com/blog/2010/09/coming-home-to-vim/
set encoding=utf-8
set scrolloff=3
set cindent
set smartindent
set autoindent
set showmode
set showcmd
set hidden
"execute "set colorcolumn=" . join(range(81,100), ',')
" automatically write a file when leaving a modified buffer"
set autowrite
set wildmenu
set wildmode=list:longest
set visualbell
set cursorline
set ttyfast
set ruler
set backspace=indent,eol,start
set laststatus=2
set number
"set relativenumber
set undodir=~/.vim/undodir
set undofile
set undolevels=1000
set undoreload=10000
set t_Co=256

" old
set shiftwidth=2
set tabstop=2
set noexpandtab
set showmatch
set ignorecase
set incsearch
set autowrite
set bs=2
set hls
set bg=dark
set nowrap
set pastetoggle=<F2>
set wildignore=*Zend*,.git,*.pyc,*bundles*,*jpgraph*,*Smarty*,*smarty*,django_test*,backups/2010*,images*,graphs*,*amcharts*,.csv,*un~*,*swp*,library/adodb*,current/*,*node_modules*,_site/*,ENV*,BASELINE*,htmlcov*
set foldmethod=marker
"set statusline=%<\ %n:%f\ %m%r%y%=%-35.(line:\ %l\ of\ %L,\ col:\ %c%V\ (%P)%)
"set statusline+=%{fugitive#statusline()}
set statusline=%<\ %n:%f\ %m%r%y%=%-35.(line:\ %l\ of\ %L,\ col:\ %c%V\ (%P)%)
set statusline+=%{fugitive#statusline()}
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
set statusline+=%F

"Save on Lose Focus
au FocusLost * :wa

let mapleader = ","

" Set no max file limit
let g:ctrlp_max_files = 0
" Search from current directory instead of project root
let g:ctrlp_working_path_mode = 0

"*******************************************
"*******************************************
"****** COMMAND MODE REMAPPINGS ************
"*******************************************
"*******************************************

noremap <leader>y y :PBCopy<CR>
noremap <leader>g :set paste!<CR>
nnoremap <leader>s /<C-p>
nnoremap <leader>gg <C-g>
nnoremap <leader>w :w<CR>
nnoremap <leader>m 0<C-w>\|
"nnoremap <leader>q :q<CR>
nnoremap <leader>k :nohlsearch<CR>
nnoremap <leader>f :CommandTFlush<CR>
nnoremap <leader>n :CommandTBuffer<CR>
nnoremap <leader>h :CtrlP<CR>
nnoremap <leader>r gqip
nnoremap <leader>b :CtrlPBuffer<CR>
"nnoremap <leader>m :CtrlPMixed<CR>
nnoremap <leader>z <C-w>=
nnoremap <leader>ev <C-w><C-v><C-l>:e $MYVIMRC<CR>
nnoremap <leader>ed :! mkdiff<CR>
nnoremap <leader>et :e /tmp/gitdiff<CR>
nnoremap <leader>l :source ~/.vimrc<CR>
"nnoremap <leader>b :w !/home/jhuttner/ENV/bin/python -m py_compile<CR>
nnoremap <F2> :JSHint<CR>:clast<CR>


"Yank Ring Plugin
nnoremap <silent> <F4> :YRShow<CR>
let g:yankring_window_height = 20

"Gundo
"nnoremap <F5> :GundoToggle<CR>

"NERDTree
nnoremap <F6> :NERDTreeToggle<CR>

"Open a vertically-split window, and focus on it.
nnoremap <leader>v <C-w>v<C-w>l

"Carriage Return to toggle between files in window
nnoremap <CR> :wa<CR><C-^>

"Make every command easier!
nnoremap ; :

"Select text after paste
"nnoremap <expr> gp '`[' . strpart(getregtype(), 0, 1) . '`]'
nnoremap gp `[v`]

"sudo vim <file> if vim <file> complains about permissions
cnoremap w!! w !sudo tee % >/dev/null

"make :ww be a regular save
cnoremap ww w<CR>

"strip trailing whitespace
nnoremap <leader>c :%s/\s\+$<CR>

"support for sessions.  quick and easy.
"cnoremap sesh mksession! ~/.vim_session
"cnoremap lsesh source ~/.vim_session

"Easier splits navigation - Remapped Caps Lock to Control
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l
nnoremap <C-t> <C-w>t
"nnoremap <C-v> "ayaw :%s/\=@a/\=@a/gn
inoremap <C-t> <ESC>

"searching
"nnoremap / /\v
"vnoremap / /\v
set ignorecase
set smartcase
set gdefault
set incsearch
set showmatch
set hlsearch
nnoremap <leader><space> :noh<CR>
"nnoremap <tab> %
"vnoremap <tab> %

" Better scrolling
nnoremap <Space> <C-F>
nnoremap t <C-B>

" Smooth scroll up one line
nnoremap r  <C-Y>
" Smooth scroll down one line
"nnoremap f  <C-E>

"*******************************************
"*******************************************
"****** INSERT MODE REMAPPINGS *************
"*******************************************
"*******************************************
inoremap jj <ESC>

" colorscheme
syntax enable
"set synmaxcol=120
"colorscheme darkblue
" highlight ColorColumn ctermbg=493

set directory=/home/jhuttner/.swp

" for markdown file editing
autocmd BufRead *\.markdown setlocal formatoptions=l
autocmd BufRead *\.markdown setlocal lbr
autocmd BufRead *\.markdown map  j gj
autocmd BufRead *\.markdown map  k gk
autocmd BufRead *\.markdown setlocal smartindent
autocmd BufRead *\.markdown setlocal spell spelllang=en_us
autocmd BufRead *\.markdown setlocal wrap
autocmd BufRead *\.markdown setlocal nocursorline
autocmd BufRead *\.markdown setlocal nu

hi Visual term=underline cterm=underline ctermfg=15 ctermbg=4 guifg=#90fff0 guibg=#2050d0
