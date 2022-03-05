syntax on

set noerrorbells
set tabstop=2 softtabstop=2
set shiftwidth=2
set expandtab
set smartindent
set nu
set nowrap
set smartcase
set noswapfile
set nobackup
set undodir=~/.vim/undodir
set undofile
set incsearch
set relativenumber number
set autochdir
set pastetoggle=<F3>

set colorcolumn=120
highlight ColorColumn ctermbg=0 guibg=lightgrey

imap jj <Esc>
imap kk <Esc>

call plug#begin('~/.vim/plugged')
    Plug 'gruvbox-community/gruvbox'
    Plug 'luisiacc/gruvbox-baby'
    Plug 'jremmen/vim-ripgrep'
    Plug 'tpope/vim-fugitive'
    Plug 'leafgarland/typescript-vim'
    Plug 'vim-utils/vim-man'
    Plug 'lyuts/vim-rtags'
    Plug 'git@github.com:kien/ctrlp.vim.git'
    Plug 'git@github.com:Valloric/YouCompleteMe.git'
    Plug 'mbbill/undotree'
    Plug 'shime/vim-livedown'
    Plug 'leafOfTree/vim-vue-plugin'
    Plug 'w0rp/ale'
call plug#end()

colorscheme gruvbox
set background=dark

if executable('rg')
  let g:rg_derive_root='true'
endif

let g:ctrlp_user_command = ['.git/', 'git --git-dir=%s/.git ls-files -oc --exclude-standard']
let mapleader = " "
let g:netrw_browser_split=2
let g:netrw_banner = 0
let g:netrw_winsize = 25
let g:ctrlp_use_caching = 0

nnoremap <leader>h :wincmd h<CR>
nnoremap <leader>j :wincmd j<CR>
nnoremap <leader>k :wincmd k<CR>
nnoremap <leader>l :wincmd l<CR>
nnoremap <leader>ec :e ~/Codes/alarita/.dotfiles/vim/.vimrc<CR>
nnoremap <leader>u :UndotreeShow<CR>
nnoremap <leader>pv :wincmd v<bar> :Ex <bar> :vertical resize 30<CR>
nnoremap <Leader>ps :Rg<SPACE>
nnoremap <silent> <Leader>+ :vertical resize +5<CR>
nnoremap <silent> <Leader>- :vertical resize -5<CR>

nnoremap <silent> <Leader>gd :YcmCompleter GoTo<CR>
nnoremap <silent> <Leader>gf :YcmCompleter FixIt<CR>

" Switch between buffers
nnoremap <F5> :buffers<CR>:buffer<Space>

" Tooggle centering
nnoremap <Leader>zz :let &scrolloff=999-&scrolloff<CR>

" Run npm run test
nnoremap <Leader>tt :!npm run test<CR>

" Set ESLint as your plugging manager
let g:ale_fixers = {
 \ 'javascript': ['eslint']
 \ }

let g:ale_sign_error = '❌'
let g:ale_sign_warning = '⚠️'
let g:ale_fix_on_save = 1

