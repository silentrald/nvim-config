" Previous setup

:set number
:set relativenumber
:set foldmethod=syntax
:set foldlevel=2
:set foldnestmax=10

filetype plugin indent on
syntax on
:set ts=2 sts=2 sw=2 et si
:set cindent
:set mouse=a

:set listchars+=tab:>-,trail:.,lead:.
:set list

" :packadd termdebug
" let g:termdebug_wide=1

call plug#begin()

Plug 'tpope/vim-surround' " Surrounding ysw)
Plug 'preservim/nerdtree' " NerdTree
Plug 'Xuyuanp/nerdtree-git-plugin'
" Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
Plug 'tpope/vim-commentary' " For Commenting gcc & gc
Plug 'vim-airline/vim-airline' " Status bar
Plug 'lifepillar/pgsql.vim' " PSQL Pluging needs :SQLSetType pgsql.vim
Plug 'ap/vim-css-color' " CSS Color Preview
" Plug 'neoclide/coc.nvim', {'branch': 'release'}  " Auto Completion
Plug 'ryanoasis/vim-devicons' " Developer Icons
Plug 'tc50cal/vim-terminal' " Vim Terminal
Plug 'preservim/tagbar' " Tagbar for code navigation
Plug 'terryma/vim-multiple-cursors' " CTRL + N for multiple cursors
Plug 'vim-autoformat/vim-autoformat'
Plug 'folke/tokyonight.nvim'
Plug 'xiyaowong/nvim-transparent'
Plug 'nvim-treesitter/nvim-treesitter'
Plug 'cuducos/yaml.nvim'
Plug 'rhysd/vim-clang-format'
Plug 'jiangmiao/auto-pairs'
Plug 'nvim-lua/plenary.nvim'
Plug 'folke/todo-comments.nvim'
Plug 'folke/trouble.nvim'
Plug 'BurntSushi/ripgrep'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'airblade/vim-rooter'
Plug 'voldikss/vim-floaterm'
Plug 'mg979/vim-visual-multi', {'branch': 'master'}
Plug 'APZelos/blamer.nvim'
Plug 'andweeb/presence.nvim'
Plug 'rust-lang/rust.vim'
" Plug 'puremourning/vimspector'
Plug 'sakhnik/nvim-gdb', { 'do': ':!./install.sh' }
" Plug 'yaegassy/coc-volar', { 'do': 'yarn install --frozen-lockfile' }
" Plug 'yaegassy/coc-volar-tools', { 'do': 'yarn install --frozen-lockfile' }
Plug 'sindrets/diffview.nvim'

:set encoding=UTF-8

call plug#end()

:set path+=**

nnoremap <C-t> :tabnew<CR>
nnoremap <C-x> :tabclose<CR>
nnoremap <C-y> :tabnext<CR>

nnoremap <C-S-Down> :m .+1<CR>==
nnoremap <C-S-Up> :m .-2<CR>==
inoremap <C-S-Down> <Esc>:m .+1<CR>==gi
inoremap <C-S-Up> <Esc>:m .-2<CR>==gi
vnoremap <C-S-Down> :m '>+1<CR>gv=gv
vnoremap <C-S-Up> :m '<-2<CR>gv=gv

nnoremap <C-f> :FloatermToggle<CR>
tnoremap <C-f> <C-\><C-n>:FloatermToggle<CR>
tnoremap <C-t> <C-\><C-n>:FloatermNew<CR>
tnoremap <C-x> <C-\><C-n>:FloatermKill<CR>
tnoremap <C-y> <C-\><C-n>:FloatermNext<CR>

nnoremap <C-h> :DiffviewOpen<CR>

nnoremap <C-d> :TodoLocList<CR>
nnoremap <C-b> :NERDTreeToggle<CR>
nnoremap <C-l> :call CocActionAsync('jumpDefinition')<CR>
nnoremap <C-s> :w<CR>
nnoremap <A-s> :ClangFormat<CR>
autocmd FileType rust nnoremap <A-s> :RustFmt<CR>

nmap <F8> :TagbarToggle<CR>

:set completeopt-=preview " For No Previews

:colorscheme tokyonight
let g:transparent_enabled = v:true
hi Search guibg=purple guifg=white
hi IncSearch guifg=white guibg=black
hi LineNr guifg=#0076CC
hi Comment guifg=#0076CC

