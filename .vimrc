" Disable vi compatibility
set nocompatible

" Plugins
" -----------------------------------------------------------------------------
call plug#begin('~/.vim/plugged')

" Editor
Plug 'arcticicestudio/nord-vim'
Plug 'alvan/vim-closetag'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'dyng/ctrlsf.vim'
Plug 'ervandew/supertab'
Plug 'henrik/vim-indexed-search'
Plug 'mhinz/vim-grepper'
Plug 'mkitt/pigment'
Plug 'mkitt/tabline.vim'
Plug 'nelstrom/vim-visual-star-search'
Plug 'drewtempelmeyer/palenight.vim'
Plug 'scrooloose/nerdtree'
Plug 'terryma/vim-multiple-cursors'
Plug 'ton/vim-bufsurf'
Plug 'w0rp/ale'
Plug 'yssl/QFEnter'
Plug 'prettier/vim-prettier', {
  \ 'do': 'yarn install',
  \ 'for': ['javascript', 'typescript', 'json', 'graphql', 'markdown'] }

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

" Utility
Plug 'ngmy/vim-rubocop'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rhubarb'

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
  let g:ctrlp_user_command='rg --files %s'
  let g:ctrlp_use_caching=0
endif

let g:ctrlp_extensions=['line']
let g:ctrlp_cache_dir=$HOME.'/.vim/tmp/ctrlp/'
let g:ctrlp_custom_ignore='vendor/bundle\|.bundle\|tmp\|spec/support/fixtures\|docs/api\|public/uploads\|.git$'
let g:ctrlp_map='<F1>'

let g:ctrlsf_auto_close=0


let g:closetag_filenames = '*.html,*.jsx, *.js, *.ts, *tsx'
let g:netrw_liststyle=3
let g:NERDTreeWinSize=40
let g:NERDTreeMinimalUI=1
let g:NERDTreeAutoDeleteBuffer=1
let g:NERDTreeMapUpdir='-'

let g:SuperTabLongestEnhanced=1
let g:SuperTabLongestHighlight=1
let g:SuperTabDefaultCompletionType='<C-n>'

let g:qfenter_keymap = {}
let g:qfenter_keymap.vopen = ['<C-v>']
let g:qfenter_keymap.hopen = ['<C-CR>', '<C-s>', '<C-x>']
let g:qfenter_keymap.topen = ['<C-t>']

let g:ale_close_preview_on_insert=1
let g:ale_completion_enabled=1
let g:ale_completion_max_suggestions=13
let g:ale_fix_on_save=1
let g:ale_fixers={'javascript': ['eslint', 'prettier'], 'typescript': ['prettier', 'tslint'], 'ruby': ['rubocop']}
let g:ale_history_log_output=0
let g:ale_javascript_eslint_executable='eslint_d'
let g:ale_javascript_eslint_use_global=1
let g:ale_keep_list_window_open=0
let g:ale_linters={'html': ['tidy']}
" let g:ale_open_list='on_save'
let g:ale_set_balloons=1
let g:ale_sign_error='☠️'
let g:ale_sign_warning='⚠️'

let g:javascript_plugin_flow=1

let g:yankring_window_height=10
let g:yankring_history_dir=$HOME.'/.vim/tmp/yankring'

let g:indexed_search_colors=0

let g:vimrubocop_config='.rubocop.yml'

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

" Another alternative mapping
nnoremap <silent><C-@> :CtrlP<CR>

" NERDTree in a buffer (like netrw)
nnoremap <silent>- :silent edit %:p:h<CR>
nnoremap <silent>_ :silent edit .<CR>

" Override jumplist commands
nnoremap <silent><C-i> :BufSurfBack<CR>
nnoremap <silent><C-o> :BufSurfForward<CR>

