"""""""""""""""""""""""""""""""""""""""
"Utils {{{
"""""""""""""""""""""""""""""""""""""""
set nocompatible

function! s:System()
	if has("win32")
		return "windows"
	else
		if has("mac")
			return "mac"
		else
			return "linux"
		endif
	endif
endfunction

if s:System() == "linux"
	vmap <C-c> "+y
	vmap <C-x> "+c
	vmap <C-v> c<ESC>"+p
	imap <C-v> <ESC>"+pa
	noremap <C-v> "+p
endif

"""""""""""""""""""""""""""""""""""""""
"Utils }}}
"""""""""""""""""""""""""""""""""""""""


"""""""""""""""""""""""""""""""""""""""
"Gerneral {{{
"""""""""""""""""""""""""""""""""""""""

" Enable filetype plugin
filetype plugin on
filetype indent on

" Set to auto read when a file is changed from the outside
set autoread

augroup user_general
	autocmd!
	autocmd BufWritePost .vimrc source ~/.vimrc
	autocmd BufEnter * silent! lcd %:p:h
	autocmd BufWinLeave *.* silent! mkview 1
	autocmd BufWinEnter *.* silent! loadview 1
augroup END

set noscrollbind
set nocursorbind

if exists('+autochdir')
	" 文件路径设置为当前路径
	set autochdir
endif

set viminfo+=!

"""""""""""""""""""""""""""""""""""""""
"Gerneral }}}
"""""""""""""""""""""""""""""""""""""""


"""""""""""""""""""""""""""""""""""""""
" Plugin Management {{{
"""""""""""""""""""""""""""""""""""""""

" Keep Vim and Neovim on one plugin directory; vim-plug otherwise chooses
" different defaults for each editor.
call plug#begin('~/.vim/plugged')


" Syntax
Plug 'vim-scripts/asciidoc.vim'
Plug 'vim-scripts/confluencewiki.vim'
Plug 'othree/html5.vim'
Plug 'vim-scripts/moin.vim'
Plug 'vim-scripts/python.vim--Vasiliev'
Plug 'vim-scripts/xml.vim'
Plug 'vim-scripts/less'
Plug 'vim-scripts/wikipedia.vim'
Plug 'derekwyatt/vim-scala'
Plug 'gre/play2vim'
Plug 'tpope/vim-haml'
Plug 'kchmck/vim-coffee-script'
Plug 'vim-ruby/vim-ruby'
Plug 'vim-scripts/django.vim'
Plug 'chr4/nginx.vim'
Plug 'saltstack/salt-vim'
Plug 'vim-scripts/haproxy'
Plug 'mustache/vim-mustache-handlebars'
Plug 'chase/vim-ansible-yaml'
Plug 'leafgarland/typescript-vim'
Plug 'aklt/plantuml-syntax'
Plug 'vim-scripts/applescript.vim'
Plug 'skreuzer/vim-prometheus'
Plug 'cespare/vim-toml'
Plug 'nvim-tree/nvim-web-devicons'


" Prose / Markdown writing
Plug 'preservim/vim-colors-pencil'

" Keep Nightfox available for code-focused themes.
if has('nvim')
	Plug 'EdenEast/nightfox.nvim'
endif

" Indent
Plug 'vim-scripts/mako.vim--Torborg'
Plug 'gg/python.vim'
" replaces lepture/vim-jinja (that one breaks nvim plugin loading)
Plug 'Glench/Vim-Jinja2-Syntax'

" Plugins
Plug 'preservim/nerdtree'
" encode detect
" required for vim-mark
Plug 'inkarkat/vim-ingo-library'
" mark in different color, leader + m
Plug 'inkarkat/vim-mark'
" auto comment
Plug 'scrooloose/nerdcommenter'
Plug 'majutsushi/tagbar'
Plug 'mattn/emmet-vim'
" extened % for html ...
Plug 'vim-scripts/matchit.zip'
" % jump, </> pair, >> for complete
" ascii drawing, \di, \ds
Plug 'alswl/DrawIt'
" NR, NW
Plug 'chrisbra/NrrwRgn'
Plug 'terryma/vim-multiple-cursors'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug '907th/vim-auto-save'
Plug 'godlygeek/tabular'
Plug 'vim-pandoc/vim-pandoc-syntax'
Plug 'rhysd/vim-gfm-syntax'
Plug 'dhruvasagar/vim-table-mode'
" IME: using Rime in GUI + fcitx-remote in Terminal, so no fcitx vim plugin
Plug 'junegunn/vim-easy-align'
Plug 'hotoo/pangu.vim'
Plug 'vim-jp/autofmt'
" Snippet expansion relies on Python.
if has('python3') && executable('python3')
	Plug 'sirver/ultisnips'
