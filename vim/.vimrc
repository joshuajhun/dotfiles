set nocompatible

" Plugins
" -----------------------------------------------------------------------------
call plug#begin('~/.vim/plugged')

" Editor
Plug 'challenger-deep-theme/vim', { 'as': 'challenger-deep' }
Plug 'nvim-lualine/lualine.nvim'
Plug 'kyazdani42/nvim-web-devicons'
Plug 'EdenEast/nightfox.nvim',{ 'tag': 'v1.0.0'} " Vim-Plug
Plug 'kyoz/purify',{ 'rtp': 'vim'}
Plug 'liuchengxu/space-vim-dark'
Plug 'rking/ag.vim'
Plug 'sainnhe/sonokai'
Plug 'alvan/vim-closetag'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'kyazdani42/nvim-web-devicons'
Plug 'henrik/vim-indexed-search'
Plug 'mhinz/vim-grepper'
Plug 'mkitt/pigment'
Plug 'mkitt/tabline.vim'
Plug 'drewtempelmeyer/palenight.vim'
Plug 'scrooloose/nerdtree'
Plug 'mg979/vim-visual-multi',{'branch': 'master'}
Plug 'ton/vim-bufsurf'
Plug 'neoclide/coc.nvim',{'branch': 'release'}
Plug 'yssl/QFEnter'
Plug 'prettier/vim-prettier',{
  \ 'do': 'yarn install --frozen-lockfile --production',
  \ 'for': ['javascript', 'typescript', 'json', 'graphql', 'markdown']}

Plug 'larsbs/vimterial'
Plug 'sainnhe/edge'
Plug 'ghifarit53/tokyonight-vim'
" Editing
Plug 'tpope/vim-abolish'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-unimpaired'

" Filetypes
Plug 'jparise/vim-graphql'
Plug 'kchmck/vim-coffee-script'
Plug 'mxw/vim-jsx'
Plug 'othree/html5.vim'
Plug 'pangloss/vim-javascript'
Plug 'tpope/vim-haml'
Plug 'tpope/vim-rails'
Plug 'vim-python/python-syntax'

" Utility
Plug 'ngmy/vim-rubocop'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rhubarb'

" Neovim-only (Lua) plugins; plain Vim also reads this file
if has('nvim')
  Plug 'coder/claudecode.nvim'
endif

call plug#end()

runtime! macros/matchit.vim
filetype plugin indent on
syntax enable

" Preferences
" -----------------------------------------------------------------------------
set autoindent
set autoread
set backspace=2
set clipboard=unnamed
set complete-=i
set completeopt=longest,menu,menuone,preview,noselect,noinsert
set display+=lastline
set expandtab
set hidden
set history=1000
set hlsearch
set ignorecase
set incsearch
set laststatus=2
set list
set listchars=tab:▸\ ,eol:¬,trail:·
set mouse=a
set nobackup
set nojoinspaces
set noshowcmd
set nostartofline
set noswapfile
set nowrap
set nrformats-=octal
set number
set ruler
set scrolloff=3
set sessionoptions-=options
set shiftround
set shiftwidth=2
set showmatch
set sidescrolloff=3
set smartcase
set smartindent
set smarttab
set softtabstop=2
set splitright splitbelow
set tabstop=2
set title
set ttimeout
set ttimeoutlen=50
set ttyfast
set undolevels=1000
set wildignore+=*.DS_Store
set wildmenu
set wildmode=longest:full,full


if has("balloon_eval") && has("unix")
  set ballooneval
endif

if &t_Co == 8 && $TERM !~# '^linux'
  set t_Co=16
endif

if v:version > 703 || v:version == 703 && has("patch541")
  set formatoptions+=j
endif

if executable('rg')
  set grepprg=rg\
 endif

let g:python_highlight_all = 1
let g:ctrlsf_auto_close=0
let g:ctrlsf_backend = 'rg'

