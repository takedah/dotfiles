set number
set encoding=utf-8
set fileencodings=utf-8,iso-2022-jp,sjis,euc-jp
set fileformats=unix,dos
set noswapfile
set backspace=indent,eol,start
set autochdir
set autoindent
set expandtab
set shiftwidth=4
set tabstop=4
set shiftround
nnoremap j gj
nnoremap k gk

"dein Scripts-----------------------------
if &compatible
  set nocompatible               " Be iMproved
endif

" Required:
set runtimepath+=~/.vim/bundles/repos/github.com/Shougo/dein.vim

" Required:
if dein#load_state('~/.vim/bundles')
  call dein#begin('~/.vim/bundles')

  " Let dein manage dein
  " Required:
  call dein#add('~/.vim/bundles/repos/github.com/Shougo/dein.vim')

  " Add or remove your plugins here:
  call dein#add('Shougo/vimshell')
  call dein#add('Shougo/unite.vim')
  call dein#add('scrooloose/nerdtree')
  call dein#add('Shougo/neomru.vim')
  call dein#add('Shougo/neocomplete.vim')
  call dein#add('nathanaelkane/vim-indent-guides')
  call dein#add('bronson/vim-trailing-whitespace')
  call dein#add('tpope/vim-surround')
  call dein#add('junegunn/vim-easy-align')
  call dein#add('davidhalter/jedi-vim')
  call dein#add('thinca/vim-ref')
  call dein#add('tpope/vim-fugitive')
  call dein#add('scrooloose/syntastic')
  call dein#add('nanotech/jellybeans.vim')
  call dein#add('othree/html5.vim')

  " Required:
  call dein#end()
  call dein#save_state()
endif

" Required:
filetype plugin indent on
syntax enable

"If you want to install not installed plugins on startup.
if dein#check_install()
  call dein#install()
endif

"End dein Scripts-------------------------

" neocomplete Settings--------------------
"Note: This option must be set in .vimrc(_vimrc).  NOT IN .gvimrc(_gvimrc)!
" neocomplete
" Disable AutoCompPop.
let g:acp_enableAtStartup = 0
" Use neocomplete.
let g:neocomplete#enable_at_startup = 1
" Use smartcase.
let g:neocomplete#enable_smart_case = 1
" Set minimum syntax keyword length.
let g:neocomplete#sources#syntax#min_keyword_length = 3

" Define dictionary.
 let g:neocomplete#sources#dictionary#dictionaries = {
    \ 'default' : '',
    \ 'vimshell' : $HOME.'/.vimshell_hist',
    \ 'scheme' : $HOME.'/.gosh_completions'
      \ }

" Define keyword.
if !exists('g:neocomplete#keyword_patterns')
    let g:neocomplete#keyword_patterns = {}
endif
let g:neocomplete#keyword_patterns['default'] = '\h\w*'

" Plugin key-mappings.
inoremap <expr><C-g>     neocomplete#undo_completion()
inoremap <expr><C-l>     neocomplete#complete_common_string()

" Recommended key-mappings.
" <CR>: close popup and save indent.
inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
function! s:my_cr_function()
  "return (pumvisible() ? "\<C-y>" : "" ) . "\<CR>"
  " For no inserting <CR> key.
  return pumvisible() ? "\<C-y>" : "\<CR>"
endfunction
" <TAB>: completion.
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
" <C-h>, <BS>: close popup and delete backword char.
inoremap <expr><C-h> neocomplete#smart_close_popup()."\<C-h>"
inoremap <expr><BS> neocomplete#smart_close_popup()."\<C-h>"
" Close popup by <Space>.
"inoremap <expr><Space> pumvisible() ? "\<C-y>" : "\<Space>"

" AutoComplPop like behavior.
"let g:neocomplete#enable_auto_select = 1

" Shell like behavior(not recommended).
"set completeopt+=longest
"let g:neocomplete#enable_auto_select = 1
"let g:neocomplete#disable_auto_complete = 1
"inoremap <expr><TAB>  pumvisible() ? "\<Down>" : "\<C-x>\<C-u>"

" Enable omni completion.
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
"autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags

" Enable heavy omni completion.
if !exists('g:neocomplete#sources#omni#input_patterns')
  let g:neocomplete#sources#omni#input_patterns = {}
endif
"let g:neocomplete#sources#omni#input_patterns.php = '[^.\t]->\h\w*\|\h\w*::'
"let g:neocomplete#sources#omni#input_patterns.c = '[^.[:digit:]*\t]\%(\.\|->\)'
"let g:neocomplete#sources#omni#input_patterns.cpp = '[^.[:digit:]*\t]\%(\.\|->\)\|\h\w*::'
"
" For perlomni.vim setting.
" https://github.com/c9s/perlomni.vim
let g:neocomplete#sources#omni#input_patterns.perl = '\h\w*->\h\w*\|\h\w*::'

" For jedi-vim setting.
" https://dackdive.hateblo.jp/entry/2014/08/13/130000
autocmd FileType python setlocal omnifunc=jedi#complications
let g:jedi#complications_enabled = 0
let g:jedi#auto_vim_cofiguration = 0
if !exists('g:neocomplete#force_omni_input_patterns')
    let g:neocomplete#force_omni_input_patterns = {}
endif
let g:neocomplete#force_omni_input_patterns.python = '\h\w*\|[^. \t]\.\w*'
autocmd FileType python setlocal completeopt-=preview
" End neocomplete Settings----------------

" indent-guides Settings------------------
let g:indent_guides_enable_on_vim_startup = 1
" End indent-guides Settings--------------

" syntastic Settings----------------------
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_python_checkers = ["flake8"]
" End syntastic Settings------------------

" NERDTree Settings-----------------------
autocmd vimenter * NERDTree
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
map <C-n> :NERDTreeToggle<CR>
" End NERDTree Settings-------------------

" Appearance Settings---------------------
set hlsearch
set list
set laststatus=2
set statusline=%F%m%r%h%w\[TYPE=%Y]\[FORMAT=%{&ff}]\[ENC=%{&fenc}]\[ROW=%l]\[COL=%v][%p%%]set background=dark
set term=screen-256color
colorscheme jellybeans
highlight Normal ctermbg=none
highlight NonText ctermbg=none
highlight SpecialKey ctermbg=none
highlight EndOfBuffer ctermbg=none
" End Appearance Settings-----------------
