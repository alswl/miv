"source $VIMRUNTIME/vimrc_example.vim

"""""""""""""""""""""""""""""""""""""""
"平台判断
"""""""""""""""""""""""""""""""""""""""
function! MySys()
	if has("win32")
		return "windows"
	else
		if has("mac")
			return "mac"
		else
			return "linux"
	endif
endfunction

"""""""""""""""""""""""""""""""""""""""
"模仿MS快捷键
"""""""""""""""""""""""""""""""""""""""
"source $VIMRUNTIME/mswin.vim

" CTRL-X and SHIFT-Del are Cut
"vnoremap <C-X> "+x

" CTRL-C and CTRL-Insert are Copy
"vnoremap <C-C> "+y

" CTRL-V and SHIFT-Insert are Paste
if MySys() == "linux"
	vmap <C-c> "+yi
	vmap <C-x> "+c
	vmap <C-v> c<ESC>"+p
	imap <C-v> <ESC>"+pa
endif

"""""""""""""""""""""""""""""""""""""""
"Gerneral
"""""""""""""""""""""""""""""""""""""""
" Enable filetype plugin
filetype plugin on
filetype indent on

" Set to auto read when a file is changed from the outside
set autoread

" 编辑vimrc之后，重新加载
autocmd! bufwritepost .vimrc source ~/.vimrc

" 禁用Vi的兼容模式
set nocompatible

if has("gui_running")
	"winpos 0 0
	set guioptions -=m
	set guioptions -=T
	set guioptions -=L
	set guioptions -=r
	" auto select
	" set guioptions +=a
	" set macmeta
	"set transparency=10
	"set showtabline=0
	"set lines=45
	"set columns=85

	" insert mode to IME
	"set noimdisable
	"set iminsert=2

	"autocmd! InsertEnter * set noimdisable|set iminsert=0
	"autocmd! InsertLeave * set imdisable|set iminsert=0
	"autocmd! FocusGained * set imdisable|set iminsert=0
endif


" 设定状态栏多显示信息
set laststatus=2

set noscrollbind
set nocursorbind

if exists('+autochdir')
	" 文件路径设置为当前路径
	set autochdir
endif

autocmd BufEnter * silent! lcd %:p:h

"auto save zz info
if ! has("gui_running")
	autocmd! BufWinLeave *.* silent mkview
	autocmd! BufWinEnter *.* silent loadview
endif

"""""""""""""""""""""""""""""""""""""""
"Vundle
"""""""""""""""""""""""""""""""""""""""
set runtimepath+=~/.vim/bundle/Vundle.vim/
call vundle#begin()

" My Bundles here:

" vim-scripts repos

Plugin 'VundleVim/Vundle.vim'


" Syntax
Plugin 'asciidoc.vim'
Plugin 'confluencewiki.vim'
Plugin 'othree/html5.vim'
Plugin 'JavaScript-syntax'
"Plugin 'mako.vim'
Plugin 'moin.vim'
Plugin 'python.vim--Vasiliev'
Plugin 'xml.vim'
Plugin 'less'
" Plugin 'hallison/vim-markdown'
" Plugin 'tpope/vim-markdown'
Plugin 'wikipedia.vim'
Plugin 'derekwyatt/vim-scala'
" play1
" Plugin 'alswl/play2vim'
" play2
Plugin 'gre/play2vim'
Plugin 'tpope/vim-haml'
Plugin 'kchmck/vim-coffee-script'
Plugin 'vim-ruby/vim-ruby'
Plugin 'django.vim'
" Plugin 'nginx.vim'
Plugin 'saltstack/salt-vim'
Plugin 'fatih/vim-go'
Plugin 'haproxy'
Plugin 'mustache/vim-mustache-handlebars'
Plugin 'chase/vim-ansible-yaml'
Plugin 'leafgarland/typescript-vim'
Plugin 'aklt/plantuml-syntax'
" Plugin 'spacewander/openresty-vim'
Plugin 'hexchain/vim-openresty'


" Color

Plugin 'desert256.vim'
Plugin 'vividchalk.vim'
Plugin 'ego.vim'
Plugin 'tomasr/molokai'
Plugin 'altercation/vim-colors-solarized'

" Ftplugin
"Plugin 'python_fold'

" Indent
"Plugin 'indent/html.vim'
Plugin 'IndentAnything'
" Plugin 'Javascript-Indentation'
Plugin 'pangloss/vim-javascript'
Plugin 'mako.vim--Torborg'
Plugin 'gg/python.vim'
Plugin 'lepture/vim-jinja'

