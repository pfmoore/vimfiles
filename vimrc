" vim: set et tw=0:
" My Vim configuration

" We're vim, not vi!
set nocompatible

" Use UTF8 as the default encoding, as this handles
" the full Unicode character set. Note that latin1
" files will still have their encoding preserved.
set encoding=utf-8

" Use <SPACE> as the leader. Needs to be at the top, before any mappings.
let mapleader=" "

call plug#begin()

" Some themes
Plug 'chriskempson/base16-vim'
" Plug 'sjl/badwolf'
" Plug 'altercation/vim-colors-solarized'
" Huge jumbo pack
" Plug 'flazz/vim-colorschemes'

" File types
Plug 'PProvost/vim-ps1'

" Simple utilities
" ----------------
" Move lines up and down (A-J/A-k)
Plug 'matze/vim-move'
" Surroundings - ds,cs,ys
Plug 'tpope/vim-surround'
" Sneak mode - sxy (search for 2 chars)
Plug 'justinmk/vim-sneak'
" Smart parentheses
Plug 'jiangmiao/auto-pairs'
" Auto comment (gc)
Plug 'tpope/vim-commentary'
" Various mappings around [] - Removed, too intrusive
" Plug 'tpope/vim-unimpaired'

" Run command and capture output - :Clam
Plug 'sjl/clam.vim'

" Undo management
" Plug 'mbbill/undotree'
" Plug 'sjl/gundo.vim'

" File managers
" Fuzzy file search - not used (slow on big directories)
" Plug 'kien/ctrlp.vim'
" Directory viewer window
Plug 'scrooloose/nerdtree', { 'on': 'NERDTree' }
" Unified selection window (files, buffers, ...) - Too complex?...
" Plug 'Shougo/unite.vim'

" Snippet managers
Plug 'SirVer/UltiSnips'
" Plug 'Shougo/neosnippet.vim'
" Plug 'Shougo/neosnippet-snippets' " Predefined snippets

" Tool integration
Plug 'mileszs/ack.vim'
Plug 'tpope/vim-fugitive' " Being tested

" Temporary additions being tried out.
" Remove and PlugClean at any time to remove them.
"Plug 'junegunn/goyo.vim'
Plug 'junegunn/vim-easy-align'
"Plug 'junegunn/vim-emoji'
Plug 'junegunn/vim-peekaboo'
Plug 'mtth/scratch.vim'

" Things still to look at
" - Completion (Shougo/neocomplete.vim)
" - Syntax checker (scrooloose/syntastic)
" - Better status line (vim-airline/vim-airline)
" - Python autocompletion (davidhalter/jedi-vim)
Plug 'davidhalter/jedi-vim' " Being tested
" - Multiple Cursors (terryma/vim-multiple-cursors)

call plug#end()

" Required:
filetype plugin indent on

if !has('vim_starting')
  " Call on_source hook when reloading .vimrc.
  call neobundle#call_hook('on_source')
endif

" General settings
set nowrap        " Horizontal scrolling rather than displaying lines wrapped
set showmatch     " Flash on matching brackets
set dir=$TEMP     " always save swap files to the temp dir
"set exrc          " read a local .vimrc file

" Indenting text
" Syntax-based indentation (indentexpr) is usually used.
" This is for plain text.
set autoindent      " Auto-indent new lines

" Search behaviour
set ignorecase          " don't worry about case when matching...
set smartcase           " unless the search string contains capitals

" Completion menu
set wildmenu            " Show a menu when completing on the command line

" Don't require a save when switching buffers
set hidden              " Hide buffers rather than unloading them

" Line numbers (relative)
set number
set relativenumber

" Show the current line
set cursorline

" Indentation and tabs
set shiftwidth=4        " indents each 4 characters
set smarttab            " tabs at start of line indent
set expandtab           " tabs are expanded to spaces

" Cursor movement
set nostartofline              " Don't jump to start of line
set backspace=indent,eol,start " allow backspacing over everything in insert mode
set whichwrap=b,s,<,>,[,]      " allow arrow keys etc to wrap over line ends

" Backup files
set nobackup            " do not keep a backup file
set nowritebackup       " do not write a backup file at all
set backupdir=.,$TEMP   " backup files go to current dir or windows temp

" We don't want Ctrl-A and Ctrl-X to assume octal if there's a leading zero
set nrformats-=octal

set complete=.,w,b,u,i  " Insert-completion
set suffixes+=.orig     " Complete on these files last

set clipboard=unnamed   " Make yanks go to the clipboard by default
set winaltkeys=no       " Don't use alt for menu items, free them for maps

set printfont=Courier_New:h8
set printoptions=syntax:n " Don't use syntax highlighting

" Keep viminfo, but put it in the temp dir (it's not that critical)
set viminfo+=n$TEMP/_viminfo

" Enable syntax highlighting and filetype detection
syntax on
syntax sync fromstart
filetype plugin indent on

" There is no need for a separate gvimrc file...
if has('gui_running')
    set guifont=Source_Code_Pro:h12,DejaVu_Sans_Mono:h12,Consolas:h12,Courier_New:h12
    set background=dark
    " Set colour scheme, fall back to built in 'desert' scheme
    try
        colorscheme base16-tomorrow-night
    catch /E185/
        colorscheme desert
    endtry
    set guioptions-=T
    set guioptions-=L
    set guioptions-=m
    set listchars=tab:»·,eol:¶
    set mousehide
    set keymodel=startsel
end

" Personal snippet directory
let g:UltiSnipsSnippetsDir = "~/vimfiles/ultisnips"

" ack.vim: Use ag
if executable('ag')
  let g:ackprg = 'ag --vimgrep'
endif

" Run the current buffer through Python
command -range=% PP <line1>,<line2>Clam python

" Personal mappings
map <Leader>df :NERDTree %:p:h<CR>
map <Leader>dc :NERDTree<CR>
map <Leader>fc :e $MYVIMRC<CR>

" Move through buffers (from "But She's a Girl)
nmap <Leader><Left> :bp<CR>
nmap <Leader><Right> :bn<CR>

" Diffsplit this buffer vs the on-disk copy.
" Could also do this by loading the on-disk version into a new scratch
" buffer (how? :0r is the best, I think...) and then doing :diffthis
" on both buffers...
" function! DiffThis()
"     " Autowrite no longer affects us, as we're using system() not :!
"     "let local_aw = &aw
"     "set noaw
"     let temp = tempname()
"     " OS-dependent, sadly...
"     call system("copy " . expand("%") . " " . temp)
"     exe "silent vert diffsplit " . temp
"     " Set the temporary file buffer to be a scratch buffer
"     silent file Original-Contents
"     set buftype=nofile
"     " Delete the temporary file
"     call delete(temp)
"     "let &aw = local_aw
" endfunction
" command! DT call DiffThis()
