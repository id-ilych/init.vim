vim.cmd('filetype plugin on')

vim.o.number = true -- show line numbers on the left
vim.o.ruler = true  -- show cursor line and character on the bottom right
vim.o.wrap = false  -- do not wrap lines
vim.o.hlsearch = true   -- highlight search hits
vim.o.incsearch = true  -- search as you input pattern
vim.o.ignorecase = true -- ignore case when searching

-- indentation
vim.o.cindent = true
vim.o.smartindent = true
vim.o.smarttab = true
vim.o.expandtab = true
vim.o.softtabstop = 2
vim.o.tabstop = 2
vim.o.shiftwidth = 2

vim.o.fileencodings = 'utf-8,cp1251'  -- try these when opening wiles
vim.o.fileformat = 'unix'             -- by default use unix end-of-lines
vim.o.fileformats = 'unix,dos'        -- when opening files try these end-of-lines

vim.o.backspace = 'indent,eol,start'  -- do not restrict backspacing when editing

-- show tabs and trailing spaces
vim.o.listchars = 'trail:·,tab:>-'
vim.o.list = true

vim.o.scrolloff = 6       -- number of rcseen lines to keep above and below the cursor
vim.o.virtualedit = 'all' -- allow positioning cursor in areas beyond content
vim.o.cursorline = true   -- show cursor line

vim.o.foldmethod = 'indent' -- form folds by indent
vim.o.foldlevelstart = 20   -- make sure folds are opened on start

vim.o.mouse='' -- disable mouse

-- netrw tweaks
vim.g.netrw_liststyle=0
vim.g.netrw_banner=0
vim.g.netrw_browse_split=0
vim.g.netrw_winsize=32
vim.g.netrw_dirhistmax=0
vim.g.netrw_preview = 1

-- Colemak compensation
-- vim.api.nvim_set_keymap('n', '<C-L>', '<C-U>', { noremap = true })
-- vim.api.nvim_set_keymap('n', '<C-Y>', '<C-O>', { noremap = true })
-- vim.api.nvim_set_keymap('n', '<C-U>', '<C-I>', { noremap = true })
-- vim.api.nvim_set_keymap('n', '<C-P>', '<C-R>', { noremap = true })
-- vim.api.nvim_set_keymap('n', '<C-S>', '<C-D>', { noremap = true })
-- vim.o.langmap="dg,ek,fe,gt,il,jy,kn,lu,nj,pr,rs,sd,tf,ui,yo,o\\;,\\;p,DG,EK,FE,GT,IL,JY,KN,LU,NJ,PR,RS,SD,TF,UI,YO,O:,:P"

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  'easymotion/vim-easymotion',
  'mileszs/ack.vim',
  'tpope/vim-surround',
  'tpope/vim-repeat',
  'tpope/vim-vinegar',

  'slim-template/vim-slim',
  'jparise/vim-graphql',
  'tpope/vim-endwise',

  { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
  { 'nvim-telescope/telescope.nvim', tag = '0.1.6', dependencies = { 'nvim-lua/plenary.nvim' } },

  'rafi/awesome-vim-colorschemes',
  'Arkham/vim-tango',

  'github/copilot.vim',
})

local telescope = require('telescope')
telescope.setup{}
telescope.load_extension('fzf')

vim.o.termguicolors = true
if os.getenv('NEOVIM_DARK') or os.getenv('NVIM_DARK')  then
  vim.o.background = 'dark'
  vim.cmd('colorscheme tango')
else
  vim.o.background = 'light'
  vim.cmd('colorscheme github')
end

-- vim.cmd('highlight Normal ctermbg=none')
-- vim.cmd('highlight NonText ctermbg=none')

vim.cmd('command! W w')
vim.cmd('command! Q q')

-- set leader key
vim.api.nvim_set_keymap('n', '<SPACE>', '<Nop>', { noremap = true })
vim.g.mapleader = ' '

-- tabs hotkeys
vim.api.nvim_set_keymap('n', '<Leader>d', ':tabprev<CR>', {})
vim.api.nvim_set_keymap('n', '<Leader>f', ':tabnext<CR>', {})
vim.api.nvim_set_keymap('n', '<Leader>n', ':tabedit<CR>', {})
vim.api.nvim_set_keymap('n', '<Leader>md', ':-tabm<CR>', {})
vim.api.nvim_set_keymap('n', '<Leader>mf', ':+tabm<CR>', {})
vim.api.nvim_set_keymap('n', '<Leader>mm', ':tabclose<CR>', {})

-- preserve visual selection when (un)indenting
vim.api.nvim_set_keymap('v', '<', '<gv', {})
vim.api.nvim_set_keymap('v', '>', '>gv', {})

-- clipboard
-- copy selection to system clipboard
vim.api.nvim_set_keymap('v', "''", '"+y', {})
-- copy current filename to the system clipboard
vim.api.nvim_set_keymap('n', '<Leader>c', ":let @+=expand('%')<CR>", {})
-- copy current filename:line to the system clipboard
vim.api.nvim_set_keymap('n', '<Leader>x', ":let @+=expand('%') . ':' . line('.')<CR>", {})

-- do not overwrite default buffer on paste
vim.api.nvim_set_keymap('x', 'p', 'pgvy', { noremap = true })

-- split pane
vim.api.nvim_set_keymap('n', '<Leader>v', ':vsplit<CR>', {})
vim.api.nvim_set_keymap('n', '<Leader>h', ':split<CR>', {})

-- stop highligting search matches by Esc
vim.api.nvim_set_keymap('n', '<esc>', ':noh<return><esc>', { noremap = true })

-- easymotion
vim.g.EasyMotion_do_mapping = 0 -- Disable default mappings
-- nmap w <Plug>(easymotion-overwin-f)
vim.api.nvim_set_keymap('n', '<Leader>s', '<Plug>(easymotion-overwin-f2)', {})
vim.g.EasyMotion_smartcase = 1
vim.api.nvim_set_keymap('n', '<Leader>j', '<Plug>(easymotion-j)', {})
vim.api.nvim_set_keymap('n', '<Leader>k', '<Plug>(easymotion-k)', {})

-- Telescope
vim.api.nvim_set_keymap('n', '<Leader>l', ':Telescope find_files<CR>', {})
vim.api.nvim_set_keymap('n', '<Leader>b', ':Telescope buffers<CR>', {})
vim.api.nvim_set_keymap('n', '<Leader>;', ':Telescope live_grep<CR>', {})

-- ack
-- start searching for text with reasonable defaults:
--   -F flag that disables regexp
--   add quotes to search for multiple words
vim.api.nvim_set_keymap('n', '<Leader>a', ":Ack!<Space>-F<Space>''<Left>", { noremap = true })
-- use rg if it is available
if vim.fn.executable('rg') == 1 then
  vim.g.ackprg = 'rg --vimgrep'
end

--- automatically open quick-fix pane after make if there are errors, close it otherwise
vim.api.nvim_create_autocmd({'QuickFixCmdPost'}, {
  pattern = {'*.c', '*.cpp', '*.h', '*.hpp', 'Makefile'},
  command = 'botright cw | wincmd p'
})

-- Copilot hotkeys (by default the suggestion is accepted by <Tab> which is annoying when I just want to indent)
vim.keymap.set('i', '<C-J>', 'copilot#Accept("\\<CR>")', {
  expr = true,
  replace_keycodes = false
})
vim.g.copilot_no_tab_map = true