endif
Plug 'honza/vim-snippets'
" for weirongxu/plantuml-previewer.vim
Plug 'tyru/open-browser.vim'
Plug 'weirongxu/plantuml-previewer.vim'

if has('nvim')
	" Browser Markdown preview: pure Lua backend with live updates and scroll sync.
	" Fork pending upstream review: upstream leaks a socket per HTTP request
	" until Neovim hits EMFILE. Back to brianhuster/main once merged.
	Plug 'alswl/live-preview.nvim', { 'branch': 'fix/socket-fd-leak' }
	Plug 'OXY2DEV/markview.nvim'
	Plug 'nvim-treesitter/nvim-treesitter'
	Plug 'sindrets/diffview.nvim'
	Plug 'ibhagwan/fzf-lua'
	Plug 'stevearc/conform.nvim'
	Plug 'HakonHarnes/img-clip.nvim'
	Plug 'stevearc/oil.nvim'
	" Debian Trixie ships a restricted Neovim version; use the compatible Aerial branch.
	Plug 'stevearc/aerial.nvim', { 'branch': 'nvim-0.9' }
	" Worktree picker and minimal Git status. Git operations stay on the CLI.
	Plug 'nvim-lua/plenary.nvim'
	Plug 'nvim-telescope/telescope.nvim'
	Plug 'polarmutex/git-worktree.nvim'
	Plug 'tpope/vim-fugitive'
endif

call plug#end()

"""""""""""""""""""""""""""""""""""""""
" Plugin Management }}}
"""""""""""""""""""""""""""""""""""""""


"""""""""""""""""""""""""""""""""""""""
"VIM user interface {{{
"""""""""""""""""""""""""""""""""""""""

" use chinese help
"set helplang=cn

"set the menu & the message to English
set langmenu=en_US
let $LANG="en_US.UTF-8"
" set spell spelllang=en_us,cjk
set nospell

set ruler "右下角显示当前光标

"set cmdheight=2 "The commandbar height

" Set backspace config
set backspace=eol,start,indent
"set whichwrap+=<,>,h,l

set ignorecase "Ignore case when searching
set smartcase
"set nowrapscan

" 使用正统的搜索正则
"nnoremap / /\v
"vnoremap / /\v

set hlsearch "Highlight search things

set incsearch "在输入部分查找模式时显示相应的匹配点。
"set nolazyredraw "Don't redraw while executing macros

set magic "Set magic on, for regular expressions

set showmatch "Show matching bracets when text indicator is over them

set sidescroll=10 "左右移动边距

"set list " 显示制表符/回车符
set listchars=tab:>-,trail:$ " 行尾符号

set showcmd "显示右下角命令
set cursorline

set noerrorbells
set novisualbell

"set iskeyword=@,48-57,192-255

if ! has("gui_running") && ! exists("g:gui_vimr")
	set mouse-=a
endif

set equalalways "分割窗口时保持相等的宽/高

set foldmethod=syntax
set foldcolumn=0
set foldlevel=0
set nofoldenable
set diffopt=vertical,iwhite

set laststatus=2
set statusline=\ \%F\ \ \ \ \ %m%r%h%w\ \ %y\ [%{&ff}]\ [%{&fileencoding}]\ [%p%%]\ [%l/%L]\ [%c]

set ttyfast

set shortmess-=S


if exists('+relativenumber')
	set relativenumber " 显示相对行号
endif
set number " 显示行号
set numberwidth=2 "行号栏的宽度
" set foldclose=all

"function! MarkPoint()
	"mark `
"endfunction

"autocmd CursorMoved * call MarkPoint()


"""""""""""""""""""""""""""""""""""""""
"VIM user interface }}}
"""""""""""""""""""""""""""""""""""""""

"""""""""""""""""""""""""""""""""""""""
"Colors and Fonts {{{
"""""""""""""""""""""""""""""""""""""""

syntax enable "Enable syntax hl


" Enable true color only when the terminal advertises 24-bit color. This is
" important inside tmux/screen, where TERM is intentionally not the outer
" terminal's value.
if has('termguicolors')
	" Do not send RGB escape sequences through multiplexers until their
	" actual RGB passthrough has been verified; 256 colors are reliable.
	if $TERM !~# '^\%(tmux\|screen\)' && ($COLORTERM ==# 'truecolor' || $COLORTERM ==# '24bit')
		set termguicolors
	else
		set notermguicolors
	endif
