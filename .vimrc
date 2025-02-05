set tabstop=4
set nocompatible
set backspace=indent,eol,start
set number
set nobackup
set noswapfile
set mouse=a
set guifont=Consolas:h16
set showmatch
set autoread
set laststatus=2
set termguicolors
set shiftwidth=4
set smartindent
syntax enable
syntax on
filetype plugin on
let g:vim_markdown_folding_disabled = 1            " 禁用 Markdown 自动折叠
let g:vim_markdown_math = 1                        " 启用 LaTeX 支持
let g:ale_fixers = {
			\   '*': ['remove_trailing_lines', 'trim_whitespace']
			\}
let g:ale_fix_on_save = 1
let g:instant_markdown_mathjax = 1
let g:airline#extensions#ale#enabled = 1
let g:ale_lint_on_enter = 0
let g:ale_lint_on_save = 1
let g:ale_lint_on_filetype_changed = 0
let g:ale_lint_on_insert_leave = 0
let g:ale_lint_on_text_changed = 0
let g:ale_sign_error = '>>'
let g:ale_sign_warning = '->'
let g:ale_cpp_cc_options = '-std=c++17 -O2 -static -Wall -Wl,--stack=51200000000'
call plug#begin('~/.vim/plugged')
	Plug 'chxuan/vimplus-startify'                 " 启动界面
	Plug 'scrooloose/nerdtree'                     " 目录树
	Plug 'tiagofumo/vim-nerdtree-syntax-highlight' " 目录树美化
	Plug 'vim-airline/vim-airline'                 " 状态栏美化
	Plug 'vim-airline/vim-airline-themes'          " 状态栏美化主题
	Plug 'tpope/vim-commentary'                    " 快速注释
	Plug 'dense-analysis/ale'                      " 语法错误提示
	Plug 'Lokaltog/vim-easymotion'                 " 快速跳转
	Plug 'yianwillis/vimcdoc'                      " HELP 文档中文
	Plug 'jacoborus/tender.vim'                    " 配色方案
"	Plug 'jiangmiao/auto-pairs'                    " 自动补全
	Plug 'tribela/vim-transparent'
	Plug 'rhysd/vim-clang-format'                  " clang-format 代码格式化
	Plug 'godlygeek/tabular'                       " vim-markdown 前置
	Plug 'preservim/vim-markdown'                  " Markdown 支持
	Plug 'pangloss/vim-javascript'                 " JavaScript 支持
	Plug 'tpope/vim-fugitive'                      " Git 支持
	" Plug 'github/copilot.vim'
"	Plug 'instant-markdown/vim-instant-markdown', {'for': 'markdown', 'do': 'yarn install'} " Mardown 即时渲染
call plug#end()
nnoremap <C-i> :PlugInstall<CR>
nnoremap <C-o> :NERDTreeToggle<CR>
nnoremap <C-q> :q<CR>
nnoremap <C-t> :term<CR>
nnoremap <F6> :call CompileWithGpp()<CR>
nnoremap <F7> :call Run()<CR>
nnoremap <F8> :call CompileWithGpp()<CR> :call Run()<CR>
nnoremap <F11> :call CompileWithGpp()<CR> :call Run()<CR>
nnoremap <F3> :call Init()<CR>
nnoremap <C-j> :tabn<CR>
nnoremap <C-k> :tabp<CR>
nnoremap <C-n> :tabnew<CR>
nnoremap J 5j
nnoremap K 5k
nnoremap H 5h
nnoremap L 5l
vnoremap J 5j
vnoremap K 5k
vnoremap H 5h
vnoremap L 5l
func! CompileWithGpp()
	exec "w"
	exec '!g++ "%" -o "%<" -std=c++17 -O2 -DLOCAL -Wall -static -Wl,--stack=512000000'
endfunc
func! Init()
	if &term == 'win32'
		exec '!copy /Y /A ..\foo.cpp "%"'
	else
		exec '!cp ../foo.cpp "%"'
	endif
endfunc
func! Run()
	if &term == 'win32'
		exec '! "%<.exe"'
	else
		exec '! ulimit -s unlimited && "./%<"'
	endif
endfunc
imap <UP> <Nop>
imap <DOWN> <Nop>
imap <LEFT> <Nop>
imap <RIGHT> <Nop>
map <tab> <Nop>
map <UP> <Nop>
map <DOWN> <Nop>
map <LEFT> <Nop>
map <RIGHT> <Nop>
let g:AutoPairsMapCR = 0
colorscheme tender
set langmenu=zh_CN.UTF-8
set helplang=cn
set termencoding=utf-8
set encoding=utf8
if &term =~ "xterm"
	let &t_SI = "\<Esc>[6 q"
	let &t_SR = "\<Esc>[3 q"
	let &t_EI = "\<Esc>[2 q"
endif
au GUIEnter * call libcallnr("vimtweak.dll", "SetAlpha", 234)
set t_Co=256
hi Normal ctermfg=252 ctermbg=none

let g:transparent_groups = ['Normal', 'Comment', 'Constant', 'Special', 'Identifier',
							\ 'Statement', 'PreProc', 'Type', 'Underlined', 'Todo', 'String',
							\ 'Function', 'Conditional', 'Repeat', 'Operator', 'Structure',
							\ 'LineNr', 'NonText', 'SignColumn', 'CursorLineNr', 'EndOfBuffer']
" Change cursor shape
" Note: This should be set after `set termguicolors` or `set t_Co=256`.
if &term =~ 'xterm' || &term == 'win32'
	" Use DECSCUSR escape sequences
	let &t_SI = "\e[5 q"    " blink bar
	let &t_SR = "\e[3 q"    " blink underline
	let &t_EI = "\e[1 q"    " blink block
	let &t_ti .= "\e[1 q"   " blink block
	let &t_te .= "\e[0 q"   " default (depends on terminal, normally blink block)
endif
