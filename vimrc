set nocompatible
runtime! macros/matchit.vim
filetype plugin indent on
syntax enable

" ************************************************
" PLUGINS
" ************************************************
call plug#begin('~/.vim/plugged')

" Editor
Plug 'morhetz/gruvbox'
Plug 'nelstrom/vim-visual-star-search'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'scrooloose/nerdtree'
Plug 'terryma/vim-multiple-cursors'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'vim-scripts/YankRing.vim'

" Filetypes
Plug 'fatih/vim-go', { 'do': ':GoInstallBinaries' }
Plug 'hashivim/vim-terraform'
Plug 'leafgarland/typescript-vim'
Plug 'maxmellon/vim-jsx-pretty'
Plug 'othree/html5.vim'
Plug 'pangloss/vim-javascript'
Plug 'tbastos/vim-lua'
Plug 'tpope/vim-rails'
Plug 'jiangmiao/auto-pairs'

call plug#end()

" ************************************************
" PREFERENCES
" ************************************************
set autoindent
set autoread
set backspace=2
set clipboard=unnamed
set complete-=i
set completeopt=longest,menu,menuone,preview,noselect,noinsert
set display+=lastline
set belloff=all
set expandtab
set formatoptions+=j
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
set nowritebackup
set nrformats-=octal
set number
set ruler
set scrolloff=3
set sessionoptions-=options
set shiftround
set shiftwidth=2
set shortmess+=S
set showmatch
set sidescrolloff=3
set smartcase
set smartindent
set smarttab
set softtabstop=2
set splitright splitbelow
set tabstop=2
set termguicolors
set title
set ttimeout
set ttimeoutlen=50
set ttyfast
set undolevels=1000
set updatetime=100
set wildignore+=*.DS_Store,*\\vendor\\**
set wildmenu
set wildmode=longest:full,full
set signcolumn=number
if has("balloon_eval") && has("unix")
  set ballooneval
endif
if &t_Co == 8 && $TERM !~# '^linux'
  set t_Co=16
endif

let g:netrw_liststyle=3
let g:NERDTreeAutoDeleteBuffer=1
let g:NERDTreeMapUpdir='-'
let g:NERDTreeMinimalUI=1
let g:NERDTreeShowHidden=1
let g:NERDTreeWinSize=40
" Workaround for bottom panel staying big and not disappearing.
" https://github.com/preservim/nerdtree/issues/1321
let g:NERDTreeMinimalMenu=1

let g:javascript_plugin_flow=1

let g:markdown_fenced_languages=['css', 'html', 'javascript', 'json', 'graphql', 'sh', 'typescript=javascript', 'yaml']

let g:multi_cursor_select_all_key='<C-a>'

let g:yankring_window_height=10
let g:yankring_history_dir=$HOME.'/.vim/tmp/yankring/'

let g:gruvbox_contrast_dark='hard'
set background=dark

let g:go_highlight_types=1
let g:go_highlight_fields=1
let g:go_highlight_functions=1
let g:go_highlight_function_calls=1
let g:go_highlight_operators= 1
let g:go_highlight_extra_types=1
" disable since this is taken care of by coc.nvim
let g:go_def_mapping_enabled = 0
" disable all linters as that is taken care of by coc.nvim
let g:go_diagnostics_enabled = 0
let g:go_metalinter_enabled = []
" don't jump to errors after metalinter is invoked
let g:go_jump_to_error = 0

let g:coc_disable_transparent_cursor = 1
let g:coc_global_extensions = ['coc-solargraph']

" ************************************************
" MAPPINGS
" ************************************************
" Move between splits
noremap <C-h> <C-w>h
noremap <C-j> <C-w>j
noremap <C-k> <C-w>k
noremap <C-l> <C-w>l

" NERDTree in a buffer (like netrw)
nnoremap <silent>- :silent edit %:p:h<CR>
nnoremap <silent>_ :silent edit .<CR>

" Tab through popup menu items and allow return to select
function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~ '\s'
endfunction
inoremap <silent><expr> <Tab> pumvisible() ? "\<C-n>" : <SID>check_back_space() ? "\<Tab>" : coc#refresh()
inoremap <silent><expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-TAB>"
inoremap <silent><expr> <CR> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
inoremap <silent><expr> <C-@> coc#refresh()

" For my convenience
noremap <C-b> ^
noremap <C-e> g<S-_>

" The `g`oto and list commands
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
nnoremap <silent>ga :CocList --normal diagnostics<CR>
nnoremap <silent>gb :CocList buffers<CR>
nnoremap <silent>gF :call CocAction('jumpDefinition', 'vsplit')<CR>
nnoremap <silent>gh :call CocAction('doHover')<CR>
nnoremap <silent>gl :CocList files<CR>
nnoremap <silent>gL :CocListResume<CR>
nnoremap <silent>gs :CocList grep<CR>
xnoremap <silent>gs y :CocList grep <C-R>=escape(@",'$ ')<CR><CR>
nnoremap <silent>gu :call CocAction('showSignatureHelp')<CR>
nnoremap <silent>gV `[v`]
nnoremap <silent>gy :NERDTreeToggle<CR>
nnoremap gz :CocSearch<space>
xnoremap gz y :CocSearch <C-R>=escape(@",'$ ')<CR><CR>
nmap <silent>g\ <Plug>(coc-refactor)
nmap <silent>g. <Plug>(coc-codeaction)
vmap <silent>g. <Plug>(coc-codeaction-selected)

" Clear the search highlight
noremap <silent><leader>\ :nohlsearch<CR>

" Center of line
map gm :call cursor(0, len(getline('.'))/2)<CR>

" ************************************************
" AUTO COMMANDS
" ************************************************
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
    autocmd FileType lua setlocal shiftwidth=3

    " Abbrevs
    autocmd FileType javascript,javascript.jsx,typescript,typescript.tsx iabbrev <buffer> cdl console.log()<Left><C-R>=Eatchar('\s')<CR>

    " Theme
    autocmd vimenter * colorscheme gruvbox
  augroup END
endif
