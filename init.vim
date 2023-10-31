call plug#begin('~/.local/share/nvim/plugged')

Plug 'easymotion/vim-easymotion'
Plug 'mileszs/ack.vim'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-vinegar'

Plug 'slim-template/vim-slim'
Plug 'jparise/vim-graphql'
Plug 'tpope/vim-endwise'
Plug 'jgdavey/vim-blockle'

Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

Plug 'rafi/awesome-vim-colorschemes'

call plug#end()

syntax on
set nocompatible
filetype plugin on
set number
set ruler
set nowrap
set hlsearch
set incsearch
set ignorecase
set cindent
set smartindent
set smarttab
set expandtab
set softtabstop=2
set tabstop=2
set shiftwidth=2
set imsearch=0
set iminsert=0
set encoding=utf-8
set fileencodings=utf-8,cp1251
set fileformat=unix
set fileformats=unix,dos
set backspace=indent,eol,start
set listchars=trail:·,tab:>-
set list
set wildmenu
set scrolloff=6
set formatoptions-=o
set virtualedit=all
set cursorline
set foldmethod=indent
set foldlevelstart=20
let g:netrw_liststyle=0
let g:netrw_banner=0
let g:netrw_browse_split=0
let g:netrw_winsize=32
let g:netrw_dirhistmax=0
let g:netrw_preview = 1

set background=light

" highlight trailing whitespaces
:autocmd ColorScheme * highlight ExtraWhitespace ctermbg=red guibg=red
:highlight ExtraWhitespace ctermbg=darkgreen guibg=darkgreen
:match ExtraWhitespace /\s\+$/

set termguicolors
colorscheme github

highlight Normal ctermbg=none
highlight NonText ctermbg=none

if !exists( "commands_aliases_inited" )
  let commands_aliases_inited = 1
  command W w
  command Q q
endif

" hotkeys
nnoremap <SPACE> <Nop>
let mapleader=" "
nmap <Leader>d :tabprev<CR>
nmap <Leader>f :tabnext<CR>
nmap <Leader>n :tabedit<CR>
nmap <Leader>md :-tabm<CR>
nmap <Leader>mf :+tabm<CR>
nmap <Leader>mm :tabclose<CR>
vmap < <gv
vmap > >gv

" clipboard
" copy selection to system clipboard
vmap '' "+y
" copy current filename to the system clipboard
nmap <Leader>c :let @+=expand('%')<CR>
" copy current filename:line to the system clipboard
nmap <Leader>x :let @+=expand('%') . ':' . line('.')<CR>

" search with */# for selected text
vnoremap <silent> * :<C-U>
  \let old_reg=getreg('"')<Bar>let old_regtype=getregtype('"')<CR>
  \gvy/<C-R><C-R>=substitute(
  \escape(@", '/\.*$^~['), '\_s\+', '\\_s\\+', 'g')<CR><CR>
  \gV:call setreg('"', old_reg, old_regtype)<CR>

vnoremap <silent> # :<C-U>
  \let old_reg=getreg('"')<Bar>let old_regtype=getregtype('"')<CR>
  \gvy?<C-R><C-R>=substitute(
  \escape(@", '?\.*$^~['), '\_s\+', '\\_s\\+', 'g')<CR><CR>
  \gV:call setreg('"', old_reg, old_regtype)<CR>

" do not overwrite default buffer on paste
xnoremap p pgvy

" easymotion
let g:EasyMotion_do_mapping = 0 " Disable default mappings
" nmap w <Plug>(easymotion-overwin-f)
nmap <Leader><Leader>f <Plug>(easymotion-overwin-f2)
let g:EasyMotion_smartcase = 1
nmap <Leader>j <Plug>(easymotion-j)
nmap <Leader>k <Plug>(easymotion-k)

" fzf
nmap <Leader>p :Files<CR>
nmap <Leader>b :Buffers<CR>
nmap <Leader>l :Lines<CR>

" ack
" start searching for text with reasonable defaults:
"   -F flag that disables regexp
"   add quotes to search for multiple words
nnoremap <Leader>a :Ack!<Space>-F<Space>''<Left>
" use rg if it is available
if executable('rg')
  let g:ackprg = 'rg --vimgrep'
endif

" vim-blockle
let g:blockle_mapping = '<Leader>]'

" automatically start insert mode when using :te[rminal]
autocmd TermOpen * startinsert

" configure jq as JSON formatter
autocmd FileType json set formatprg=jq

" colemak compensation
nmap <C-S> <C-D>
nmap <C-L> <C-U>
nmap <C-Y> <C-O>
nmap <C-U> <C-I>
set langmap=dg,ek,fe,gt,il,jy,kn,lu,nj,pr,rs,sd,tf,ui,yo,o\\;,\\;p,DG,EK,FE,GT,IL,JY,KN,LU,NJ,PR,RS,SD,TF,UI,YO,O:,:P