endif

"gfn=consolas:h10
"set gui options
" Gonvim please setting in ~/.config/goneovim/settings.toml
if (has("gui_running") && ! exists("g:gui_vimr"))
	" set linespace=10
	" set "uifont=Monospace\ 11
	" set guifont=DejaVu\ Sans\ Mono\ for\ Powerline:h16
	" set guifont=Anonymous\ Pro\ for\ Powerline:h20
	" set guifont=Droid\ Sans\ Mono\ for\ Powerline:h20
	" set macligatures
	" set guifont=Droid\ Sans\ Mono\ for\ Powerline:h13
	if s:System() == "mac"
		set guifont=Fira\ Code\ Light,PingFang\ SC\ Light:h14
		set guifontwide=Fira\ Code\ Light,PingFang\ SC\ Light:h14
		" set printfont=Fira\ Code:h12
	else
		if s:System() == "linux"
			set guifont=Fira\ Code\ 16
			" set printfont=Fira\ Code\ 12
		endif
	endif
	" set guifont=Source\ Code\ Pro\ for\ Powerline:h20
	" set guifont=Ubuntu\ Mono\ derivative\ Powerline:h20
	" set guifont=Ubuntu\ Mono\ derivative\ Powerline:h20
	"set guifont=Menlo:h18
	"let Powerline_symbols = 'fancy'
	" set printencoding=utf-8
	" set printmbcharset=ISO10646
	" set printmbfont=r:Fira\ SC\ Light,c:yes

endif

if !has('nvim')
	colorscheme desert
elseif &background ==# 'light'
	colorscheme pencil
else
	colorscheme nordfox
endif

"set ambiwidth=double " 设定某些标点符号为宽字符

" Hi todos
syn match myTodo contained "\<\(TODO\|FIXME\|XXX\):"
syn match myself contained "\<@\(alswl\|jingchao\|3d\|djc\|三谛\):"
hi def link myTodo Todo
hi def link myself Myself

"""""""""""""""""""""""""""""""""""""""
"Colors and Fonts }}}
"""""""""""""""""""""""""""""""""""""""

"""""""""""""""""""""""""""""""""""""""
"Files, backups and undo {{{
"""""""""""""""""""""""""""""""""""""""

" Turn backup off, since most stuff is in SVN, git anyway...
set nobackup
set nowritebackup
"set noswapfile
set backupext=.bak

"设置编码
set fileencodings=utf-8,gbk,ucs-bom,default,latin1
" set termencoding=utf-8
set encoding=utf-8

"Persistent undo
if exists('+undodir')
	if s:System() == "windows"
		set undodir=C:\Windows\Temp
	else
		if has('nvim-0.5')
			" New format in https://github.com/neovim/neovim/pull/13973 (f42e932,
			" 2021-04-13).
			let &undodir = $HOME . "/.vim_runtime" . '/undodir2'
		else
			let &undodir = $HOME . "/.vim_runtime" . '/undodir'
		endif
	endif
	set undofile
endif

"""""""""""""""""""""""""""""""""""""""
"Files, backups and undo }}}
"""""""""""""""""""""""""""""""""""""""


"""""""""""""""""""""""""""""""""""""""
"Text, tab and indent related {{{
"""""""""""""""""""""""""""""""""""""""

"set expandtab
set noexpandtab "是否使用Tab缩进 默认使用

set shiftwidth=4
set tabstop=4
set smarttab

set autoindent "Auto indent
set smartindent "Smart indet
set wrap "Wrap lines

"""""""""""""""""""""""""""""""""""""""
"Text, tab and indent related }}}
"""""""""""""""""""""""""""""""""""""""

"""""""""""""""""""""""""""""""""""""""
"FileType setting {{{
"""""""""""""""""""""""""""""""""""""""

augroup user_filetypes
	autocmd!
	autocmd BufRead,BufNewFile *.md set filetype=markdown