let g:closetag_filenames = '*.html,*.jsx, *.js, *.ts, *tsx'
let g:netrw_liststyle=3
let g:NERDTreeWinSize=40
let g:NERDTreeMinimalUI=1
let g:NERDTreeAutoDeleteBuffer=1
let g:NERDTreeMapUpdir='-'

" let g:SuperTabLongestEnhanced=1
" let g:SuperTabLongestHighlight=1
" let g:SuperTabDefaultCompletionType='<C-n>'

let g:qfenter_keymap = {}
let g:qfenter_keymap.vopen = ['<C-v>']
let g:qfenter_keymap.hopen = ['<C-CR>', '<C-s>', '<C-x>']
let g:qfenter_keymap.topen = ['<C-t>']

let g:javascript_plugin_flow=1

let g:yankring_history_dir=$HOME.'/.vim/tmp/yankring'

let g:indexed_search_colors=0

let g:vimrubocop_config='.rubocop.yml'
let g:yats_host_keyword = 0
" Mappings
" -----------------------------------------------------------------------------
"remap esc
inoremap jj <Esc>

" RSI reduction
"nnoremap j gj

nnoremap k gk

" Move between splits
noremap <C-h> <C-w>h
noremap <C-j> <C-w>j
noremap <C-k> <C-w>k
noremap <C-l> <C-w>l

" NERDTree in a buffer (like netrw)
nnoremap <silent>- :silent edit %:p:h<CR>
nnoremap <silent>_ :silent edit .<CR>

" Override jumplist commands
nnoremap <silent><C-i> :BufSurfBack<CR>
nnoremap <silent><C-o> :BufSurfForward<CR>

" Tab through popup menu items and allow return to select
function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction
inoremap <silent><expr> <TAB> coc#pum#visible() ? coc#pum#next(1) : CheckBackspace() ? "\<Tab>" : coc#refresh()
inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"
inoremap <silent><expr> <C-@> coc#refresh()

