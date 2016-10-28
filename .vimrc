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
nnoremap <Leader>pymain :read $HOME/.vim/snippets/pyboil.py<CR>
nnoremap <Leader>javaclass :read $HOME/.vim/snippets/javaclass.java<CR>2f 
nnoremap <Leader>shboil :read $HOME/.vim/snippets/shboil<CR>

" Because I sometimes use fish
set shell=bash

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

filetype on
filetype plugin on " read all filetype specific plugins. none by default
filetype indent on " automatic indentation

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
nnoremap <leader>p p
nnoremap <leader>P P
nnoremap p p'[v']=
nnoremap P P'[v']=

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

"==================== HERE BE PLUGINS ====================

"pathogen bundle manager. This may be redundant with the line below it
execute pathogen#infect()
" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

Plugin 'Valloric/YouCompleteMe'
Plugin 'vim-airline/vim-airline'
