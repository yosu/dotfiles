"flip paste mode
nnoremap <F4> :set invpaste paste?<CR>

"vimrcの編集と反映
nnoremap <F5> :<C-u>edit $MYVIMRC<CR>
nnoremap <F6> :<C-u>source $MYVIMRC<CR>

"filetype off
""call pathogen#runtime_append_all_bundles()
"filetype on
"filetype indent on
"filetype plugin on

syntax on
set visualbell t_vb=
set tabstop=4
set shiftwidth=4
set expandtab
set autoindent
set nocompatible
set number
set hidden

colorscheme desert

"set background=dark
"colorscheme solarized
" バックスペースでインデントや改行を削除できるようにする
set backspace=indent,eol,start

"検索時のハイライト
set hlsearch

"インクリメンタルサーチ
set incsearch

"search case
set ignorecase
set smartcase

"Escの2回押しでハイライト消去
nmap  :nohlsearch

" ヤンクした内容をクリップボードに入れる
set clipboard+=unnamed

" スワップファイルの保存先
set directory=~/.vimbackups

" バックアップファイルの保存先
set backupdir=~/.vimbackups

" Visual選択されたテキストが自動的にクリップボードレジスタにコピーされる
set guioptions+=a

" 行末の不要なスペースを削除
function! RTrim()
  let s:cursor = getpos(".")
  %s/¥s¥+$//e
  call setpos(".", s:cursor)
endfunction
autocmd BufWritePre * call RTrim()

" IMEの状態でカーソルの色を変える
if has('multi_byte_ime')
  highlight CursorIM guifg=NONE guibg=Red
endif

"set lines=50
"set columns=150

set laststatus=2

set statusline=%<%f\ %m%r%h%w
set statusline+=%{'['.(&fenc!=''?&fenc:&enc).']['.&fileformat.']'}
set statusline+=%=%l/%L,%c%V%8P

iab pdbg use Data::Dumper 'Dumper';warn Dumper [];hi
iab pbmk use Benchmark qw( cmpthese );cmpthese -10, {};0
iab putm use Test::More qw( no_plan );
iab pmod :r ~/.code_templates/perl_module.pm

"数字の8進数扱いをやめる
set nrformats-=octal

au BufRead,BufNewFile *.scala set filetype=scala
au BufRead,BufNewFile *.t set filetype=perl
au BufRead,BufNewFile *.ts set filetype=typescript
au BufRead,BufNewFile *.json set filetype=javascript

autocmd BufNewFile *.pl 0r $HOME/.vim/template/perl-script.txt
autocmd BufNewFile *.t  0r $HOME/.vim/template/perl-test.txt

function! s:pm_template()
    let path = substitute(expand('%'), '.*lib/', '', 'g')
    let path = substitute(path, '[\\/]', '::', 'g')
    let path = substitute(path, '\.pm$', '', 'g')

    call append(0, 'package ' . path . ';')
    call append(1, 'use strict;')
    call append(2, 'use warnings;')
    call append(3, 'use utf8;')
    call append(4, '')
    call append(5, '')
    call append(6, '')
    call append(7, '1;')
    call cursor(6, 0)
    " echomsg path
endfunction

autocmd BufNewFile *.pm call s:pm_template()

function! s:get_package_name()
    let mx = '^\s*package\s\+\([^ ;]\+\)'
    for line in getline(1, 5)
        if line =~ mx
            return substitute(matchstr(line, mx), mx, '\1', '')
        endif
    endfor
    return ""
endfunction

function! s:check_package_name()
    let path = substitute(expand('%:p'), '\\', '/', 'g')
    let name = substitute(s:get_package_name(), '::', '/', 'g') . '.pm'
    if path[-len(name):] != name
        echohl WarningMsg
        echomsg "ぱっけーじめいと、ほぞんされているぱすが、ちがうきがします！"
        echomsg "ちゃんとなおしてください＞＜"
        echohl None
    endif
endfunction

au! BufWritePost *.pm call s:check_package_name()

map ,pt <Esc>:%! perltidy -se<CR>
map ,ptv <Esc>:'<,'>! perltidy -se<CR>

"Vundle

set nocompatible               " be iMproved
filetype off                   " required!

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

" let Vundle manage Vundle
" required! 
Bundle 'gmarik/vundle'