autocmd BufRead,BufNewFile */tmp/edit-server-prometheus**.txt set filetype=prometheus
autocmd BufRead,BufNewFile */tmp/edit-server-*.txt set filetype=markdown.gfm
autocmd BufRead,BufNewFile /private/tmp/zsh* set filetype=sh
autocmd BufRead,BufNewFile *.diff set paste
autocmd BufRead,BufNewFile *.pmd set filetype=markdown.pandoc
autocmd BufRead,BufNewFile *.scala set filetype=scala
autocmd BufRead,BufNewFile *.sc set filetype=scala
autocmd BufRead,BufNewFile *.sls set filetype=sls
autocmd BufRead,BufNewFile *.js set expandtab shiftwidth=2
autocmd BufRead,BufNewFile *.go set filetype=go
autocmd BufRead,BufNewFile *.wiki.dev.* set filetype=confluencewiki
autocmd BufRead,BufNewFile *.ts set filetype=typescript
autocmd BufRead,BufNewFile *.wxml set filetype=xml
autocmd BufRead,BufNewFile *.wxss set filetype=css
autocmd BufRead,BufNewFile *.gv set filetype=dot
autocmd BufRead,BufNewFile *.puml set filetype=plantuml
autocmd BufRead,BufNewFile *.cc set filetype=cpp
autocmd BufRead,BufNewFile *.zshrc set filetype=sh
autocmd BufRead,BufNewFile *.omnijs set filetype=javascript
" using python sytax for kcl
autocmd BufRead,BufNewFile *.k set filetype=python
autocmd BufRead,BufNewFile OWNERS set filetype=yaml
autocmd BufRead,BufNewFile Dockerfile.* set filetype=dockerfile
autocmd BufRead,BufNewFile Dockerfile-* set filetype=dockerfile

autocmd FileType python setlocal expandtab colorcolumn=80 textwidth=0 diffopt=vertical " fo+=Mm
"Map F9 to Run Python Script
autocmd FileType python nnoremap <buffer> <F9> :!python %<CR>
autocmd FileType asciidoc setlocal colorcolumn=120
autocmd FileType markdown,markdown.pandoc,markdown.github,markdown.gfm
						\ setlocal colorcolumn=120 expandtab shiftwidth=2
						\ tabstop=4 textwidth=0
						\ formatexpr=autofmt#uax14#formatexpr()
						\ noshowmatch
" mardown set shfitwidth for obsidian
autocmd BufRead,BufNewFile */*kms/**.md set shiftwidth=4 tabstop=4
autocmd BufRead,BufNewFile */*kms/*/**.md set shiftwidth=4 tabstop=4
autocmd BufRead,BufNewFile */*kms/*/*/**.md set shiftwidth=4 tabstop=4
" comments configuration from https://github.com/plasticboy/vim-markdown/issues/390#issuecomment-450392655
autocmd FileType mako setlocal colorcolumn=120 cc=0 fdm=indent
autocmd FileType html setlocal expandtab shiftwidth=2 tabstop=2
autocmd FileType javascript setlocal expandtab shiftwidth=2 tabstop=2
autocmd FileType haskell setlocal expandtab
autocmd FileType lua setlocal expandtab
autocmd FileType nginx setlocal expandtab
autocmd FileType java setlocal expandtab colorcolumn=120
autocmd FileType ruby setlocal expandtab shiftwidth=2 colorcolumn=120
autocmd FileType eruby setlocal expandtab shiftwidth=2
autocmd FileType rst setlocal colorcolumn=120
autocmd FileType htmldjango setlocal expandtab shiftwidth=2 foldmethod=indent
autocmd FileType yaml setlocal expandtab shiftwidth=2 foldmethod=indent
autocmd FileType plantuml setlocal expandtab
" notice, here is more `\` for `\|` for autocmd
autocmd FileType plantuml vnoremap = :EasyAlign */\(starts\)\\|\(ends\)\\|\(lasts\)\\|\(happens\)/<CR>
autocmd FileType plantuml let g:plantuml_previewer#plantuml_jar_path = get(
    \  matchlist(system('cat `which plantuml` | grep plantuml.jar'), '\v.*\s[''"]?(\S+plantuml\.jar).*'),
    \  1,
    \  0
    \)
autocmd FileType sh setlocal expandtab shiftwidth=2
autocmd FileType dockerfile setlocal expandtab shiftwidth=2
augroup END

"""""""""""""""""""""""""""""""""""""""
"FileType setting }}}
"""""""""""""""""""""""""""""""""""""""


"""""""""""""""""""""""""""""""""""""""
"Moving around, tabs and buffers {{{
"""""""""""""""""""""""""""""""""""""""

" Smart way to move btw. windows
" note: <C-h>/<C-l> are used for tab switching below (gT/gt)
map <C-j> <C-W>j
map <C-k> <C-W>k

" Use the arrows to something usefull
map <right> :bn<cr>
map <left> :bp<cr>


"""""""""""""""""""""""""""""""""""""""
"Moving around, tabs and buffers }}}
"""""""""""""""""""""""""""""""""""""""

