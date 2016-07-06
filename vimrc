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

" Neobundle configuration
if has('vim_starting')
  " Required:
  set runtimepath+=~/vimfiles/bundle/neobundle.vim/
endif

" Required:
call neobundle#begin(expand('~/vimfiles/bundle/'))

" Let NeoBundle manage NeoBundle
NeoBundleFetch 'Shougo/neobundle.vim'

" Some themes
NeoBundle 'chriskempson/base16-vim'
NeoBundle 'sjl/badwolf'
NeoBundle 'altercation/vim-colors-solarized'
" Huge jumbo pack
" NeoBundle 'flazz/vim-colorschemes'

" File types
NeoBundle 'PProvost/vim-ps1'

" Simple utilities
" ----------------
" Move lines up and down (A-J/A-k)
NeoBundle 'matze/vim-move'
" Surroundings - ds,cs,ys
NeoBundle 'tpope/vim-surround'
" Sneak mode - sxy (search for 2 chars)
NeoBundle 'justinmk/vim-sneak'
" Smart parentheses
NeoBundle 'jiangmiao/auto-pairs'
" Auto comment (gc)
NeoBundle 'tpope/vim-commentary'
" Various mappings around [] - Not convinced...
NeoBundle 'tpope/vim-unimpaired'

" Run command and capture output - :Clam
NeoBundle 'https://bitbucket.org/sjl/clam.vim', {'type': 'hg'}

" Undo management
" NeoBundle 'mbbill/undotree'
" NeoBundle 'sjl/gundo.vim'

" File managers
" Fuzzy file search - not used (slow on big directories)
" NeoBundle 'kien/ctrlp.vim'
" Directory viewer window
NeoBundle 'scrooloose/nerdtree'
" Unified selection window (files, buffers, ...) - Too complex?...
NeoBundle 'Shougo/unite.vim'

" Snippet managers
" Needs Python, maybe a bit heavyweight?
" NeoBundle 'SirVer/UltiSnips'
NeoBundle 'Shougo/neosnippet.vim'
NeoBundle 'Shougo/neosnippet-snippets' " Predefined snippets

" Tool integration
NeoBundle 'mileszs/ack.vim'
" NeoBundle 'tpope/vim-fugitive.vim'

" Things still to look at
" - Completion (Shougo/neocomplete.vim)
" - Syntax checker (scrooloose/syntastic)
" - Better status line (vim-airline/vim-airline)
" - Python autocompletion (davidhalter/jedi-vim)

call neobundle#end()

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
    " colorscheme desert
    colorscheme base16-tomorrow-night
    set guioptions-=T
    set guioptions-=L
    set guioptions-=m
    set listchars=tab:»·,eol:¶
    set mousehide
    set keymodel=startsel
end

" Neosnippet configuration
" Personal snippet directory
let g:neosnippet#snippets_directory = "~/vimfiles/snippets"
" Map <TAB> to expand/jump if possible
imap <expr><TAB>
 \ pumvisible() ? "\<C-n>" :
 \ neosnippet#expandable_or_jumpable() ?
 \    "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"
smap <expr><TAB> neosnippet#expandable_or_jumpable() ?
 \ "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"

" ack.vim: Use ag
if executable('ag')
  let g:ackprg = 'ag --vimgrep'
endif

" Personal mappings
map <Leader>df :NERDTree %:p:h<CR>
map <Leader>dc :NERDTree<CR>

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