" Nerdtree config
let g:NERDTreeDirArrowExpandable="+"
let g:NERDTreeDirArrowCollapsible="~"
let g:NERDTreeMinimalMenu=1
let g:NERDTreeShowHidden = 1
let g:NERDTreeGitStatusWithFlags = 1
hi! link NERDTreeFlags NERDTreeDir

let g:WebDevIconsUnicodeDecorateFileNodesExtensionSymbols = {}
let g:WebDevIconsUnicodeDecorateFileNodesExtensionSymbols['tpp'] = ''

let g:WebDevIconsUnicodeDecorateFileNodesExactSymbols = {}
let g:WebDevIconsUnicodeDecorateFileNodesExactSymbols['.env'] = ''
let g:WebDevIconsUnicodeDecorateFileNodesExactSymbols['.clang-format'] = ''
let g:WebDevIconsUnicodeDecorateFileNodesExactSymbols['.clang-tidy'] = ''
let g:WebDevIconsUnicodeDecorateFileNodesExactSymbols['CMakeLists.txt'] = '卑'

let g:NERDTreeGitStatusIndicatorMapCustom = {
                \ 'Modified'  :'✹',
                \ 'Staged'    :'✚',
                \ 'Untracked' :'✭',
                \ 'Renamed'   :'➜',
                \ 'Unmerged'  :'═',
                \ 'Deleted'   :'✖',
                \ 'Dirty'     :'✗',
                \ 'Ignored'   :'☒',
                \ 'Clean'     :'✔︎',
                \ 'Unknown'   :'?',
                \ }

function! CheckBackSpace()
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~ '\s'
endfunction

inoremap <silent><expr> <Tab>
  \ coc#pum#visible() ? coc#pum#next(1) :
  \ coc#expandableOrJumpable() ? "\<C-r>=coc#snippet#next()\<CR>" :
  \ CheckBackSpace() ? "\<Tab>" :
  \ coc#refresh()

inoremap <silent><expr> <S-Tab>
  \ coc#pum#visible() ? coc#pum#prev(1) :
  \ coc#expandableOrJumpable() ? "\<C-r>=coc#snippet#prev()\<CR>" :
  \ CheckBackSpace() ? "\<S-Tab>" :
  \ coc#refresh()

inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

let g:coc_snippet_next = '<Tab>'
let g:coc_snippet_prev = '<S-Tab>'

imap <C-j> <Plug>(coc-snippets-expand)
vmap <Tab> <Plug>(coc-snippets-select)
" let g:coc_snippet_next = '<C-k>'
" let g:coc_snippet_prev = '<C-j>'
imap <S-Tab> <Plug>(coc-snippets-expand-jump)
xmap <leader>x  <Plug>(coc-convert-snippet)

" Use <c-space> to trigger completion.
" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

au! BufNewFile,BufRead *.tpp set filetype=cpp

" Use K to show documentation in preview window.
nnoremap <silent> K :call ShowDocumentation()<CR>

function! ShowDocumentation()
  if CocAction('hasProvider', 'hover')
    call CocActionAsync('doHover')
  else
    call feedkeys('K', 'in')
  endif
endfunction

if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

nmap <silent> <A-Up> :wincmd k<CR>
nmap <silent> <A-Down> :wincmd j<CR>
nmap <silent> <A-Left> :wincmd h<CR>
nmap <silent> <A-Right> :wincmd l<CR>

nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" imap <silent> <A-CR> :o <CR>

" nnoremap <C-d> :call vimspector#Launch()<CR>
" tnoremap <C-d> :call vimspector#Reset()<CR>
" 

" Comments
nmap <C-_> gcc
vmap <C-_> gc

let g:blamer_enabled = 1
let g:blamer_delay = 100
let g:blamer_prefix = '> '
let g:blamer_template = '<committer>, <summary> (<committer-time>)'
let g:blamer_date_time = '%m/%d/%Y, %I:%M %p'
let g:blamer_show_in_visual_modes = 0
let g:blamer_show_in_insert_modes = 0
hi Blamer guifg=red

" TODO
lua << EOF
  require("todo-comments").setup {}
EOF

