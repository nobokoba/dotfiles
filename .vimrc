" ******************************************************************************
" プラグイン
" ******************************************************************************

" Required:
call plug#begin('~/.vim/plugged')

" 最近開いたファイル
Plug 'vim-scripts/mru.vim'

" sudo vim を行った際に.vimrcを見てくれる
Plug 'vim-scripts/sudo.vim'

" 定番
Plug 'scrooloose/nerdtree'

" 正規表現
Plug 'othree/eregex.vim'

" 閉じタグ
Plug 'jiangmiao/auto-pairs'

" colorscheme
"Plug 'tomasr/molokai'
Plug 'Erichain/vim-monokai-pro'

" Yankring
Plug 'vim-scripts/YankRing.vim'

"============================================
" Language Plugins
"============================================
" Go
Plug 'fatih/vim-go'

" Rubyのbegin/endをマッチング
Plug 'vim-scripts/ruby-matchit'

" Rubyのdef/endを自動入力
Plug 'tpope/vim-endwise'

" fish
Plug 'dag/vim-fish'

" Scala
Plug 'derekwyatt/vim-scala'

" Type-script
Plug 'leafgarland/typescript-vim'

" Markdown
Plug 'gabrielelana/vim-markdown'
let g:markdown_include_jekyll_support = 0
let g:markdown_enable_spell_checking = 0

" Required:
call plug#end()

"========================================
" 設定
"========================================
"ソフトタブ幅
set softtabstop=2
"シフト時のタブ幅
set shiftwidth=2
"スマートインデント 
set smartindent
"バックスペースでタブを消せるように
set backspace=2
"拡張ワイルドメニュー
set wildmenu
"一行のテキスト幅
set textwidth=0
"インクリメントサーチ有効
set incsearch
set hlsearch
set noexpandtab
"行リストを表示
set nu
" 機種依存文字を排除
set ambiwidth=double
" バッファを切替えてもundoの効力を失わない
set hidden
" 起動時のメッセージを表示しない
set shortmess+=I
" 折り返ししない
set wrap
" ベルを鳴らさない
set noerrorbells
" ヴィジュアルベル
set visualbell
" ビジュアルベルで何も出さない
set t_vb=
" バックアップをとらない
set nobackup
" スワップファイルを作らない
set noswapfile
" 改行してもコメントを表示しない
set formatoptions-=ro 
" ステータスライン
set laststatus=2
set statusline=%<%f\ %m%r%h%w[%Y]%{'['.(&fenc!=''?&fenc:&enc).']['.&ff.']'}%=%l,%c%8p%%(%L)
"set statusline=%F%m%r%h%w\ [FORMAT=%{&ff}]\ [TYPE=%Y]\ [ASCII=\%03.3b]\ [HEX=\%02.2B]\ [POS=%04l,%04v][%p%%]\ [LEN=%L]
"set statusline=%<%f\ %=%{'['.(&fenc!=''?&fenc:&enc).']['.&fileformat.']'}
" テーマ
set background=light

"カラーシンタックス有効
syntax on

" 補完時のカラー
hi Pmenu ctermbg=5
hi PmenuSel ctermbg=7  ctermfg=0
hi PmenuSbar ctermbg=1
hi PmenuThumb ctermbg=7

" デフォルトのエンコードはutf8.
set fileencodings=utf-8,euc-jp,iso-2022-jp,sjis

"ファイルタイプ別処理
filetype on
filetype indent on
filetype plugin on

" インクリメント時に、0ではじまっている数字を８進数として扱わない
set nrformats=

"========================================
" 環境変数とか
"========================================
if has('win32')
    :set runtimepath+=$HOME/.vim
endif

if has('mac')
  set backupskip=/tmp/*,/private/tmp/*
endif

"========================================
" キーバインド
"========================================

source ~/.vimrc.keymap

"  タグジャンプ周り
"nnoremap [Tag]   <Nop>
"nmap     t [Tag]
"nnoremap [Tag]t  <C-]>
"nnoremap <silent> [Tag]n  :<C-u>tag<CR>
"nnoremap <silent> [Tag]p  :<C-u>pop<CR>
"nnoremap <silent> [Tag]l  :<C-u>tags<CR>

" merge用
if &diff
    nnoremap ,1 :diffget LOCAL<CR>
    nnoremap ,2 :diffget BASE<CR>
    nnoremap ,3 :diffget REMOTE<CR>
endif

" very magic 検索
nnoremap /  /\v

" 最後のディレクトリに自動で移動
:au BufEnter * execute ":lcd " . expand("%:p:h")

" 日本語の際にカーソル色を赤にする
if has('multi_byte_ime') || has('xim') 
    highlight Cursor guifg=NONE guibg=White
    highlight CursorIM guifg=NONE guibg=Red
endif

" ******************************************************************************
" ファイルタイプ
" ******************************************************************************
" Fsharp
au BufRead,BufNewFile *.fs  set filetype=fsharp
au BufRead,BufNewFile *.clj set filetype=clojure

" config file filetype settings
" au BufRead,BufNewFile .muttatorrc  set filetype=vim

au BufRead,BufNewFile */.ssh/conf.d/* set filetype=sshconfig
au BufRead,BufNewFile */.ssh/conf.d/**/* set filetype=sshconfig

hi Comment ctermfg=102
hi Visual  ctermbg=236

" powerline
if has("python3")
  let g:powerline_pycmd="python3"
  silent! python3 from powerline.vim import setup as powerline_setup
  python3 powerline_setup()
  python3 del powerline_setup
  set laststatus=2
  set showtabline=2
  set noshowmode
endif

" モードによってカーソルを変更する
let &t_ti.="\e[1 q"
let &t_te.="\e[5 q"
let &t_SI.="\e[5 q"
let &t_EI.="\e[1 q"
let &t_SR.="\e[3 q"
let &t_ER.="\e[5 q"

" Colorscheme
colorscheme monokai_pro
