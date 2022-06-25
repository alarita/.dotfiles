call plug#begin('~/.vim/plugged')
    Plug 'jelera/vim-javascript-syntax'
      
    " Use release branch (recommend)
    Plug 'neoclide/coc.nvim', {'branch': 'release'}
    " Plug 'luisiacc/gruvbox-baby', {'branch': 'main'}
    Plug 'jremmen/vim-ripgrep'
    " Plug 'tpope/vim-fugitive'
    " Plug 'leafgarland/typescript-vim'
    " Plug 'vim-utils/vim-man'
    Plug 'https://github.com/kien/ctrlp.vim.git'
    Plug 'mbbill/undotree'
    " Plug 'shime/vim-livedown'
    Plug 'leafOfTree/vim-vue-plugin'
    Plug 'w0rp/ale'
    Plug 'tpope/vim-surround'
    Plug 'preservim/nerdtree'
    Plug 'Xuyuanp/nerdtree-git-plugin'
    Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
    Plug 'ryanoasis/vim-devicons'
    " Plug 'vim-syntastic/syntastic'
    Plug 'tpope/vim-commentary'
    Plug 'itchyny/lightline.vim'
    Plug 'miyakogi/conoline.vim'
    Plug 'heavenshell/vim-jsdoc', {
        \ 'for': ['javascript', 'javascript.jsx','typescript'],
        \ 'do': 'make install'
      \}
    Plug 'acro5piano/import-js-from-history'
    " Plug 'morhetz/gruvbox'
    Plug 'lifepillar/vim-gruvbox8'
    Plug 'airblade/vim-gitgutter'
    Plug 'nvim-lua/plenary.nvim'
    Plug 'nvim-telescope/telescope.nvim'
    Plug 'voldikss/vim-floaterm'
    Plug 'tpope/vim-sleuth'
    Plug 'geekjuice/vim-mocha'
    Plug 'nvim-treesitter/nvim-treesitter' 
    " Plug 'p00f/nvim-ts-rainbow'
    " Plug 'luochen1990/rainbow'
call plug#end()

set encoding=utf-8
set termguicolors
set hidden
set laststatus=2
set cmdheight=1
set updatetime=300
set shortmess+=c
set noerrorbells
set tabstop=2 softtabstop=2
set shiftwidth=2
set smarttab
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
set splitright

set pastetoggle=<F3>
set noshowmode

let g:javascript_plugin_jsdoc = 1
let scrolloff=10

lua <<EOF
require'nvim-treesitter.configs'.setup {
  -- A list of parser names, or "all"
  ensure_installed = { "javascript", "typescript", "html", "vue", "yaml", "lua", "vim", "json", "rust", "go", "scss" },

  -- Install parsers synchronously (only applied to `ensure_installed`)
  sync_install = false,

  highlight = {
    -- `false` will disable the whole extension
    enable = true,

    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
    -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
    -- Using this option may slow down your editor, and you may see some duplicate highlights.
    -- Instead of true it can also be a list of languages
    additional_vim_regex_highlighting = false,
  },
}
EOF

function! GitStatus()
  let [a,m,r] = GitGutterGetHunkSummary()
  return printf('+%d ~%d -%d', a, m, r)
endfunction

set statusline+=%{GitStatus()}
let g:gitgutter_sign_allow_clobber = 1
let g:gitgutter_highlight_linenrs = 1
let g:gitgutter_set_sign_backgrounds = 1
highlight link GitGutterChangeLineNr Underlined

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
if has("nvim-0.5.0") || has("patch-8.1.1564")
  " Recently vim can merge signcolumn and number column into one
  set signcolumn=auto
else
  set signcolumn=auto
endif

" set colorcolumn=120
highlight ColorColumn ctermbg=0 guibg=lightgrey

" Coc.nvim
" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ CheckBackspace() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

" Make <CR> auto-select the first completion item and notify coc.nvim to
" format on enter, <cr> could be remapped by other vim plugin
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> K :call ShowDocumentation()<CR>

function! ShowDocumentation()
  if CocAction('hasProvider', 'hover')
    call CocActionAsync('doHover')
  else
    call feedkeys('K', 'in')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming.
nmap <F2> <Plug>(coc-rename)

" Formatting selected code.
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder.
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Applying codeAction to the selected region.
" Example: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap keys for applying codeAction to the current buffer.
nmap <leader>ac  <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
nmap <leader>qf  <Plug>(coc-fix-current)

" Run the Code Lens action on the current line.
nmap <leader>cl  <Plug>(coc-codelens-action)

" Map function and class text objects
" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)

" Remap <C-f> and <C-b> for scroll float windows/popups.
if has('nvim-0.4.0') || has('patch-8.2.0750')
  nnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  nnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
  inoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
  inoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
  vnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  vnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
endif

" Use CTRL-S for selections ranges.
" Requires 'textDocument/selectionRange' support of language server.
nmap <silent> <C-s> <Plug>(coc-range-select)
xmap <silent> <C-s> <Plug>(coc-range-select)

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocActionAsync('format')

" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR   :call     CocActionAsync('runCommand', 'editor.action.organizeImport')

