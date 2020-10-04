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
set iskeyword-=_
nnoremap j gj
nnoremap k gk

"dein Settings----------------------------
if &compatible
  set nocompatible               " Be iMproved
endif
" Add the dein installation directory into runtimepath
set runtimepath+=~/.cache/dein/repos/github.com/Shougo/dein.vim

let s:toml_dir = '~/.config/nvim/toml/'
let s:toml = s:toml_dir . 'dein.toml'
let s:toml_lazy = s:toml_dir . 'dein_lazy.toml'
if dein#load_state('~/.cache/dein')
  call dein#begin('~/.cache/dein')

  call dein#add('~/.cache/dein/repos/github.com/Shougo/dein.vim')
  call dein#add('nanotech/jellybeans.vim')
  call dein#add('Shougo/denite.nvim')
  call dein#add('scrooloose/nerdtree')
  call dein#add('Shougo/deoplete.nvim')
  call dein#add('deoplete-plugins/deoplete-jedi')
  call dein#add('Shougo/neosnippet.vim')
  call dein#add('Shougo/neosnippet-snippets')
  call dein#add('thinca/vim-ref')
  call dein#add('Shougo/neomru.vim')
  call dein#add('bronson/vim-trailing-whitespace')
  call dein#add('tpope/vim-surround')
  call dein#add('junegunn/vim-easy-align')
  call dein#add('tpope/vim-fugitive')
  call dein#add('scrooloose/syntastic')
  call dein#add('othree/html5.vim')
  call dein#add('nathanaelkane/vim-indent-guides')

  call dein#end()
  call dein#save_state()
endif

filetype plugin indent on
syntax enable

" install not installed plugins on startup.
if dein#check_install()
  call dein#install()
endif
"End dein Settings------------------------

" denite
autocmd FileType denite call s:denite_my_settings()
function! s:denite_my_settings() abort
nnoremap <silent><buffer><expr> <CR>
\ denite#do_map('do_action')
nnoremap <silent><buffer><expr> d
\ denite#do_map('do_action', 'delete')
nnoremap <silent><buffer><expr> p
\ denite#do_map('do_action', 'preview')
nnoremap <silent><buffer><expr> q
\ denite#do_map('quit')
nnoremap <silent><buffer><expr> i
\ denite#do_map('open_filter_buffer')
nnoremap <silent><buffer><expr> <Space>
\ denite#do_map('toggle_select').'j'
endfunction
autocmd FileType denite-filter call s:denite_filter_my_settings()
function! s:denite_filter_my_settings() abort
    imap <silent><buffer> <C-o> <Plug>(denite_filter_quit)
endfunction

" NERDTree
autocmd vimenter * NERDTree
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
map <C-n> :NERDTreeToggle<CR>

" dep\oplete
let g:deoplete#enable_at_startup = 1
call deoplete#custom#option('smart_case', v:true)
inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
function! s:my_cr_function() abort
    return deoplete#close_popup() . "\<CR>"
endfunction
call deoplete#custom#option('omni_patterns', {
        \ 'python': '\%([^. \t]\.\|^\s*@\|^\s*from\s.\+import \|^\s*from \|^\s*import \)\w*',
        \ 'ruby': ['[^. *\t]\.\w*', '[a-zA-Z_]\w*::'],
        \ 'java': '[^. *\t]\.\w*',
        \ 'html': ['<', '</', '<[^>]*\s[[:alnum:]-]*'],
        \ 'xhtml': ['<', '</', '<[^>]*\s[[:alnum:]-]*'],
        \ 'xml': ['<', '</', '<[^>]*\s[[:alnum:]-]*'],
        \})
let g:python3_host_prog = '~/.pyenv/shims/python'

" neosnippet
imap <C-k>     <Plug>(neosnippet_expand_or_jump)
smap <C-k>     <Plug>(neosnippet_expand_or_jump)
xmap <C-k>     <Plug>(neosnippet_expand_target)
smap <expr><TAB> neosnippet#expandable_or_jumpable() ?
\ "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"

" syntastic
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_python_checkers = ["flake8"]

" vim-indent-guides
let g:indent_guides_enable_on_vim_startup = 1

" Appearance Settings---------------------
set hlsearch
set list
set laststatus=2
set statusline=%F%m%r%h%w\[TYPE=%Y]\[FORMAT=%{&ff}]\[ENC=%{&fenc}]\[ROW=%l]\[COL=%v][%p%%]set
set background=dark
colorscheme jellybeans
highlight Normal ctermbg=none
highlight NonText ctermbg=none
highlight SpecialKey ctermbg=none
highlight EndOfBuffer ctermbg=none
