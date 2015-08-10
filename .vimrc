" 一旦ファイルタイプの設定を無効化。
filetype off
" カラースキーム。
colorscheme desert
" 行ナンバーを表示する。
set number
" 文字コード・改行コードを指定する。
set encoding=utf-8
set fileencodings=utf-8,iso-2022-jp,sjis,euc-jp
set fileformats=unix,dos
" backspaceキーで文字削除を有効にする。
set backspace=indent,eol,start
" オートインデントを設定。
set autoindent
set shiftwidth=2
set expandtab
set tabstop=2
" スワップファイルを作らない。
set noswapfile

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

call neobundle#end()

" Required:
filetype plugin indent on

NeoBundleCheck
