"""""""""""""""""""""""""""""""""""""""
"Utils
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

set viminfo+=!


"""""""""""""""""""""""""""""""""""""""
" Plugin Management
"""""""""""""""""""""""""""""""""""""""

call plug#begin()

" My Bundles here:


" Syntax
Plug 'vim-scripts/asciidoc.vim'
Plug 'vim-scripts/confluencewiki.vim'
Plug 'othree/html5.vim'
"Plug 'vim-scripts/JavaScript-syntax'
"Plug 'vim-scripts/mako.vim'
Plug 'vim-scripts/moin.vim'
Plug 'vim-scripts/python.vim--Vasiliev'
Plug 'vim-scripts/xml.vim'
Plug 'vim-scripts/less'
" Plug 'hallison/vim-markdown'
" Plug 'tpope/vim-markdown'
Plug 'vim-scripts/wikipedia.vim'
Plug 'derekwyatt/vim-scala'
" play1
" Plug 'alswl/play2vim'
" play2
Plug 'gre/play2vim'
Plug 'tpope/vim-haml'
Plug 'kchmck/vim-coffee-script'
Plug 'vim-ruby/vim-ruby'
Plug 'vim-scripts/django.vim'
" Plug 'vim-scripts/nginx.vim'
Plug 'saltstack/salt-vim'
Plug 'fatih/vim-go'
Plug 'vim-scripts/haproxy'
Plug 'mustache/vim-mustache-handlebars'
Plug 'chase/vim-ansible-yaml'
Plug 'leafgarland/typescript-vim'
Plug 'alswl/plantuml-syntax'
" Plug 'spacewander/openresty-vim'
Plug 'hexchain/vim-openresty'
Plug 'vim-scripts/applescript.vim'
"Plug 'pangloss/vim-javascript'
"Plug 'othree/yajs.vim'
"Plug 'mxw/vim-jsx'
Plug 'skreuzer/vim-prometheus'


" Color
Plug 'vim-scripts/desert256.vim'
Plug 'vim-scripts/vividchalk.vim'
Plug 'vim-scripts/ego.vim'
"Plug 'tomasr/molokai'
Plug 'crusoexia/vim-monokai'
Plug 'altercation/vim-colors-solarized'
Plug 'morhetz/gruvbox'

" Ftplugin
"Plug 'vim-scripts/python_fold'

" Indent
"Plug 'indent/html.vim'
Plug 'vim-scripts/IndentAnything'
" Plug 'vim-scripts/Javascript-Indentation'
Plug 'vim-scripts/mako.vim--Torborg'
Plug 'gg/python.vim'
Plug 'lepture/vim-jinja'

" Plugins
Plug 'preservim/nerdtree'
"Plug 'AutoClose--Alves'
Plug 'vim-scripts/auto_mkdir'
" required by XXX
Plug 'vim-scripts/cecutil'
" encode detect
Plug 'mbbill/fencview'
" Plug 'vim-scripts/FuzzyFinder'
Plug 'vim-scripts/jsbeautify'
" required by XXX
Plug 'vim-scripts/L9'
" required for vim-mark
" required for FilePathConvert
Plug 'inkarkat/vim-ingo-library'
" mark in different color, leader + m
Plug 'inkarkat/vim-mark'
" joke
Plug 'vim-scripts/matrix.vim'
" most recent used
Plug 'vim-scripts/mru.vim'
" auto comment
Plug 'scrooloose/nerdcommenter'
Plug 'vim-scripts/restart.vim'
"Tlist
"Plug 'vim-scripts/taglist.vim'
"Plug 'vim-scripts/templates.vim'
Plug 'majutsushi/tagbar'
"Plug 'vim-scripts/vimim.vim'
Plug 'mattn/emmet-vim'
"Plug 'css_color.vim'
"Plug 'hallettj/jslint.vim'
" code source
"Plug 'vim-scripts/vcscommand.vim'
" task list search
"Plug 'vim-scripts/TaskList.vim'
"Plug 'vim-scripts/pep8'
"Plug 'git://github.com/kevinw/pyflakes-vim.git'
"Rope, a python refactoring library
"Plug 'sontek/rope-vim'
"Plug 'project.tar.gz'
"Plug 'vim-scripts/minibufexplorerpp'
Plug 'vim-scripts/bufexplorer.zip'
"Plug 'vim-scripts/Align.vim'
"Plug 'vim-scripts/SQLUtilities'
" extened % for html ...
Plug 'vim-scripts/matchit.zip'
" % jump, </> pair, >> for complete
Plug 'vim-scripts/xmledit'
" ascii drawing, \di, \ds
" Plug 'vim-scripts/DrawIt'
" Outdated
Plug 'alswl/DrawIt'
" Plug 'gyim/vim-boxdraw' 
" NR, NW
Plug 'chrisbra/NrrwRgn'
" status bar
" Plug 'Lokaltog/vim-powerline'
" Plug 'scala/scala-dist'
Plug 'terryma/vim-multiple-cursors'
" original repos on github
"Plug 'tpope/vim-fugitive'
"Plug 'Lokaltog/vim-easymotion'
"Plug 'rstacruz/sparkup', {'rtp': 'vim/'}
"Plug 'tpope/vim-rails.git'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'vim-scripts/Rename'
Plug '907th/vim-auto-save'
" Plug 'nelstrom/vim-markdown-folding'
Plug 'godlygeek/tabular'
Plug 'plasticboy/vim-markdown'
Plug 'vim-pandoc/vim-pandoc-syntax'
Plug 'rhysd/vim-gfm-syntax'
Plug 'dhruvasagar/vim-table-mode'
" Plug 'lilydjwg/fcitx.vim'
Plug 'CodeFalling/fcitx-vim-osx'
Plug 'junegunn/vim-easy-align'
"Plug 'wannesm/wmgraphviz.vim'
Plug 'hotoo/pangu.vim'
Plug 'vim-jp/autofmt'
Plug 'sirver/ultisnips'
Plug 'honza/vim-snippets'
"Plug 'jiangmiao/auto-pairs'
" required by FilePathConvert
Plug 'inkarkat/vim-TextTransform'
Plug 'vim-scripts/FilePathConvert'


" for vim-pyref

" non github repos
"Plug 'git://git.wincent.com/command-t.git'
call plug#end()

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
		set guifont=Fira\ Code:h14
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
	" colorscheme monokai
	colorscheme gruvbox
else
	colorscheme gruvbox
	"colorscheme desert256
endif

set background=dark
" set background=light

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

autocmd BufRead,BufNewFile *.md set filetype=markdown
autocmd BufRead,BufNewFile */tmp/edit-server-prometheus**.txt set filetype=prometheus
autocmd BufRead,BufNewFile */tmp/edit-server-*.txt set filetype=markdown.gfm
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

autocmd FileType python setlocal expandtab colorcolumn=80 textwidth=0 diffopt=vertical " fo+=Mm
"Map F9 to Run Python Script
autocmd FileType python map <F9> :!python %
autocmd FileType asciidoc setlocal colorcolumn=120
autocmd FileType markdown,markdown.pandoc,markdown.github,markdown.gfm
						\ setlocal colorcolumn=120 expandtab shiftwidth=2 nowrap
						\ tabstop=2 textwidth=120
						\ formatexpr=autofmt#uax14#formatexpr()
						\ noshowmatch
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
autocmd FileType sh setlocal expandtab shiftwidth=2
autocmd FileType dockerfile setlocal expandtab shiftwidth=2

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
"set formatoptions=croqn2mB1
"try
  "" Vim 7.4
  "set formatoptions+=j
"catch /.*/
"endtry
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


" fuzzyfinder
"map <silent> <leader>sf :FufFile<CR>
"map <silent> <leader>sb :FufBuffer<CR>

" jslint.vim
" let g:JSLintHighlightErrorLine = 0 " disabled

" Fencview
" let g:fencview_autodetect = 1

" JSLint
let g:JSLintHighlightErrorLine = 0

" Project
"map <silent> <leader>p :Project<CR>

" NERDTree
let g:NERDTreeIgnore = ['\.pyc$', '\.class$', '\.jpeg$', '\.jpg$', '\.png$', '\.git$', '^target$', '\.slide\.html$', '\.generated\.html$', '\.md\.assets$']
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
let g:ctrlp_root_markers = ['.ctrlp', 'README.md', 'build.sbt', '.git']
let g:ctrlp_custom_ignore = {
	\ 'dir':  '\v[\/](\.(git|hg|svn)$)|target|node_modules',
	\ 'file': '\v\.(exe|so|dll|class|jar|png|jpeg|jpg|numbers|slide.html|generated.html|graphml|svg)$',
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
  if &filetype != 'markdown' && &filetype != 'markdown.gfm' && &filetype != 'markdown.pandoc'&& &filetype != 'plantuml'
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

let g:pandoc#syntax#conceal#use = 0

" vim-mark
"nmap <silent> <leader>hl <Plug>MarkSet
"vmap <silent> <leader>hl <Plug>MarkSet
"nmap <silent> <leader>hh <Plug>MarkClear
"vmap <silent> <leader>hh <Plug>MarkClear
"nmap <silent> <leader>hr <Plug>MarkRegex
"vmap <silent> <leader>hr <Plug>MarkRegex
let g:mwAutoLoadMarks = 1
runtime plugin/mark.vim
silent 6Mark TODO
silent 6Mark FIXME
silent 6Mark XXX
silent 6Mark @djc
silent 6Mark @3D
silent 6Mark @alswl
silent 6Mark @jingchao.djc
silent 6Mark @jingchao
silent 6Mark @三谛
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
let g:vim_markdown_folding_disabled = 1
let g:vim_markdown_new_list_item_indent = 4
let g:vim_markdown_math = 1
let g:vim_markdown_conceal = 0
let g:vim_markdown_conceal = 0
let g:vim_markdown_conceal_code_blocks = 0
let g:vim_markdown_new_list_item_indent = 2

" matchparen
let g:matchparen_timeout = 2
let g:matchparen_insert_timeout = 2


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
map <S-k> <Nop>

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

nnoremap <S-Tab> <<
inoremap <S-Tab> <C-d>

" delete without yanking
" nnoremap <leader>d "_d
" vnoremap <leader>d "_d

" pip install pandoc-plantuml
if MySys() == "mac"
	noremap <leader>N :!open -a MacDown %<CR> 
	" noremap <leader>N :!open -a Typora %<CR> 
	" noremap <leader>M :silent exec "!open -a Macdown %"<CR>
	noremap <leader>M :silent exec "!pandoc % -f markdown+smart -s --toc --toc-depth=4 -c ~/local/etc/Blank.css --mathjax='https://cdn.staticfile.org/mathjax/2.7.5/MathJax.js?config=TeX-AMS-MML_HTMLorMML' --filter=pandoc-plantuml -t html -o %.generated.html && open %.generated.html"<CR>
else
	if MySys() == "linux"
		noremap <leader>M :silent exec "!pandoc % -f markdown+smart -s --toc --toc-depth=4 -c ~/local/etc/Blank.css --filter=pandoc-plantuml -t html -o %.generated.html && xdg-open %.generated.html"<CR>
	endif
endif
noremap <leader>u :silent exec "!plantuml -tpng % && open %:r.png"<CR>
noremap <leader>U :silent exec "!plantuml -tsvg % && open . && open  %:r.svg"<CR>
noremap <leader>p :!$HOME/local/bin/image-from-clipboard-to-png-copy-markdown % 
"noremap <leader>p :!$HOME/local/bin/image-from-clipboard-to-png-global % 
noremap <leader>P :!$HOME/local/bin/image-from-path-to-assets-copy-markdown % 

" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)

" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)

" Trigger configuration. Do not use <tab> if you use https://github.com/Valloric/YouCompleteMe.
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"

" If you want :UltiSnipsEdit to split your window.
let g:UltiSnipsEditSplit="vertical"

" latex
let g:tex_flavor='latex'
let g:vimtex_view_method='zathura'
let g:vimtex_quickfix_mode=0
set conceallevel=1
let g:tex_conceal='abdmg'

let g:ruby_host_prog='~/.rvm/gems/ruby-2.4.0/bin/neovim-ruby-host'

" fcitx
" disable on MacVim
if has("gui_running")
	let g:fcitx_remote=1
endif

" nerdcommenter
let g:NERDSpaceDelims = 1
let g:NERDCustomDelimiters = { 'conf': { 'left': '#','right': '' } }


"""""""""""""""""""""""""""""""""""""""
" User Defined function
"""""""""""""""""""""""""""""""""""""""

" trim right of line 
command! -nargs=0 TrimR :%s/\s\+$//g

" diff Original file
if !exists(":DiffOrig")
    command DiffOrig vert new | set bt=nofile | r # | 0d_ | diffthis
          \ | wincmd p | diffthis
endif

if !exists(":MarkdownListBulletOn")
	command MarkdownListBulletOff setlocal comments=b:>,b:*,b:+,b:-
endif
if !exists(":MarkdownListBulletOff")
	command MarkdownListBulletOn setlocal comments=fb:>,fb:*,fb:+,fb:-
endif
