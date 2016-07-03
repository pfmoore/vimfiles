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

" Source a file relative to this one
"source <sfile>:p:h/test.vim

" Pathogen
"let g:pathogen_disabled = []
"call pathogen#infect()

" Neobundle configuration
if has('vim_starting')
  " Required:
  set runtimepath+=~/vimfiles/bundle/neobundle.vim/
endif

" Required:
call neobundle#rc(expand('~/vimfiles/bundle/'))

" Let NeoBundle manage NeoBundle
" Required:
NeoBundleFetch 'Shougo/neobundle.vim'

" My Bundles here:
NeoBundle 'mbbill/undotree'
NeoBundle 'chriskempson/base16-vim'
NeoBundle 'PProvost/vim-ps1'
NeoBundle 'tpope/vim-surround'
NeoBundle 'altercation/vim-colors-solarized'
NeoBundle 'kien/ctrlp.vim'
NeoBundle 'https://bitbucket.org/sjl/clam.vim', {'type': 'hg'}

NeoBundle 'matze/vim-move'
NeoBundle 'scrooloose/nerdtree'
NeoBundle 'SirVer/UltiSnips'
NeoBundle 'mileszs/ack.vim'

" NeoBundle 'Shougo/neosnippet.vim'
" NeoBundle 'Shougo/neosnippet-snippets.vim'
" NeoBundle 'tpope/vim-fugitive.vim'
" NeoBundle 'kien/ctrlp.vim'
" NeoBundle 'flazz/vim-colorschemes'

" Required:
filetype plugin indent on

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
filetype plugin indent on

" There is no need for a separate gvimrc file...
if has('gui_running')
    set guifont=DejaVu_Sans_Mono:h12,Consolas:h12,Courier_New:h12
    set background=dark
    " colorscheme desert
    colorscheme base16-tomorrow
    set guioptions-=T
    set guioptions-=L
    set guioptions-=m
    set listchars=tab:»·,eol:¶
    set mousehide
    set keymodel=startsel
end

" UltiSnips: Put snippets in ~/vimfiles/UltiSnips by default
let g:UltiSnipsSnippetsDir = "~/vimfiles/UltiSnips"

" ack.vim: Use ag
if executable('ag')
  let g:ackprg = 'ag --vimgrep'
endif

" Personal mappings
map <Leader>df :NERDTree %:p:h<CR>
map <Leader>dc :NERDTree<CR>

" Invoke the Solarized ToggleBG plugin
"call togglebg#map("")

" Nice mappings

" Move through buffers (from "But She's a Girl)
"nmap <A-Left> :bp<CR>
"nmap <A-Right> :bn<CR>
" Make dot go back to start (from "But She's a Girl)
"nmap . .`[

" S-F1: Toggle and report hlsearch setting
"map <S-F1> :set hls!<cr><bar>:echo "HLSearch: " . strpart("OffOn",3*&hlsearch,3)<cr>
"map <F8> :echo synIDattr(synID(line("."),col("."),1),"name")<CR>
"map <F9> :call HiDiHi()<CR>
"function! HiDiHi()
"    echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<' . synIDattr(synID(line("."),col("."),0),"name") . "> lo<" . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"
"endfunction

" Create a diff between the current contents of the buffer
" and the version on disk
"nmap <F10> :w !diff -w -B -c5 -p - % >tmp.diff<CR>:sp tmp.diff<CR>

" Autozoom
" For autozoom, just set wh=999
" A macro to toggle autozoom is a bit harder:
" Note: Capitalisation of g:az affects whether it gets saved in VIMINFO or
" session files - see :help internal-variables.
"function! AZ()
"   let temp = &wh
"   let &wh = g:az
"   let g:az = temp
"endfunction
"let g:az = 999
"map ,az :call AZ()<cr>
"
"Some useful commands
"Tidy up XML
" :%!xmllint --format -

" make < and > in v mode keep highlighting
"vmap > >gv
"vmap < <gv

" Edit Vim configuration files
" function! EV(bang, file)
"     if a:file == ""
"         exec "e" . a:bang . ' $VIM\_vimrc'
"     elseif a:file == "g"
"         exec "e" . a:bang . ' $VIM\_gvimrc'
"     else
"         exec "e" . a:bang . ' $VIM\' . a:file
"     endif
" endfunction
" command! -nargs=? -bang EV call EV(<q-bang>, <q-args>)

" User defined commands - examples for now
" command! Ddel +,$d
" command! -nargs=1 -bang -complete=file Rename f <args>|w<bang>
" function! Allbuf(command)
"    let l:i = 1
"    while l:i <= bufnr("$")
"       if bufexists(l:i)
"          execute 'buffer '.l:i
"          execute a:command
"       endif
"       let l:i = l:i + 1
"    endwhile
" endfunction
" command! -nargs=+ Allbuf call Allbuf(<q-args>)

" F11 to maximise the window
"nnoremap <F11> :simalt ~x<CR>

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

" Indent-based folding "like I'd expect it"
" :set foldexpr='>'.(indent(v:lnum)/&sw+1)
