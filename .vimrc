" execute pathogen#infect()

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'pangloss/vim-javascript'
Plugin 'zweifisch/pipe2eval'
Plugin 'FuzzyFinder'
Plugin 'L9'
Plugin 'Raimondi/delimitMate'
Plugin 'Shougo/neocomplcache.vim'
Plugin 'Shougo/vimproc'
Plugin 'Shougo/vimshell.vim'
Plugin 'SirVer/ultisnips'
Plugin 'airblade/vim-gitgutter'
Plugin 'altercation/vim-colors-solarized'
Plugin 'bling/vim-airline'
Plugin 'dhruvasagar/vim-table-mode'
Plugin 'ervandew/supertab'
Plugin 'git://git.wincent.com/command-t.git'
Plugin 'gmarik/vundle'
Plugin 'gregsexton/MatchTag'
Plugin 'heavenshell/vim-jsdoc'
Plugin 'honza/vim-snippets'
Plugin 'hsitz/VimOrganizer'
Plugin 'https://github.com/flazz/vim-colorschemes'
Plugin 'https://github.com/scrooloose/syntastic'
Plugin 'int3/vim-taglist-plus'
Plugin 'jceb/vim-orgmode'
Plugin 'jelera/vim-javascript-syntax'
Plugin 'jnwhiteh/vim-golang'
Plugin 'kien/ctrlp.vim'
Plugin 'majutsushi/tagbar'
Plugin 'maksimr/vim-jsbeautify'
Plugin 'maksimr/vim-yate'
Plugin 'marijnh/tern_for_vim'
Plugin 'mileszs/ack.vim'
Plugin 'nathanaelkane/vim-indent-guides'
Plugin 'nono/jquery.vim'
Plugin 'rstacruz/sparkup', {'rtp': 'vim/'}
Plugin 'scrooloose/nerdtree.git'
Plugin 'terryma/vim-multiple-cursors'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-rails.git'
Plugin 'vim-flake8'
Plugin 'vim-scripts/Conque-Shell'
Plugin 'vim-scripts/EasyGrep'
Plugin 'vimoutliner/vimoutliner'
Plugin 'wavded/vim-stylus'
call vundle#end()


set runtimepath+=$GOROOT/misc/vim
map <C-±> :NERDTreeToggle<CR>

let mapleader=","
set wildmode=list:longest,full " Автодополнение на манер zsh в командной строке

set nocompatible                " Отключени режима совместимости с VI
filetype off                    " Отключает распознавание типа файла
set number                      " Включает нумерацию строк
set cursorline                  " Подсветка текущей строки
syntax on                       " Подсветка синтаксиса
filetype plugin indent on       " Игнорирование регистра при поиске

"" Disable AutoComplPop.
let g:acp_enableAtStartup = 0
" Use neocomplcache.
let g:neocomplcache_enable_at_startup = 1
" " Use smartcase.
let g:neocomplcache_enable_smart_case = 1
" " Set minimum syntax keyword length.
let g:neocomplcache_min_syntax_length = 2

let g:syntastic_javascript_checkers = ['jshint']

" Подсветка метасимволов
set backspace=indent,eol,start                  " Баги с бэкспейсом
set list listchars=tab:▸-,trail:·               " Подсвтека неотображаемых символов
set list

set incsearch
set ignorecase


" Highlight extra whitespaces
highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/
autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
autocmd InsertLeave * match ExtraWhitespace /\s\+$/
autocmd BufWinLeave * call clearmatches()
highlight SpecialKey ctermfg=1

" Форсируем себя на использование hjkl
inoremap        <Up>    <NOP>
inoremap        <Down>  <NOP>
inoremap        <Left>  <NOP>
inoremap        <Right> <NOP>
noremap         <Down>  <NOP>
noremap         <Left>  <NOP>
noremap         <Right> <NOP>

