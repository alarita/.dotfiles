syntax on

set encoding=utf-8
set laststatus=2
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
set nowritebackup
" set undodir=~/.vim/undodir
set undofile
set incsearch
set relativenumber number
set pastetoggle=<F3>
set noshowmode

set colorcolumn=120
highlight ColorColumn ctermbg=0 guibg=lightgrey

imap jj <Esc>
imap kk <Esc>

call plug#begin('~/.vim/plugged')
    Plug 'https://github.com/ycm-core/YouCompleteMe'
    Plug 'gruvbox-community/gruvbox'
    Plug 'luisiacc/gruvbox-baby', {'branch': 'main'}
    Plug 'jremmen/vim-ripgrep'
    Plug 'tpope/vim-fugitive'
    Plug 'leafgarland/typescript-vim'
    Plug 'vim-utils/vim-man'
    Plug 'git@github.com:kien/ctrlp.vim.git'
    Plug 'mbbill/undotree'
    Plug 'shime/vim-livedown'
    Plug 'leafOfTree/vim-vue-plugin'
    Plug 'w0rp/ale'
    Plug 'tpope/vim-surround'
    Plug 'preservim/nerdtree'
    Plug 'vim-syntastic/syntastic'
    Plug 'tpope/vim-commentary'
    Plug 'itchyny/lightline.vim'
    Plug 'miyakogi/conoline.vim'
    Plug 'heavenshell/vim-jsdoc', {
        \ 'for': ['javascript', 'javascript.jsx','typescript'],
        \ 'do': 'make install'
      \}
    Plug 'acro5piano/import-js-from-history'
call plug#end()

" Load the colorscheme
colorscheme gruvbox
set background=dark

if executable('rg')
  let g:rg_derive_root='true'
endif

set wildignore+=*/tmp/*,*.so,*.swp,*.zip     " MacOSX/Linux
set wildignore+=*\\tmp\\*,*.swp,*.zip,*.exe  " Windows

let mapleader = " "
let g:netrw_browser_split=2
let g:netrw_banner = 0
let g:netrw_winsize = 25
let g:ctrlp_use_caching = 0
let g:conoline_auto_enable = 1
let g:ctrlp_working_path_mode = 'ra'
set wildignore+=*/tmp/*,*.so,*.swp,*.zip     " Linux/MacOSX
set runtimepath^=~/.vim/bundle/ctrlp.vim
let g:ctrlp_user_command = {
	\ 'types': {
		\ 1: ['.git', 'cd %s && git ls-files'],
		\ 2: ['.hg', 'hg --cwd %s locate -I .'],
		\ },
	\ 'fallback': 'find %s -type f'
	\ }

nnoremap <leader>h :wincmd h<CR>
nnoremap <leader>j :wincmd j<CR>
nnoremap <leader>k :wincmd k<CR>
nnoremap <leader>l :wincmd l<CR>
nnoremap <leader>ww :w<CR>
nnoremap <leader>cw :only<CR>
nnoremap <leader>ec :e ~/Codes/alarita/.dotfiles/vim/.vimrc<CR>
nnoremap <leader>u :UndotreeShow<CR>
nnoremap <leader>pv :wincmd v<bar> :Ex <bar> :vertical resize 30<CR>
nnoremap <Leader>ps :Rg<SPACE>
nnoremap <silent> <Leader>+ :vertical resize +5<CR>
nnoremap <silent> <Leader>- :vertical resize -5<CR>
nnoremap <silent> <Leader>tn :set nu! rnu!<CR>

" Import JS
nnoremap <Leader>ij :ImportJs<CR>

nmap <silent> <C-l> <Plug>(jsdoc)

nnoremap <silent> <Leader>gd :YcmCompleter GoTo<CR>
nnoremap <silent> <Leader>gf :YcmCompleter FixIt<CR>
nnoremap <silent> <Leader>gr :YcmCompleter GoToReferences<CR>

" NerdTree Mapping
nnoremap <leader>n :NERDTreeFocus<CR>
nnoremap <C-n> :NERDTree<CR>
nnoremap <C-t> :NERDTreeToggle<CR>
nnoremap <C-f> :NERDTreeFind<CR>
let NERDTreeShowHidden=1

" Open lazygit
nnoremap <leader>lg :!lazygit<CR>

" Switch between buffers
nnoremap <F5> :buffers<CR>:buffer<Space>

" Tooggle centering
nnoremap <Leader>zz :let &scrolloff=999-&scrolloff<CR>

" Run npm run test
nnoremap <Leader>tt :w<CR> :!npm run test<CR>

" Set ESLint as your plugging manager
let g:ale_fixers = {
\ 'javascript': ['eslint']
\ }

let g:ale_sign_error = '❌'
let g:ale_sign_warning = '⚠️'
let g:ale_fix_on_save = 1