" The `g`oto and list commands
nnoremap <silent><nowait><C-@> :CocList<CR>
nnoremap <silent><nowait><C-c> :CocList commands<CR>
nnoremap <silent><nowait>ga :CocList --normal diagnostics<CR>
nnoremap <silent><nowait>gb :CocList buffers<CR>
nnoremap <silent><nowait>gd :call CocActionAsync('jumpTypeDefinition')<CR>
nnoremap <silent><nowait>gf :call CocActionAsync('jumpDefinition')<CR>
nnoremap <silent><nowait>gF :call CocActionAsync('jumpDefinition', 'vsplit')<CR>
nnoremap <silent><nowait>gh :call CocActionAsync('doHover')<CR>
nnoremap <silent><nowait>gl :CocList files<CR>
nnoremap <silent><nowait>gL :CocListResume<CR>
nnoremap <silent><nowait>gr :call CocActionAsync('jumpReferences')<CR>
nnoremap <silent><nowait>gs :CocList grep<CR>
xnoremap <silent><nowait>gs y :CocList grep <C-R>=escape(@",'$ ')<CR><CR>
nnoremap <silent><nowait>gu :call CocActionAsync('showSignatureHelp')<CR>
nnoremap <silent><nowait>gV `[v`]
nnoremap <silent><nowait>gy :NERDTreeToggle<CR>
nnoremap gz :CocSearch<space>
xnoremap gz y :CocSearch <C-R>=escape(@",'$ ')<CR><CR>
nmap <silent><nowait>g/ <Plug>(coc-refactor)
nmap <silent><nowait>g. <Plug>(coc-codeaction)
vmap <silent><nowait>g. <Plug>(coc-codeaction-selected)

" Custom unimpaireds
nmap <silent>[g <Plug>(coc-diagnostic-prev)
nmap <silent>]g <Plug>(coc-diagnostic-next)

" Clear the search highlight
noremap <silent><leader>\ :nohlsearch<CR>

" write to /etc 
cmap w!! %!sudo tee > /dev/null

" Remove whitespace
"noremap <silent><leader>CW :%s/\s\+$//<CR>

" Auto Commands
" --------------------------------------
func! Eatchar(pat)
  let c = nr2char(getchar(0))
  return (c =~ a:pat) ? '' : c
endfunc

if has("autocmd")
  augroup FTOptions
    autocmd!
    autocmd BufRead,BufNewFile *.md set filetype=markdown
    autocmd BufRead,BufNewFile *.ts set syntax=javascript
    autocmd BufRead,BufNewFile *.tsx set filetype=typescript.tsx
    autocmd BufRead,BufNewFile *.tsx set syntax=javascript.jsx
    autocmd BufRead,BufNewFile .env.* set filetype=sh
    autocmd BufRead,BufNewFile COMMIT_EDITMSG setlocal spell
    autocmd FileType markdown,text,txt setlocal textwidth=80 linebreak nolist wrap spell
    autocmd FileType qf setlocal wrap
    autocmd QuickFixCmdPost *grep* botright copen
    autocmd QuitPre * if empty(&buftype) | lclose | endif
    " Abbreviations
    autocmd FileType javascript,javascript.jsx,typescript,typescript.tsx iabbrev <buffer> bgc backgroundColor: '',<Left><Left><C-R>=Eatchar('\s')<CR>
    autocmd FileType javascript,javascript.jsx,typescript,typescript.tsx iabbrev <buffer> sdb outline: '1px dotted blue',<C-R>=Eatchar('\s')<CR>
    autocmd FileType javascript,javascript.jsx,typescript,typescript.tsx iabbrev <buffer> sdb outline: '1px dotted blue',<C-R>=Eatchar('\s')<CR>
    autocmd FileType javascript,javascript.jsx,typescript,typescript.tsx iabbrev <buffer> cdl console.log()<Left><C-R>=Eatchar('\s')<CR>
  augroup END
endif

" Theme
syntax on " This is required
colorscheme challenger_deep 

if has('nvim') || has('termguicolors')
  set termguicolors
endif

" Airline Config
" -----------------------------------------------------------------------------
set laststatus=2                                   " always show status bar
set guifont=Source\ Code\ Pro\ for\ Powerline      " tells airline to use the proper font for special chars
 let g:airline_theme = 'challenger_deep'
 let g:airline_powerline_fonts = 1
 let g:airline#extensions#ycm#enabled = 1
 let g:airline#extensions#tabline#enabled = 1
 let g:airline#extensions#tabline#formatter = 'jsformatter'
 set ttimeoutlen=50

" Claude Code (Neovim only)
" -----------------------------------------------------------------------------
if has('nvim')
lua << EOF
  -- pcall so a fresh machine doesn't error before :PlugInstall has run
  local ok, claudecode = pcall(require, "claudecode")
  if ok then
    claudecode.setup({
      terminal = {
        provider = "native",
        split_side = "right",
        split_width_percentage = 0.35,
      },
    })
  end
EOF
  " Same shape as the coc maps: g-prefixed, and the visual-mode version of a
  " key acts on the selection (like gs/gz). In a Claude diff, :w accepts and
  " :q rejects; /resume and /model work inside the Claude panel.
  nnoremap <silent><nowait>gC :ClaudeCode<CR>
  nnoremap <silent><nowait>gA :ClaudeCodeAdd %<CR>
  xnoremap <silent><nowait>gA :ClaudeCodeSend<CR>
endif

" Load user config
" -----------------------------------------------------------------------------

let g:ctrlp_custom_ignore = 'node_modules\|DS_Store\|git'

if filereadable(expand("~/.vimrc.local"))
  source ~/.vimrc.local
endif
" Yank/paste contents using an unnamed register
vnoremap <silent><leader>y "xy
noremap <silent><leader>p "xp