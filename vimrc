" encoding
set encoding=utf-8

" flip paste mode
nnoremap <F4> :set invpaste paste?<CR>

" Edit and apply vimrc
nnoremap <F5> :<C-u>edit $MYVIMRC<CR>
nnoremap <F6> :<C-u>source $MYVIMRC<CR>

syntax on
set visualbell t_vb=
set tabstop=4
set shiftwidth=4
set expandtab
set autoindent
set nocompatible
set number
set hidden

colorscheme thankful_eyes

set backspace=indent,eol,start " backspace deletes indent and end-of-line

set hlsearch
set incsearch
set ignorecase
set smartcase

nmap  :nohlsearch

set directory=~/.vimbackups " the directory to save swap files
set backupdir=~/.vimbackups

" Copy the text selected visually into clipboard register
set guioptions+=a
" Insert yanking text into clipboard
set clipboard+=unnamed


" Remove right side spaces
function! RTrim()
  let s:cursor = getpos(".")
  %s/¥s¥+$//e
  call setpos(".", s:cursor)
endfunction
autocmd BufWritePre * call RTrim()

" Change cursor color with IME state
if has('multi_byte_ime')
  highlight CursorIM guifg=NONE guibg=Red
endif

set laststatus=2
set statusline=%<%f\ %m%r%h%w
set statusline+=%{'['.(&fenc!=''?&fenc:&enc).']['.&fileformat.']'}
set statusline+=%=%l/%L,%c%V%8P

iab pdbg use Data::Dumper 'Dumper';warn Dumper [];hi
iab pbmk use Benchmark qw( cmpthese );cmpthese -10, {};0
iab putm use Test::More qw( no_plan );
iab pmod :r ~/.code_templates/perl_module.pm

" No octal number format
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
Bundle 'godlygeek/csapprox'

filetype plugin indent on     " required!

" unite.vim
" reference: http://d.hatena.ne.jp/ruedap/20110110/vim_unite_plugin
"
" enable at input mode
let g:unite_enable_start_insert=1
nnoremap <silent> ,ub :<C-u>Unite buffer<CR>
" files
nnoremap <silent> ,uf :<C-u>UniteWithBufferDir -buffer-name=files file<CR>
" registers
nnoremap <silent> ,ur :<C-u>Unite -buffer-name=register register<CR>
" recently file lists
nnoremap <silent> ,um :<C-u>Unite file_mru<CR>
nnoremap <silent> ,uu :<C-u>Unite buffer file_mru<CR>
" all
nnoremap <silent> ,ua :<C-u>UniteWithBufferDir -buffer-name=files buffer file_mru bookmark file<CR>
" splits
au FileType unite nnoremap <silent> <buffer> <expr> <C-j> unite#do_action('split')
au FileType unite inoremap <silent> <buffer> <expr> <C-j> unite#do_action('split')
au FileType unite nnoremap <silent> <buffer> <expr> <C-l> unite#do_action('vsplit')
au FileType unite inoremap <silent> <buffer> <expr> <C-l> unite#do_action('vsplit')
" End by double ESC
au FileType unite nnoremap <silent> <buffer> <ESC><ESC> q
au FileType unite inoremap <silent> <buffer> <ESC><ESC> <ESC>qu

" neocomplcache
let g:neocomplcache_enable_at_startup = 1 " 起動時に有効化
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
