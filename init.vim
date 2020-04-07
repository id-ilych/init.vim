call plug#begin('~/.local/share/nvim/plugged')

Plug 'easymotion/vim-easymotion'
Plug 'wincent/command-t', {'do': 'cd ruby/command-t/ext/command-t && ruby extconf.rb && make'}
Plug 'scheakur/vim-scheakur'
Plug 'mileszs/ack.vim'
Plug 'tpope/vim-surround'

call plug#end()

syntax on
set nocompatible
filetype plugin on
set number
set ruler
set hlsearch
set incsearch
set ignorecase
set cindent
set smartindent
set smarttab
set expandtab
set softtabstop=4
set tabstop=4
set shiftwidth=4
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
let g:netrw_liststyle=0
let g:netrw_banner=0
let g:netrw_browse_split=0
let g:netrw_winsize=32
let g:netrw_dirhistmax=0

set background=light
colorscheme scheakur

if !exists( "commands_aliases_inited" )
  let commands_aliases_inited = 1
  command W w
endif

" hotkeys
nmap <C-L> :Explore<CR>
nmap th :tabfirst<CR>
nmap tk :tabprev<CR>
nmap tj :tabnext<CR>
nmap tl :tablast<CR>
nmap tt :tabedit<CR>
nmap tm :tabm<CR>
nmap td :tabclose<CR>
vmap < <gv
vmap > >gv

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

" easymotion
let g:EasyMotion_do_mapping = 0 " Disable default mappings
nmap s <Plug>(easymotion-overwin-f2)
let g:EasyMotion_smartcase = 1
map <Leader>j <Plug>(easymotion-j)
map <Leader>k <Plug>(easymotion-k)

" command-t
let g:CommandTFileScanner = 'git'

" ack
cnoreabbrev Ack Ack!
nnoremap <Leader>a :Ack!<Space>
if executable('rg')
  let g:ackprg = 'rg --vimgrep'
endif