" Plugin
Plugin 'scrooloose/nerdtree'
Plugin 'AutoClose--Alves'
Plugin 'auto_mkdir'
" required by XXX
Plugin 'cecutil'
" encode detect
Plugin 'FencView.vim'
" Plugin 'FuzzyFinder'
Plugin 'jsbeautify'
" required by XXX
Plugin 'L9'
" mark in different color, leader + m
Plugin 'Mark'
" joke
Plugin 'matrix.vim'
" most recent used
Plugin 'mru.vim'
" auto comment
Plugin 'The-NERD-Commenter'
Plugin 'restart.vim'
"Tlist
"Plugin 'taglist.vim'
"Plugin 'templates.vim'
Plugin 'majutsushi/tagbar'
"Plugin 'vimim.vim'
Plugin 'mattn/emmet-vim'
"Plugin 'css_color.vim'
"Plugin 'hallettj/jslint.vim'
" code source
"Plugin 'vcscommand.vim'
" quick snip input
Plugin 'snipMate'
" task list search
"Plugin 'TaskList.vim'
Plugin 'pep8'
"Plugin 'git://github.com/kevinw/pyflakes-vim.git'
"Rope, a python refactoring library
"Plugin 'sontek/rope-vim'
"Plugin 'project.tar.gz'
"Plugin 'minibufexplorerpp'
Plugin 'bufexplorer.zip'
"Plugin 'Align.vim'
"Plugin 'SQLUtilities'
" extened % for html ...
Plugin 'matchit.zip'
" % jump, </> pair, >> for complete
Plugin 'xmledit'
" ascii drawing, \di, \ds
Plugin 'DrawIt'
" NR, NW
Plugin 'chrisbra/NrrwRgn'
" status bar
" Plugin 'Lokaltog/vim-powerline'
" Plugin 'scala/scala-dist'
Plugin 'terryma/vim-multiple-cursors'
" original repos on github
"Plugin 'tpope/vim-fugitive'
"Plugin 'Lokaltog/vim-easymotion'
"Plugin 'rstacruz/sparkup', {'rtp': 'vim/'}
"Plugin 'tpope/vim-rails.git'
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'Rename'
Plugin '907th/vim-auto-save'
" Plugin 'nelstrom/vim-markdown-folding'
Plugin 'godlygeek/tabular'
Plugin 'plasticboy/vim-markdown'
Plugin 'dhruvasagar/vim-table-mode'
" Plugin 'lilydjwg/fcitx.vim'
Plugin 'CodeFalling/fcitx-vim-osx'
Plugin 'junegunn/vim-easy-align'




" for vim-pyref

" non github repos
"Plugin 'git://git.wincent.com/command-t.git'
call vundle#end()


"""""""""""""""""""""""""""""""""""""""
"VIM user interface
"""""""""""""""""""""""""""""""""""""""
" use chinese help
"set helplang=cn

"set the menu & the message to English
set langmenu=en_US
let $LANG="en_US.UTF-8"

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

if ! has("gui_running")
	set mouse-=a
endif

set equalalways "分割窗口时保持相等的宽/高

set guitablabel=%N.%t " 设定标签上显示序号

set foldmethod=syntax
set foldcolumn=0
set foldlevel=0
set nofoldenable
set diffopt=vertical,iwhite

set laststatus=2
" set statusline=\ \%F\ %m%r%h%w\ \ %y\ [%{&ff}]\ [%{&fileencoding}]\ [tw:%{&tw}]\ [%p%%]\ [%l/%L]\ [%c]
set statusline=\ \%F\ \ \ \ \ %m%r%h%w\ \ %y\ [%{&ff}]\ [%{&fileencoding}]\ [%p%%]\ [%l/%L]\ [%c]

set ttyfast

"""""""""""""""""""""""""""""""""""""""
"Colors and Fonts
"""""""""""""""""""""""""""""""""""""""
syntax enable "Enable syntax hl

"gfn=consolas:h10
"set gui options
if has("gui_running")
	" set linespace=10
	" set "uifont=Monospace\ 11
	" set guifont=DejaVu\ Sans\ Mono\ for\ Powerline:h16
	" set guifont=Anonymous\ Pro\ for\ Powerline:h20
	" set guifont=Droid\ Sans\ Mono\ for\ Powerline:h20
	" set macligatures
	" set guifont=Droid\ Sans\ Mono\ for\ Powerline:h13
	if MySys() == "mac"
		set guifont=Fira\ Code:h16
		set printfont=Fira\ Code:h12
	else
		if MySys() == "linux"
			set guifont=Fira\ Code\ 16
			set printfont=Fira\ Code\ 12
		endif
	endif
	" set guifont=Source\ Code\ Pro\ for\ Powerline:h20
	" set guifont=Ubuntu\ Mono\ derivative\ Powerline:h20
	" set guifont=Ubuntu\ Mono\ derivative\ Powerline:h20
	"set guifont=Menlo:h18
	"let Powerline_symbols = 'fancy'
	set printencoding=utf-8
	set printmbcharset=ISO10646
	set printmbfont=r:PingFang\ SC\ Light,c:yes

	" Set syntax color
	colorscheme molokai