"""""""""""""""""""""""""""""""""""""""
" Text Formatting/Layout {{{
"""""""""""""""""""""""""""""""""""""""

set formatoptions+=mB
"set formatoptions=croqn2mB1
"try
  "" Vim 7.4
  "set formatoptions+=j
"catch /.*/
"endtry
set linebreak "智能换行
"set tw=500 "自动换行 超过n列
" text hidden
set conceallevel=0

"""""""""""""""""""""""""""""""""""""""
" Text Formatting/Layout }}}
"""""""""""""""""""""""""""""""""""""""

"""""""""""""""""""""""""""""""""""""""
" Map {{{
"""""""""""""""""""""""""""""""""""""""

map <F1> :NERDTreeToggle<cr>
imap <F1> <Esc>:NERDTreeToggle<cr>
"map <F2> :Tlist<cr>
map <F2> :TagbarToggle<cr>
imap <F2> <Esc>:TagbarToggle<cr>
"代码折叠快捷方式
map <F3> zR
imap <F3><Esc> zR
map <F4> zM
imap <F4> <Esc>zM

" 标签设置
map <F7> gT
imap <F7> <Esc>gT
map <F8> gt
imap <F8> <Esc>gt
map <C-h> gT
map <C-l> gt
noremap <C-Tab> :tabnext<CR>
noremap <C-S-Tab> :tabprev<CR>
inoremap <C-Tab> <Esc>:tabnext<CR>
inoremap <C-S-Tab> <Esc>:tabprev<CR>
map <S-k> <Nop>

if has("gui_running") && ! exists("g:gui_vimr")
	imap <D-1> <Esc>1gt
	nmap <D-1> 1gt
	imap <D-2> <Esc>2gt
	nmap <D-2> 2gt
	imap <D-3> <Esc>3gt
	nmap <D-3> 3gt
	imap <D-4> <Esc>4gt
	nmap <D-4> 4gt
	imap <D-5> <Esc>5gt
	nmap <D-5> 5gt
	imap <D-6> <Esc>6gt
	nmap <D-6> 6gt
	imap <D-7> <Esc>7gt
	nmap <D-7> 7gt
	imap <D-8> <Esc>8gt
	nmap <D-8> 8gt
	imap <D-9> <Esc>9gt
	nmap <D-9> 9gt

	nmap <D-t> :tabe<cr>

	" set CMD+V to paste in all modes
	nnoremap <D-v> "+p
	inoremap <D-v> <Esc>"+p
	cnoremap <D-v> <C-R>+

	vnoremap <D-c> "+y<cr>

	nnoremap <D-a> gg0vG$
	inoremap <D-a> <Esc>gg0vG$
	cnoremap <D-a> gg0vG$

	imap <silent> <S-Insert> <MiddleMouse>
	cmap <silent> <S-Insert> <MiddleMouse>
endif

" 用空格键来开关折叠
nnoremap <space> @=((foldclosed(line('.')) < 0) ? 'zc' : 'zo')<CR>

map Q :q<CR>

vnoremap <leader> v :NRV<CR>

" 用 * / # 匹配选中
vnoremap  *  y/<C-R>=escape(@", '\\/.*$^~[]')<CR><CR>
vnoremap  #  y?<C-R>=escape(@", '\\/.*$^~[]')<CR><CR>

" html缩进
let g:html_indent_inctags = "p,li,dt,dd"

nnoremap <S-Tab> <<
inoremap <S-Tab> <C-D>

" 模拟 Emacs 键绑定
" Move
inoremap <C-a> <Home>
inoremap <C-e> <End>
" inoremap <C-p> <Up>
" inoremap <C-n> <Down>
inoremap <C-b> <Left>
inoremap <C-f> <Right>
cmap <C-a> <Home>
cmap <C-e> <End>
cmap <C-p> <Up>
cmap <C-n> <Down>
cmap <C-b> <Left>
cmap <C-f> <Right>

inoremap <M-b> <C-o>b
inoremap <M-f> <C-o>w
" Rubout word / line and enter insert mode
" use <Esc><Right> instead of <C-o>
inoremap <C-w> <Esc>dbcl
" delete
inoremap <C-u> <Esc>d0cl
inoremap <C-k> <Esc><Right>C
inoremap <C-d> <Del>
inoremap <M-d> <C-o>de

map <leader>f :NERDTreeToggle<CR>

" diff
map <leader>d /^[=<>]\{7\}<CR>

" Favor a light, low-distraction palette for prose and a dark palette for code.
nnoremap <silent> <leader>ct :ToggleTheme<CR>

if !has('nvim')
	" Neovim uses Conform; Vim falls back to its built-in formatter.
	nnoremap <silent> <leader>F :normal! gggqG<CR>
endif

noremap <silent> <leader>b :CtrlPMRUFiles<CR>

imap <C-\> <Esc>:split<CR>:set nocursorbind noscrollbind<CR>:diffoff<CR>
nmap <C-\> :split<CR>:set nocursorbind noscrollbind<CR>:diffoff<CR>

nmap <silent> <leader>t :tabe %<CR>
nmap <silent> <leader>\ :split<CR>:set nocursorbind noscrollbind<CR>:diffoff<CR><C-]>

