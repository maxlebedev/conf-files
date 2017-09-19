set nocompatible
set number
set ruler
syntax enable
set background=dark
set noerrorbells

" for find and such
set path+=**

" use tags: ctrl+] to jump to tag, prepend g for ambig, ctrl+t to jump back
command! MakeTags !ctags -R .
nnoremap <Leader>] g<C-]> 
nnoremap <Leader>[ <C-t>

" insert language boilerplate
nnoremap <Leader>pdb  :read $HOME/.vim/snippets/pdb.py<ESC>
nnoremap <Leader>pymain :read $HOME/.vim/snippets/pyboil.py<CR>
nnoremap <Leader>javaclass :read $HOME/.vim/snippets/javaclass.java<CR>2f 
nnoremap <Leader>shboil :read $HOME/.vim/snippets/shboil<CR>

" Because I sometimes use fish
set shell=bash
noremap <C-d> :sh<cr>

set encoding=utf-8

" disable arrows for navigation
"inoremap  <Up>     <NOP>
"inoremap  <Down>   <NOP>
"inoremap  <Left>   <NOP>
"inoremap  <Right>  <NOP>
noremap   <Up>     <NOP>
noremap   <Down>   <NOP>
noremap   <Left>   <NOP>
noremap   <Right>  <NOP>

"autocomplete for commands
set wildmode=longest:full
set wildmenu

"search settings
set ignorecase
set hlsearch
set incsearch
set smartcase

set title

set hidden
set wrapscan

set stl=%f\ %m\ %r\ Line:\ %l/%L[%p%%]\ Col:\ %c\ Buf:\ #%n\ [%b][0x%B]
set mousehide
set scrolloff=8

set history=1000 
set undolevels=1000  

"Cursor should move up/down a single row on the screen rather than to the next
"line. useful for line lines taking up multiple rows
:nmap j gj
:nmap k gk

"toggle relative and absolute number line
nnoremap <F3> : set rnu!<CR>

" w! sudo saves
cmap w!! w !sudo tee % >/dev/null

" Automatically re-indent on paste
" http://www.reddit.com/r/vim/comments/pkwkm/awesome_little_tweak_automatically_reindent_on/
" nnoremap <leader>p p
" nnoremap <leader>P P
" nnoremap p p'[v']=
" nnoremap P P'[v']=

" Breaking lines with \[enter] without having to go to insert mode (myself).
nmap <leader><cr> i<cr><Esc>

"spelling
set spelllang=en

"this is controversial but possibly awesome
nnoremap ; :

"alternate window movement
map <c-j> <c-w>j
map <c-k> <c-w>k
map <c-l> <c-w>l
map <c-h> <c-w>h

" consider givingTabTab to something better
map <Tab><Tab> <C-W>w

" set crosshairs 
hi CursorLine cterm=NONE ctermbg=DarkGray ctermfg=NONE
hi CursorColumn cterm=NONE ctermbg=DarkGray ctermfg=NONE
nnoremap <Leader>c :set cursorline! cursorcolumn!<CR>

nnoremap Y y$

"this function replaces s with a single insert
function! RepeatChar(char, count)
	return repeat(a:char, a:count)
endfunction
nnoremap s :<C-U>exec "normal i".RepeatChar(nr2char(getchar()), v:count1)<CR>
nnoremap S :<C-U>exec "normal a".RepeatChar(nr2char(getchar()), v:count1)<CR>

" prevent the command line history buffer from happening
" map q: :q

"this turns on autocompletion
set omnifunc=syntaxcomplete#Complete
"and use a non-emacs style shortcut for it. 
inoremap <S-Tab> <C-x><C-o>

set laststatus=2 "this turns the status line on by default

" provide some sort of alternative to ESC
:inoremap jj <ESC>

"==================== HERE BE PLUGINS ====================

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

" The following are examples of different formats supported.
" Keep Plugin commands between vundle#begin/end.
" plugin on GitHub repo
" plugin from http://vim-scripts.org/vim/scripts.html
" Plugin 'L9'
" Git plugin not hosted on GitHub
" Plugin 'git://git.wincent.com/command-t.git'
" git repos on your local machine (i.e. when working on your own plugin)
"Plugin 'file:///home/gmarik/path/to/plugin'
" The sparkup vim script is in a subdirectory of this repo called vim.
" Pass the path to set the runtimepath properly.
"Plugin 'rstacruz/sparkup', {'rtp': 'vim/'}
" Install L9 and avoid a Naming conflict if you've already installed a
" different version somewhere else.
" Plugin 'ascenator/L9', {'name': 'newL9'}

 "Plugin 'andviro/flake8-vim' "works
 "Plugin 'vim-scripts/Conque-Shell' "doesntwork
" Plugin 'Valloric/YouCompleteMe'
" Plugin 'tpope/vim-fugitive' #turning off for now
Plugin 'vim-airline/vim-airline'
" Plugin 'davidhalter/jedi-vim' " ome thigns are really slow//broken
Plugin 'vim-scripts/indentpython.vim'

Plugin 'scrooloose/syntastic'
 " configuring syntastic?
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_html_tidy_ignore_errors = [ '> proprietary attribute "' ]
let g:syntastic_loc_list_height = 5
let g:syntastic_auto_loc_list = 0
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 1
" let g:syntastic_javascript_checkers = ['eslint']
let g:syntastic_javascript_checkers = ['jshint']


let g:syntastic_error_symbol = '❌'
let g:syntastic_warning_symbol = '⚠️'
let g:syntastic_style_error_symbol = '💩'
let g:syntastic_style_warning_symbol = '👉'
highlight link SyntasticErrorSign SignColumn
highlight link SyntasticWarningSign SignColumn
highlight link SyntasticStyleErrorSign SignColumn
highlight link SyntasticStyleWarningSign SignColumn

" Plugin 'vim-scripts/Conque-Shell'
Plugin 'rosenfeld/conque-term'
" quick access to ConqueTerm
nnoremap cv :ConqueTermVSplit bash<CR>
nnoremap cs :ConqueTermSplit bash<CR>

Plugin 'Shougo/vimproc.vim'
Plugin 'Shougo/vimshell.vim'
" TODO: Still need to mess around with this

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line

filetype indent plugin on " read all filetype specific plugins. none by default automatic indentation

" virtual tabstops using spaces ermergerd this better work
set shiftwidth=4
set softtabstop=4
set expandtab ts=4 sw=4 ai
" As suggested by PEP8.
setlocal expandtab shiftwidth=4 softtabstop=4 tabstop=8
" allow toggling between local and default mode
set smartindent

" not convinced that this works
let g:airline#extensions#default#section_truncate_width = {
            \ 'b': 150,
            \ 'c': 10,
            \ 'y': 150,
            \ }

" indicate this is the window to swap to
function! MarkWindowSwap()
    let g:markedWinNum = winnr()
endfunction

function! DoWindowSwap()
    "Mark destination
    let curNum = winnr()
    let curBuf = bufnr( "%" )
    exe g:markedWinNum . "wincmd w"
    "Switch to source and shuffle dest->source
    let markedBuf = bufnr( "%" )
    "Hide and open so that we aren't prompted and keep history
    exe 'hide buf' curBuf
    "Switch to dest and shuffle source->dest
    exe curNum . "wincmd w"
    "Hide and open so that we aren't prompted and keep history
    exe 'hide buf' markedBuf 
endfunction

nmap <silent> <leader>q :call MarkWindowSwap()<CR>
nmap <silent> <leader>w :call DoWindowSwap()<CR>

"search for selected text
vnoremap // y/<C-R>"<CR> 