else
	colorscheme desert256
endif

"set ambiwidth=double " 设定某些标点符号为宽字符

" 设定行首tab为灰色
highlight LeaderTab guifg=#666666

"""""""""""""""""""""""""""""""""""""""
"Files, backups and undo
"""""""""""""""""""""""""""""""""""""""
" Turn backup off, since most stuff is in SVN, git anyway...
set nobackup
set nowritebackup
"set noswapfile
set backupext=.bak

"设置编码
set fileencodings=utf-8,gbk,ucs-bom,default,latin1
set termencoding=utf-8
set encoding=utf-8

"Persistent undo
if exists('+undodir')
	if MySys() == "windows"
		set undodir=C:\Windows\Temp
	else
		set undodir=~/.vim_runtime/undodir
	endif
	set undofile
endif

"""""""""""""""""""""""""""""""""""""""
"Text, tab and indent related
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
"FileType setting
"""""""""""""""""""""""""""""""""""""""

au BufRead,BufNewFile *.md set filetype=markdown
au BufRead,BufNewFile *.scala set filetype=scala
au BufRead,BufNewFile *.sls set filetype=sls
au BufRead,BufNewFile *.js set expandtab shiftwidth=2
au BufRead,BufNewFile *.go set filetype=go
au BufRead,BufNewFile *.wiki.dev.* set filetype=confluencewiki
au BufRead,BufNewFile *.ts set filetype=typescript
au BufRead,BufNewFile *.wxml set filetype=xml
au BufRead,BufNewFile *.wxss set filetype=css

au FileType python setlocal expandtab colorcolumn=80 textwidth=0 " fo+=Mm
"Map F9 to Run Python Script
au FileType python map <F9> :!python %
au FileType asciidoc setlocal colorcolumn=100
au FileType markdown setlocal colorcolumn=100 expandtab shiftwidth=4 nowrap textwidth=100
au FileType mako setlocal colorcolumn=100 cc=0 fdm=indent
"au FileType html setlocal shiftwidth=2 tabstop=2
au FileType haskell setlocal expandtab
au FileType lua setlocal expandtab
au FileType nginx setlocal expandtab
au FileType java setlocal expandtab colorcolumn=100
au FileType ruby setlocal expandtab shiftwidth=2 colorcolumn=100
au FileType eruby setlocal expandtab shiftwidth=2
au FileType rst setlocal colorcolumn=100
au FileType htmldjango setlocal expandtab shiftwidth=2 foldmethod=indent
au FileType yaml setlocal expandtab shiftwidth=2 foldmethod=indent

"""""""""""""""""""""""""""""""""""""""
"Visual mode related
"""""""""""""""""""""""""""""""""""""""

"""""""""""""""""""""""""""""""""""""""
"Command mode related
"""""""""""""""""""""""""""""""""""""""

"""""""""""""""""""""""""""""""""""""""
"Moving around, tabs and buffers
"""""""""""""""""""""""""""""""""""""""
" Smart way to move btw. windows
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l

" Use the arrows to something usefull
map <right> :bn<cr>
map <left> :bp<cr>