" Add status line support, for integration with other plugin, checkout `:h coc-status`
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Mappings for CoCList
" Show all diagnostics.
nnoremap <silent><nowait> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions.
nnoremap <silent><nowait> <space>e  :<C-u>CocList extensions<cr>
" Show commands.
nnoremap <silent><nowait> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document.
nnoremap <silent><nowait> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols.
nnoremap <silent><nowait> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent><nowait> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent><nowait> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list.
nnoremap <silent><nowait> <space>p  :<C-u>CocListResume<CR>

" coc extensions
let g:coc_global_extensions = [
  \ 'coc-snippets',
  \ 'coc-pairs',
  \ 'coc-tsserver',
  \ 'coc-vue',
  \ 'coc-vetur',
  \ 'coc-json',
  \ 'coc-yaml',
  \ 'coc-typos',
  \ ]

" Coc.nvim END

" Load the colorscheme
" autocmd vimenter * ++nested colorscheme gruvbox
" colorscheme gruvbox
" set background=dark
set background=dark
colorscheme gruvbox8
let g:airline_theme='base16'

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

" ctrlp
let g:ctrlp_user_command = ['.git/', 'git --git-dir=%s/.git ls-files -oc --exclude-standard']

nnoremap <leader>h :wincmd h<CR>
nnoremap <leader>j :wincmd j<CR>
nnoremap <leader>k :wincmd k<CR>
nnoremap <leader>l :wincmd l<CR>
nnoremap <leader>ww :w<CR>
nnoremap <leader>cw :only<CR>
nnoremap <leader>ch :noh<CR>
" Alt-q to quit current file
nnoremap <A-q> :bw!<CR>
nnoremap <A-w> :bd!<CR>
if has('nvim')
  nnoremap <leader>ec :e ~/Codes/alarita/.dotfiles/vim/init.vim<CR>
else
  nnoremap <leader>ec :e ~/Codes/alarita/.dotfiles/vim/.vimrc<CR>
endif
nnoremap <leader>u :UndotreeShow<CR>
nnoremap <leader>pv :wincmd v<bar> :Ex <bar> :vertical resize 30<CR>
nnoremap <Leader>ps :Rg<SPACE>
nnoremap <silent> <Leader>+ :vertical resize +5<CR>
nnoremap <silent> <Leader>- :vertical resize -5<CR>
nnoremap <silent> <Leader>tn :set nu! rnu!<CR>

nmap <silent> <C-l> <Plug>(jsdoc)

" NerdTree Mapping
nnoremap <leader>n :NERDTreeFocus<CR>
nnoremap <C-n> :NERDTree<CR>
nnoremap <C-t> :NERDTreeToggle<CR>
nnoremap <C-f> :NERDTreeFind<CR>
let NERDTreeShowHidden=1

" Open lazygit
nnoremap <leader>lg :FloatermNew --height=0.95 --width=0.95 --wintype=float --title=lazygit lazygit<CR>

" Switch between buffers
nnoremap <F5> :buffers<CR>:buffer<Space>

" Tooggle centering
nnoremap <Leader>zz :let &scrolloff=999-&scrolloff<CR>

" Run npm run test
nnoremap <Leader>tt :w<CR> :edit term://yarn test<CR>

" Telescope
nnoremap <leader>ff <cmd>Telescope find_files hidden=true<cr>
nnoremap <leader>fg <cmd>Telescope live_grep hidden=true<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>

" Set ESLint as your plugging manager
let g:ale_fixers = {
\ 'javascript': ['eslint']
\ }

let g:ale_sign_error = '❌'
let g:ale_sign_warning = '⚠️'
let g:ale_fix_on_save = 1

" vim mocha
let g:mocha_js_command = ":vsplit term://node bundle-tests --entrypath={spec} && yarn mocha --timeout 5000 --enable-source-maps --require=src/test/setup.js test-bundles/{spec}"
nnoremap <Leader>tc :wa<CR> :call RunCurrentSpecFile()<CR>
nnoremap <Leader>ti :wa<CR> :call RunNearestSpec()<CR>
nnoremap <Leader>tl :wa<CR> :call RunLastSpec()<CR>

" cloud-backend keymap
nnoremap <Leader>t1 :FloatermNew --title=devtest1 --autoclose=0 --position=topright AWS_PROFILE=spx-assh yarn sls spx-post-deploy<cr>

" Terminal Function
let g:term_buf = 0
let g:term_win = 0
function! TermToggle(height)
    if win_gotoid(g:term_win)
        hide
    else
        botright new
        exec "resize " . a:height
        try
            exec "buffer " . g:term_buf
        catch
            call termopen($SHELL, {"detach": 0})
            let g:term_buf = bufnr("")
            set nonumber
            set norelativenumber
            set signcolumn=no
        endtry
        startinsert!
        let g:term_win = win_getid()
    endif
endfunction

" Toggle terminal on/off (neovim)
nnoremap <A-t> :call TermToggle(20)<CR>
inoremap <A-t> <Esc>:call TermToggle(20)<CR>
tnoremap <A-t> <C-\><C-n>:call TermToggle(20)<CR>

" Terminal go back to normal mode
tnoremap <Esc> <C-\><C-n>
tnoremap :q! <C-\><C-n>:q!<CR>

