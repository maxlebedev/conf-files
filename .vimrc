set nocompatible
set number
set ruler
syntax enable
set background=dark
set noerrorbells

" disable arrows for navigation
inoremap  <Up>     <NOP>
inoremap  <Down>   <NOP>
inoremap  <Left>   <NOP>
inoremap  <Right>  <NOP>
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
"set smartindent

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
"line. usefuel for line lines taking up multiple rows
:nmap j gj
:nmap k gk

"toggle relative and absolute number line
nnoremap <F3> :NumbersToggle<CR>

"pathogen bundle manager
execute pathogen#infect()

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
set spellfile=$HOME/Dropbox/vim/spell/en.utf-8.add

"this is controvercial but possibly awesome
nnoremap ; :

"alternate window movement
map <c-j> <c-w>j
map <c-k> <c-w>k
map <c-l> <c-w>l
map <c-h> <c-w>h

map <Tab><Tab> <C-W>w

" set cosshairs 
hi CursorLine cterm=NONE ctermbg=DarkGray ctermfg=NONE
hi CursorColumn cterm=NONE ctermbg=DarkGray ctermfg=NONE
nnoremap <Leader>c :set cursorline! cursorcolumn!<CR>

nnoremap Y y$

function! RepeatChar(char, count)
	return repeat(a:char, a:count)
endfunction
nnoremap s :<C-U>exec "normal i".RepeatChar(nr2char(getchar()), v:count1)<CR>
nnoremap S :<C-U>exec "normal a".RepeatChar(nr2char(getchar()), v:count1)<CR>

" move to the end of a paste
" vnoremap <silent> y y`]
" vnoremap <silent> p p`]
" nnoremap <silent> p p`]

" prevent the command line history buffer from happening
map q: :q