"""""""""""""""""""""""""""""""""""""""
"Visual Cues
"""""""""""""""""""""""""""""""""""""""
if !exists(':relativenumber')
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
" Text Formatting/Layout
"""""""""""""""""""""""""""""""""""""""

set formatoptions+=mB
set linebreak "智能换行
"set tw=500 "自动换行 超过n列

"""""""""""""""""""""""""""""""""""""""
" Plugin
"""""""""""""""""""""""""""""""""""""""
set tags=tags;

"pydiction 1.2 python auto complete
"let g:pydiction_location = 'D:/Program Files/Vim/vimfiles/ftplugin/pydiction'
"defalut g:pydiction_menu_height == 15
"let g:pydiction_menu_height = 20

"SuperTab
"let g:SuperTabRetainCompletionType = 2
"let g:SuperTabDefaultCompletionType = "<C-X><C-O>" 

"Neo
"let g:neocomplcache_enable_at_startup=1

" Restart
let g:restart_sessionoptions = "restart_session"

" Mark
"nmap <silent> <leader>hl <Plug>MarkSet
"vmap <silent> <leader>hl <Plug>MarkSet
"nmap <silent> <leader>hh <Plug>MarkClear
"vmap <silent> <leader>hh <Plug>MarkClear
"nmap <silent> <leader>hr <Plug>MarkRegex
"vmap <silent> <leader>hr <Plug>MarkRegex

" fuzzyfinder
"map <silent> <leader>sf :FufFile<CR>
"map <silent> <leader>sb :FufBuffer<CR>

" jslint.vim
" let g:JSLintHighlightErrorLine = 0 " disabled

" Fencview
let g:fencview_autodetect = 0

" JSLint
let g:JSLintHighlightErrorLine = 0

" Project
"map <silent> <leader>p :Project<CR>

" NERDTree
let g:NERDTreeIgnore = ['\.pyc$', '\.class$', '\.git$', '^target$', '\.generated\.html$', '\.md\.assets$']
let g:NERDTreeChDirMode = 2
let g:NERDTreeShowBookmarks=1

" ctrlp
nnoremap <C-p> :call RunCtrlP()<CR>
let g:ctrlp_map = ''
fun! RunCtrlP()
  lcd %:p:h
  if (getcwd() == $HOME)
    echo "Can't run in \$HOME"
    return
  endif
  CtrlP
endfunc
"let g:ctrlp_working_path_mode = 'c'
"let g:ctrlp_working_path_mode = 'ca'
let g:ctrlp_working_path_mode = 'ra'
let g:ctrlp_root_markers = ['.ctrlp', 'pom.xml', 'README.md']
let g:ctrlp_custom_ignore = {
	\ 'dir':  '\v[\/](\.(git|hg|svn)$)|target|node_modules',
	\ 'file': '\v\.(exe|so|dll|class|jar|png|jpeg|jpg|numbers|generated.html|graphml)$',
	\ 'link': 'SOME_BAD_SYMBOLIC_LINKS',
	\ }

" powerline
if has("gui_running")
	"python from powerline.vim import setup as powerline_setup
	"python powerline_setup()
	"python del powerline_setup
endif

" autosaving

let g:auto_save = 1  " enable AutoSave on Vim startup
let g:auto_save_silent = 1  " do not display the auto-save notification

let g:auto_save_presave_hook = 'call AbortIfNotFileType()'

function! AbortIfNotFileType()
  if &filetype != 'markdown'
    let g:auto_save_abort = 1
  endif
endfunction

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


"""""""""""""""""""""""""""""""""""""""
" Map
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
imap <F7> <Esc>gT
imap <F8> <Esc>gt
noremap <C-Tab> :tabnext<CR>
noremap <C-S-Tab> :tabprev<CR>
inoremap <C-Tab> <Esc>:tabnext<CR>
inoremap <C-S-Tab> <Esc>:tabprev<CR>

if has("gui_running")
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
endif

if has("gui_running")
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

"let g:pep8_map='<leader>8' " PEP8 Check
map <leader>f :NERDTreeToggle<CR>

" diff
map <leader>d /^[=<>]\{7\}<CR>

" noremap <silent> <leader>b :BufExplorer<CR>
noremap <silent> <leader>s :BufExplorerVerticalSplit<CR>
noremap <silent> <leader>h :BufExplorerHorizontalSplit<CR>

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

" noremap <leader>M :silent exec "!killall MacDown; /usr/local/bin/macdown %"<CR>
if MySys() == "mac"
	noremap <leader>M :silent exec "!pandoc % -f markdown+smart -s --toc --toc-depth=4 -c ~/local/etc/Blank.css -t html -o %.generated.html; open %.generated.html"<CR>
else
	if MySys() == "linux"
		noremap <leader>M :silent exec "!pandoc % -f markdown+smart -s --toc --toc-depth=4 -c ~/local/etc/Blank.css -t html -o %.generated.html; xdg-open %.generated.html"<CR>
	endif
endif
noremap <leader>P :!$HOME/local/bin/image-from-clipboard-to-png-vim % 
noremap <leader>N :!/usr/local/bin/macdown %<CR> 

" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)

" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)


"""""""""""""""""""""""""""""""""""""""
" 自定义命令
"""""""""""""""""""""""""""""""""""""""
" 删除结尾空格定义
command! -nargs=0 TrimR :%s/\s\+$//g

" 对比原始文件，显示更改处
if !exists(":DiffOrig")
    command DiffOrig vert new | set bt=nofile | r # | 0d_ | diffthis
          \ | wincmd p | diffthis
endif