" My Bundles here:
"
" original repos on github
Bundle 'tpope/vim-surround'
Bundle 'tpope/vim-repeat'
Bundle 'Shougo/unite.vim'
Bundle 'Shougo/neocomplcache'
Bundle 'Shougo/neosnippet'
Bundle 'Shougo/neosnippet-snippets'
Bundle 'rbgrouleff/bclose.vim'
Bundle 'bufexplorer.zip'
Bundle 'honza/vim-snippets'
Bundle "mattn/emmet-vim"
Bundle 'othree/html5.vim'
"Bundle 'scrooloose/syntastic'
"Bundle 'tpope/vim-fugitive'
"Bundle 'Lokaltog/vim-easymotion'
"Bundle 'rstacruz/sparkup', {'rtp': 'vim/'}
"Bundle 'tpope/vim-rails.git'
" vim-scripts repos
"Bundle 'L9'
"Bundle 'FuzzyFinder'
" non github repos
"Bundle 'git://git.wincent.com/command-t.git'
" ...

filetype plugin indent on     " required!
"
" Brief help
" :BundleList          - list configured bundles
" :BundleInstall(!)    - install(update) bundles
" :BundleSearch(!) foo - search(or refresh cache first) for foo
" :BundleClean(!)      - confirm(or auto-approve) removal of unused bundles
"
" see :h vundle for more details or wiki for FAQ
" NOTE: comments after Bundle command are not allowed..

"Coffee編集中のファイルをコンパイルした状態のプレビューを見る
"let g:quickrun_config = {}
"let g:quickrun_config['coffee'] = {'command' : 'coffee', 'exec' : ['%c -cbp %s']}

" unite.vim
" 参考:http://d.hatena.ne.jp/ruedap/20110110/vim_unite_plugin
"
"入力モードで開始する
let g:unite_enable_start_insert=1
" バッファ一覧
nnoremap <silent> ,ub :<C-u>Unite buffer<CR>
"" ファイル一覧
nnoremap <silent> ,uf :<C-u>UniteWithBufferDir -buffer-name=files file<CR>
"" レジスタ一覧
nnoremap <silent> ,ur :<C-u>Unite -buffer-name=register register<CR>
"" 最近使用したファイル一覧
nnoremap <silent> ,um :<C-u>Unite file_mru<CR>
"" 常用セット
nnoremap <silent> ,uu :<C-u>Unite buffer file_mru<CR>
"" 全部乗せ
nnoremap <silent> ,ua :<C-u>UniteWithBufferDir -buffer-name=files buffer file_mru bookmark file<CR>
"
" ウィンドウを分割して開く
au FileType unite nnoremap <silent> <buffer> <expr> <C-j> unite#do_action('split')
au FileType unite inoremap <silent> <buffer> <expr> <C-j> unite#do_action('split')
" ウィンドウを縦に分割して開く
au FileType unite nnoremap <silent> <buffer> <expr> <C-l> unite#do_action('vsplit')
au FileType unite inoremap <silent> <buffer> <expr> <C-l> unite#do_action('vsplit')
" ESCキーを2回押すと終了する
au FileType unite nnoremap <silent> <buffer> <ESC><ESC> q
au FileType unite inoremap <silent> <buffer> <ESC><ESC> <ESC>qu

""BufExplorer
"nmap <c-b> :BufExplorer<CR>
"
"
" neocomplcache
let g:neocomplcache_enable_at_startup = 1 " 起動時に有効化
"ユーザ定義の辞書を指定
let g:neocomplcache_dictionary_filetype_lists = {
  \ 'default' : '',
  \ 'scala' : $HOME . '/.vim/dict/scala.dict',
  \ }
" neocomplcache end

" neosnippet
" Plugin key-mappings.
imap <C-k>     <Plug>(neosnippet_expand_or_jump)
smap <C-k>     <Plug>(neosnippet_expand_or_jump)

" SuperTab like snippets behavior.
imap <expr><TAB> neosnippet#expandable() ? "\<Plug>(neosnippet_expand_or_jump)" : pumvisible() ? "\<C-n>" : "\<TAB>"
smap <expr><TAB> neosnippet#expandable() ? "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"

" For snippet_complete marker.
if has('conceal')
  set conceallevel=2 concealcursor=i
endif

let g:neosnippet#snippets_directory='~/.vim/bundle/vim-snippets/snippets'
" neosnippet end

" bufexplorer
nmap <C-b> \be