inoremap <silent> <leader>p "*p<CR>
noremap <silent> <leader>p "*p<CR>

inoremap <silent> <leader>q :q<CR>
noremap <silent> <leader>q :q<CR>

inoremap <silent> <leader>w :w<CR>
noremap <silent> <leader>w :w<CR>


" delete without yanking
" nnoremap <leader>d "_d
" vnoremap <leader>d "_d

" pip install pandoc-plantuml
if s:System() == "mac"
	" markdown preview
	noremap <leader>N :!open -a MacDown %<CR>
	" noremap <leader>N :!open -a Typora %<CR>
	" noremap <leader>M :silent exec "!open -a Macdown %"<CR>
	" preview
	" noremap <leader>M :GonvimMarkdown<CR>
	noremap <leader>M :silent exec "!pandoc % -f markdown+smart -s --toc --toc-depth=4 -c ~/local/etc/Blank.css --mathjax='https://lf3-cdn-tos.bytecdntp.com/cdn/expire-1-M/mathjax/2.7.5/MathJax.js?config=TeX-AMS-MML_HTMLorMML' -t html -o %.generated.html && open %.generated.html"<CR>
	" Error running filter pandoc-plantuml:, rm
	" --filter=pandoc-plantuml 

	" markdown image processing
	noremap <leader>u :silent exec "!plantuml -tpng % && open %:r.png"<CR>
	noremap <leader>U :silent exec "!plantuml -tsvg % && open . && open  %:r.svg"<CR>
	noremap <leader>p :!$HOME/local/bin/image-from-clipboard-to-png-copy-markdown %
	"noremap <leader>p :!$HOME/local/bin/image-from-clipboard-to-png-global %
	noremap <leader>P :!$HOME/local/bin/image-from-path-to-assets-copy-markdown %
else
	if s:System() == "linux"
		" markdown preview
		noremap <leader>M :silent exec "!pandoc % -f markdown+smart -s --toc --toc-depth=4 -c ~/local/etc/Blank.css --mathjax='https://lf3-cdn-tos.bytecdntp.com/cdn/expire-1-M/mathjax/2.7.5/MathJax.js?config=TeX-AMS-MML_HTMLorMML' --filter=pandoc-plantuml -t html -o %.generated.html && xdg-open %.generated.html"<CR>
	endif
endif

" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)
" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)

if has('macunix')
	nnoremap gx :call <SID>OpenURLUnderCursor()<CR>
endif

"""""""""""""""""""""""""""""""""""""""
" Map }}}
"""""""""""""""""""""""""""""""""""""""


"""""""""""""""""""""""""""""""""""""""
" Plugin {{{
"""""""""""""""""""""""""""""""""""""""

set tags=tags;

let g:NERDTreeIgnore = ['\.pyc$', '\.class$', '\.jpeg$', '\.jpg$', '\.png$', '\.git$', '^target$', '\.slide\.html$', '\.generated\.html$', '\.md\.assets$']
let g:NERDTreeChDirMode = 2
let g:NERDTreeShowBookmarks=1

" ctrlp
nnoremap <C-p> :call <SID>RunCtrlP()<CR>
let g:ctrlp_map = ''
let g:ctrlp_working_path_mode = 'ra'
let g:ctrlp_root_markers = ['.ctrlp', 'README.md', 'build.sbt', '.git']
let g:ctrlp_custom_ignore = {
        \ 'dir':  '\v[\/](\.(git|hg|svn)$)|target|node_modules',
        \ 'file': '\v\.(exe|so|dll|class|jar|png|jpeg|jpg|numbers|slide.html|generated.html|graphml|svg)$',
        \ 'link': 'SOME_BAD_SYMBOLIC_LINKS',
        \ }

let g:auto_save = 1  " enable AutoSave on Vim startup
let g:auto_save_silent = 1  " do not display the auto-save notification

