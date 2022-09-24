call plug#begin('~/.local/share/nvim/plugged')

Plug 'easymotion/vim-easymotion'
Plug 'scheakur/vim-scheakur'
Plug 'mileszs/ack.vim'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-vinegar'
Plug 'rafi/awesome-vim-colorschemes'
Plug 'slim-template/vim-slim'
Plug 'jparise/vim-graphql'
Plug 'tpope/vim-endwise'
Plug 'jgdavey/vim-blockle'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'gosukiwi/vim-atom-dark'

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

set background=dark

" highlight trailing whitespaces
:autocmd ColorScheme * highlight ExtraWhitespace ctermbg=red guibg=red
:highlight ExtraWhitespace ctermbg=darkgreen guibg=darkgreen
:match ExtraWhitespace /\s\+$/

set termguicolors
" colorscheme afterglow
colorscheme atom-dark

highlight Normal ctermbg=none
highlight NonText ctermbg=none

if !exists( "commands_aliases_inited" )
  let commands_aliases_inited = 1
  command W w
  command Q q
endif

" hotkeys
nmap <C-L> m':Explore %:h<CR>
nmap th :tabfirst<CR>
nmap tk :tabnext<CR>
nmap tj :tabprev<CR>
nmap tl :tablast<CR>
nmap tt :tabedit<CR>
nmap tmh :-tabm<CR>
nmap tml :+tabm<CR>
nmap td :tabclose<CR>
vmap < <gv
vmap > >gv
" copy to system clipboard
vmap '' "+y
map <Leader>ff :let @+=expand('%')<CR>

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
nmap w <Plug>(easymotion-overwin-f)
nmap s <Plug>(easymotion-overwin-f2)
let g:EasyMotion_smartcase = 1
map <Leader>j <Plug>(easymotion-j)
map <Leader>k <Plug>(easymotion-k)

" fzf
map <Leader>t :Files<CR>
map <Leader>b :Buffers<CR>
map <Leader>q :Lines<CR>

" ack
cnoreabbrev Ack Ack!
nnoremap <Leader>a :Ack!<Space>
if executable('rg')
  let g:ackprg = 'rg --vimgrep'
endif

" vim-blockle
let g:blockle_mapping = '<Leader>]'

" automatically start insert mode when using :te[rminal]
autocmd TermOpen * startinsert
