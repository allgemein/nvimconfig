let g:python3_host_prog = '/Users/amanetamada/.pyenv/versions/3.7.5/bin/python'

if &compatible
  set nocompatible
endif

set runtimepath+=/Users/amanetamada/.cache/dein/repos/github.com/Shougo/dein.vim

if dein#load_state('/Users/amanetamada/.cache/dein')
  call dein#begin('/Users/amanetamada/.cache/dein')

  call dein#load_toml('~/.config/nvim/dein.toml', {'lazy': 0})

  call dein#end()
  call dein#save_state()
endif

if dein#check_install()
  call dein#install()
endif

filetype plugin indent on
colorscheme jellybeans

set title
set number
set list
set nowritebackup
set noswapfile
set noerrorbells
set tabpagemax=25
set shellslash
set showmatch matchtime=1

set guioptions-=T
set guioptions-=m
set guioptions-=r
set guioptions-=R
set guioptions-=l
set guioptions-=L
set guioptions-=b
set cursorline

set smartindent
set smarttab
set laststatus=2
set tabstop=4
set shiftwidth=4
set expandtab
set showtabline=2 
set noshowmode 

set mouse=a
set display=lastline
set ambiwidth=double
set pumheight=8
set background=dark

set clipboard=unnamed
set encoding=utf-8
set fileencodings=utf-8,euc-jp,cp932
set matchpairs+=「:」,『:』,（:）,【:】,《:》,〈:〉,［:］,‘:’,“:”

nnoremap <Esc><Esc> :nohlsearch<CR><ESC>
noremap <silent> <M-t> :!clang-format % -style=Google -i<CR>
nnoremap Y y$
nnoremap j gj
nnoremap k gk
nmap <C-o> o<ESC>
nnoremap <silent>fi :<C-u>Defx -split=vertical -winwidth=40 -search=`expand('%:p')` -direction=topleft `expand('%:p:h')`<CR>

inoremap <expr><C-g> neocomplcache#undo_completion()
inoremap <expr><C-l> neocomplcache#complete_common_string()
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
imap <C-k> <Plug>(neosnippet_expand_or_jump)
smap <C-k> <Plug>(neosnippet_expand_or_jump)
xmap <C-k> <Plug>(neosnippet_expand_target)
smap <expr><TAB> neosnippet#expandable_or_jumpable() ?

augroup tex
	autocmd!
	autocmd BufNewFile,BufRead *.ltx  nnoremap <silent>run :!latexmk % -pvc<CR>
augroup END

augroup cpptool
	autocmd!
	autocmd BufNewFile,BufRead *.ino set filetype=cpp
	autocmd BufNewFile,BufRead *.cpp,*.c nnoremap <M-r> :!g++ % -Wall<CR>
	autocmd BufNewFile,BufRead *.cpp,*.c nnoremap <silent>run :QuickRun -command g++ -outputter quickfix -cmdopt -Wall -input =@<CR>
	autocmd BufNewFile,BufRead *.cpp,*.c let g:lsp_diagnostics_enabled = 0
augroup END

augroup jstool
	autocmd!
	autocmd BufNewFile,BufRead *.js set shiftwidth=2
augroup END


function! s:clang_format()
	let now_line = line(".")
	exec ":%! clang-format"
	exec ":" . now_line
endfunction

if executable('clang-format')
	augroup cpp_clang_format
		autocmd!
		autocmd BufWrite,FileWritePre,FileAppendPre *.[ch]pp,*.c,*.ino,*.h call s:clang_format()
	augroup END
endif

if has('persistent_undo')
  set undodir=~/.vim/undo
  set undofile
endif
