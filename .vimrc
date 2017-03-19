" 一旦ファイルタイプの設定を無効化。
filetype off
" syntax
syntax on
" 行ナンバーを表示する。
set number
" 文字コード・改行コードを指定する。
set encoding=utf-8
set fileencodings=utf-8,iso-2022-jp,sjis,euc-jp
set fileformats=unix,dos
" backspaceキーで文字削除を有効にする。
set backspace=indent,eol,start
" 開いているファイルにカレントディレクトリを移動する。
set autochdir
" オートインデントを設定。
set autoindent
set shiftwidth=2
set expandtab
set tabstop=2
" スワップファイルを作らない。
set noswapfile
" ステータスラインに情報を表示。
set laststatus=2
set statusline=%F%m%r%h%w\[TYPE=%Y]\[FORMAT=%{&ff}]\[ENC=%{&fenc}]\[ROW=%l]\[COL=%v][%p%%]

" 以下neobundleの設定。
if has('vim_starting')
  if &compatible
    set nocompatible " Be iMproved
  endif
  set runtimepath+=~/.vim/bundle/neobundle.vim
endif
call neobundle#begin(expand('~/.vim/bundle/'))

" Let NeoBundle manage NeoBundle
" Required:
NeoBundleFetch 'Shougo/neobundle.vim'

" My Bundles here:
NeoBundle 'Shougo/neocomplcache'
NeoBundle 'Shougo/unite.vim'
NeoBundle 'vim-ruby/vim-ruby'
NeoBundle 'thinca/vim-ref'
NeoBundle 'w0ng/vim-hybrid'
NeoBundle 'othree/html5.vim'

call neobundle#end()

" Required:
filetype plugin indent on

NeoBundleCheck

" カラースキーム。
set background=dark
set term=screen-256color
colorscheme hybrid
highlight Normal ctermbg=none

" erbファイルのインデント有効化。
let g:html5_event_handler_attributes_complete = 1
let g:html5_rdfa_attributes_complete = 1
let g:html5_microdata_attributes_complete = 1
let g:html5_aria_attributes_complete = 1