let g:auto_save_presave_hook = 'call AbortIfNotFileType()'

" Add support for markdown files in tagbar.
"let g:tagbar_type_markdown = {
    "\ 'ctagstype': 'markdown',
    "\ 'ctagsbin' : '/path/to/markdown2ctags.py',
    "\ 'ctagsargs' : '-f - --sort=yes',
    "\ 'kinds' : [
        "\ 's:sections',
        "\ 'i:images'
    "\ ],
    "\ 'sro' : '|',
    "\ 'kind2scope' : {
        "\ 's' : 'section',
    "\ },
    "\ 'sort': 0,
"\ }

" https://github.com/majutsushi/tagbar/wiki
"let g:tagbar_type_markdown = {
    "\ 'ctagstype' : 'markdown',
    "\ 'kinds' : [
        "\ 'h:Heading_L1',
        "\ 'i:Heading_L2',
        "\ 'k:Heading_L3'
    "\ ],
    "\ 'sort': 0
"\ }
let g:tagbar_type_markdown = {
    \ 'ctagstype': 'markdown',
    \ 'ctagsbin' : '~/local/bin/markdown2ctags.py',
    \ 'ctagsargs' : '-f - --sort=yes',
    \ 'kinds' : [
        \ 's:sections',
        \ 'i:images'
    \ ],
    \ 'sro' : '|',
    \ 'kind2scope' : {
        \ 's' : 'section',
    \ },
    \ 'sort': 0,
\ }
let g:tagbar_type_ansible = {
	\ 'ctagstype' : 'ansible',
	\ 'kinds' : [
		\ 't:tasks'
	\ ],
	\ 'sort' : 0
\ }
let g:tagbar_type_css = {
\ 'ctagstype' : 'Css',
    \ 'kinds'     : [
        \ 'c:classes',
        \ 's:selectors',
        \ 'i:identities'
    \ ]
\ }
let g:tagbar_type_go = {
    \ 'ctagstype': 'go',
    \ 'kinds' : [
        \'p:package',
        \'f:function',
        \'v:variables',
        \'t:type',
        \'c:const'
    \]
\}
let g:tagbar_type_groovy = {
    \ 'ctagstype' : 'groovy',
    \ 'kinds'     : [
        \ 'p:package:1',
        \ 'c:classes',
        \ 'i:interfaces',
        \ 't:traits',
        \ 'e:enums',
        \ 'm:methods',
        \ 'f:fields:1'
    \ ]
\ }
let g:tagbar_type_scala = {
    \ 'ctagstype' : 'scala',
    \ 'sro'       : '.',
    \ 'kinds'     : [
      \ 'p:packages',
      \ 'T:types:1',
      \ 't:traits',
      \ 'o:objects',
      \ 'O:case objects',
      \ 'c:classes',
      \ 'C:case classes',
      \ 'm:methods',
      \ 'V:values:1',
      \ 'v:variables:1'
    \ ]
\ }

" markdown.pandoc
let g:pandoc#syntax#conceal#use = 0
" let g:pandoc#syntax#conceal#urls = 1
" let g:pandoc#syntax#conceal#blacklist = ["atx","codeblock_start","codeblock_delim"]
augroup user_syntax
	autocmd!
	autocmd Syntax * hi link pandocAtxStart Type
	autocmd Syntax * hi link pandocAtxHeader Type
augroup END

" vim-mark
"nmap <silent> <leader>hl <Plug>MarkSet
"vmap <silent> <leader>hl <Plug>MarkSet
"nmap <silent> <leader>hh <Plug>MarkClear
"vmap <silent> <leader>hh <Plug>MarkClear
"nmap <silent> <leader>hr <Plug>MarkRegex
"vmap <silent> <leader>hr <Plug>MarkRegex
let g:mwAutoLoadMarks = 1
runtime plugin/mark.vim
silent! unmap <k1>
silent! unmap <k2>
silent! unmap <k3>
silent! unmap <k4>
silent! unmap <k5>
silent! unmap <k6>
silent! unmap <k7>
silent! unmap <k8>
silent! unmap <k9>
silent! unmap <C-k1>
silent! unmap <C-k2>
silent! unmap <C-k3>
silent! unmap <C-k4>
silent! unmap <C-k5>
silent! unmap <C-k6>
silent! unmap <C-k7>
silent! unmap <C-k8>
silent! unmap <C-k9>