" Function keys
let g:ctrlp_map='<F1>'
noremap <F2> :NERDTreeToggle<CR>
noremap <F3> :CtrlPBuffer<CR>
nnoremap <F4> :GrepperRg<space>
xnoremap <F4> y:<c-u>GrepperRg -F <C-R>=shellescape(expand(@"),1)<CR>
nmap <F5> <Plug>CtrlSFPrompt
vmap <F5> <Plug>CtrlSFVwordExec
noremap <F10> :vertical wincmd f<CR>
noremap <F11> :BufSurfBack<CR>
noremap <F12> :BufSurfForward<CR>

" The `g` commands (testing)
nmap gad <Plug>(ale_documentation)
nmap gaf <Plug>(ale_find_references)
nmap gan <Plug>(ale_next_wrap)
nmap gap <Plug>(ale_previous_wrap)
nmap gf <Plug>(ale_go_to_definition)
nmap gF <Plug>(ale_go_to_definition_in_vsplit)
nmap gh <Plug>(ale_hover)
nnoremap <silent>gl :CtrlP<CR>
nnoremap <C-p> :CtrlP<CR>
nnoremap <silent>gL :CtrlPBuffer<CR>
nnoremap <silent>gy :NERDTreeToggle<CR>
nnoremap gs :GrepperRg<space>
xnoremap gs y:<c-u>GrepperRg -F <C-R>=shellescape(expand(@"),1)<CR>
nmap gz <Plug>CtrlSFPrompt
vmap gz <Plug>CtrlSFVwordExec

" Visually select the text that was last edited/pasted
nnoremap <silent>gV `[v`]

" Clear the search highlight
noremap <silent><leader>\ :nohlsearch<CR>

" Hide the quickfix window (ALE)
noremap <silent><leader>] :lcl<CR>

" Remove whitespace
noremap <silent><leader>CW :%s/\s\+$//<CR>

" Sane Ignore For ctrlp
let g:ctrlp_custom_ignore = {
  \ 'dir':  '\.git$\|\.hg$\|\.svn$\|\.yardoc\|public\/images\|public\/system\|data\|log\|tmp$',
  \ 'file': '\.exe$\|\.so$\|\.dat$'
  \ }
" Filetypes
" -----------------------------------------------------------------------------
func! Eatchar(pat)
  let c = nr2char(getchar(0))
  return (c =~ a:pat) ? '' : c
endfunc

if has("autocmd")
  augroup FTOptions
    autocmd!
    autocmd BufRead,BufNewFile *.md set filetype=markdown
    autocmd BufRead,BufNewFile *.ts set filetype=javascript
    autocmd BufRead,BufNewFile *.tsx set filetype=javascript.jsx
    autocmd BufRead,BufNewFile .env.* set filetype=sh
    autocmd BufRead,BufNewFile .{*}rc set filetype=json
    autocmd BufRead,BufNewFile COMMIT_EDITMSG setlocal spell
    autocmd FileType markdown,text,txt setlocal tw=80 linebreak nolist wrap spell
    autocmd QuickFixCmdPost *grep* botright copen
    autocmd QuitPre * if empty(&buftype) | lclose | endif
    autocmd User Grepper :resize 10

    " Abbreviations
    autocmd FileType javascript,javascript.jsx iabbrev <buffer> bgc backgroundColor: '',<Left><Left><C-R>=Eatchar('\s')<CR>
    autocmd FileType javascript,javascript.jsx iabbrev <buffer> cdl console.log()<Left><C-R>=Eatchar('\s')<CR>
  augroup END
endif

" Theme


colorscheme nord

" Airline Config
" -----------------------------------------------------------------------------
set laststatus=2                                   " always show status bar
set guifont=Source\ Code\ Pro\ for\ Powerline      " tells airline to use the proper font for special chars
let g:airline_theme = 'nord'
let g:airline_powerline_fonts = 1
let g:airline#extensions#ycm#enabled = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#formatter = 'jsformatter'
set ttimeoutlen=50                                 

" Load user config
" -----------------------------------------------------------------------------

let g:ctrlp_custom_ignore = 'node_modules\|DS_Store\|git'

if filereadable(expand("~/.vimrc.local"))
  source ~/.vimrc.local
endif
" Yank/paste contents using an unnamed register
vnoremap <silent><leader>y "xy
noremap <silent><leader>p "xp
set clipboard=unnamed