" AIRLINE PLUGIN SECTION
let g:airline_powerline_fonts = 1   " Включение возможностей powerline шрифтов для vim-airline
let g:airline#extensions#tabline#enabled = 1
let g:airline_detect_modified= 1
let g:airline#extensions#branch#enabled = 1
let g:airline#extensions#branch#empty_message = 'detached'
let g:airline#extensions#whitespace#enabled = 1
let g:airline#extensions#whitespace#show_message = 1
let g:airline#extensions#tabline#enabled = 1

function! AirlineInit()
    let g:airline_section_a = airline#section#create(['mode', ' ', 'foo'])
    let g:airline_section_b = airline#section#create_left(['ffenc','file'])
    let g:airline_section_c = airline#section#create(['%{getcwd()}'])
endfunction
autocmd VimEnter * call AirlineInit()

set background=dark
let g:solarized_termcolors = 256
let g:solarized_visibility = "high"
let g:solarized_contrast = "high"
let g:solarized_termtrans = 1
" Отключить подсветку пробелов 		
let g:solarized_visibility = "low"

colorscheme solarized
" colorscheme molokai

au BufRead,BufNewFile jquery.*.js set ft=javascript syntax=jquery

" Auto indent, tab and spaces
set tabstop=4 softtabstop=0 shiftwidth=4 expandtab
if has("autocmd")
     "Включаем определение типов файлов
     filetype on
     autocmd FileType php setlocal ts=4 sts=4 sw=4 et
     autocmd FileType python setlocal ts=4 sts=4 sw=4 et
     autocmd FileType javascript setlocal ts=4 sts=4 sw=4 et

     autocmd FileType html setlocal ts=2 sts=2 sw=2 et
     autocmd FileType xhtml setlocal ts=2 sts=2 sw=2 et
     autocmd FileType xml setlocal ts=2 sts=2 sw=2 et
     autocmd FileType css setlocal ts=2 sts=2 sw=2 et

     autocmd FileType vim setlocal ts=4 sts=4 sw=4 et
     autocmd FileType apache setlocal ts=2 sts=2 sw=2 et
     autocmd FileType yaml setlocal ts=2 sts=2 sw=2 et

     autocmd BufNewFile,BufRead *.tmpl,*.tpl setfiletype html
endif

set nobackup
set nowritebackup

" Создание тестов
command! RGenerate :execute ':!mkdir -p test/unit/'.expand('%:h').' && touch test/unit/'.expand('%:h').'/'.expand('%:t')
nnoremap <Leader>tg :RGenerate<cr>

command! RTest :execute ':open test/unit/'.expand('%:h').'/'.expand('%:t')
nnoremap <Leader>tgg :RTest<cr>

command! RFile :execute ':open '.substitute(expand('%'), 'test/unit/', '', '')
nnoremap <Leader>tgf :RFile<cr>


map <c-f> :call JsBeautify()<cr>
autocmd FileType javascript noremap <buffer>  <c-f> :call JsBeautify()<cr>
autocmd FileType html noremap <buffer> <c-f> :call HtmlBeautify()<cr>
autocmd FileType css noremap <buffer> <c-f> :call CSSBeautify()<cr>

autocmd FileType javascript vnoremap <buffer>  <c-f> :call RangeJsBeautify()<cr>
autocmd FileType html vnoremap <buffer> <c-f> :call RangeHtmlBeautify()<cr>
autocmd FileType css vnoremap <buffer> <c-f> :call RangeCSSBeautify()<cr>

" Trigger configuration. Do not use <tab> if you use
" https://github.com/Valloric/YouCompleteMe.
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"

" If you want :UltiSnipsEdit to split your window.
" let g:UltiSnipsEditSplit="vertical"


func! GitGrep(...)
  let save = &grepprg
  set grepprg=git\ grep\ -n\ $*
  let s = 'grep'
  for i in a:000
    let s = s . ' ' . i
  endfor
  exe s
  let &grepprg = save
endfun
command! -nargs=? G call GitGrep(<f-args>)

let g:syntastic_javascript_checkers = ['jshint', 'jscs']


nmap <F8> :TagbarToggle<CR>
nmap <Leader>td :TernDef<CR>