" autofmt
"set runtimepath+=~/.vim/plugged/autofmt/
let g:autofmt_allow_over_tw = 0
"let s:unicode = autofmt#unicode#import()
"let s:orig_prop_line_break = s:unicode.prop_line_break
"function! s:unicode.prop_line_break(char)
	"if a:char == "\u201c" || a:char == "\u2018"
		"return "OP"   " Open quotations
	"elseif a:char == "\u201d" || a:char == "\u2019"
		"return "CL"   " Close quotations
	"endif
	"return call(s:orig_prop_line_break, [a:char], self)
"endfunction

" plasticboy/vim-markdown
" let g:vim_markdown_folding_disabled = 1
" let g:vim_markdown_new_list_item_indent = 4
" let g:vim_markdown_math = 1
" let g:vim_markdown_conceal = 0
" let g:vim_markdown_conceal = 0
" let g:vim_markdown_conceal_code_blocks = 0
" let g:vim_markdown_new_list_item_indent = 2

" matchparen
let g:matchparen_timeout = 2
let g:matchparen_insert_timeout = 2

" Trigger configuration. Do not use <tab> if you use https://github.com/Valloric/YouCompleteMe.
let g:UltiSnipsExpandTrigger = "<tab>"
let g:UltiSnipsJumpForwardTrigger="<C-F11>"
let g:UltiSnipsJumpBackwardTrigger="<C-F12>"
let g:UltiSnipsSnippetsDir = $HOME."/.config/UltiSnips"
let g:UltiSnipsSnippetDirectories = ['UltiSnips', $HOME.'/.config/UltiSnips']
let g:UltiSnipsEnableSnipMate = 0

" If you want :UltiSnipsEdit to split your window.
let g:UltiSnipsEditSplit="vertical"

" markdown latex
" let g:tex_flavor='latex'
" let g:vimtex_view_method='zathura'
" let g:vimtex_quickfix_mode=0
" let g:tex_conceal='abdmg'

" Use Python from PATH so the provider works on macOS and Linux.
let s:python3_host = exepath('python3')
if !empty(s:python3_host)
	let g:python3_host_prog = s:python3_host
endif
" disable neovim ruby
let g:loaded_ruby_provider = 0
" let g:ruby_host_prog='~/.rvm/gems/ruby-2.4.0/bin/neovim-ruby-host'

" nerdcommenter
let g:NERDSpaceDelims = 1
let g:NERDCustomDelimiters = { 'conf': { 'left': '#','right': '' } }


"""""""""""""""""""""""""""""""""""""""
" Plugin }}}
"""""""""""""""""""""""""""""""""""""""


"""""""""""""""""""""""""""""""""""""""
" Helpers and commands {{{
"""""""""""""""""""""""""""""""""""""""

function! s:RefreshThemeIntegrations()
	if has('nvim')
		lua local ok, highlights = pcall(require, 'markview.highlights'); if ok then for name in pairs(vim.api.nvim_get_hl(0, {})) do if name:match('^Markview') then vim.api.nvim_set_hl(0, name, {}) end end; highlights.setup() end
	endif
	redraw!
endfunction

function! s:ToggleTheme()
	if !has('nvim')
		colorscheme desert
	elseif &background ==# 'dark'
		set background=light
		colorscheme pencil
	else
		set background=dark
		colorscheme nordfox
	endif
	call s:RefreshThemeIntegrations()
endfunction

command! ToggleTheme call <SID>ToggleTheme()

function! s:OpenURLUnderCursor()
	let l:uri = shellescape(matchstr(getline('.'), '[a-z]*:\/\/[^ >,;()]*'), 1)
	if l:uri != ''
		execute 'silent !open ' . l:uri
		redraw!
	endif
endfunction

function! s:RunCtrlP()
	lcd %:p:h
	if getcwd() ==# $HOME
		echo "Can't run in \$HOME"
		return
	endif
	CtrlP
endfunction

function! AbortIfNotFileType()
	let g:auto_save_abort = index(['markdown', 'markdown.gfm', 'markdown.pandoc', 'plantuml', 'yaml'], &filetype) < 0
endfunction

" trim right of line
command! -nargs=0 TrimR :%s/\s\+$//g

" remove blank lines, 2 blank lines to 1 blank line
command! -nargs=0 RemoveBlankLines :g/^\n$/d

" diff Original file
if !exists(":DiffOrig")
    command DiffOrig vert new | set bt=nofile | r # | 0d_ | diffthis
          \ | wincmd p | diffthis
endif

"""""""""""""""""""""""""""""""""""""""
" Helpers and commands }}}
"""""""""""""""""""""""""""""""""""""""
