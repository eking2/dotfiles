call plug#begin('~/.vim/plugged')

Plug 'ncm2/ncm2'
Plug 'roxma/nvim-yarp'
Plug 'ncm2/ncm2-path'
Plug 'ncm2/ncm2-jedi'
Plug 'Yggdroot/indentLine' 
Plug 'tpope/vim-commentary'
Plug 'machakann/vim-highlightedyank'
Plug '/usr/local/opt/fzf'
Plug 'junegunn/fzf.vim'
Plug 'justinmk/vim-dirvish'
Plug 'vimwiki/vimwiki'
Plug 'chrisbra/csv.vim'
Plug 'jpalardy/vim-slime'
Plug 'Chiel92/vim-autoformat'
Plug 'lervag/vimtex'
Plug 'numirias/semshi', {'do': ':UpdateRemotePlugins'}
Plug 'tmsvg/pear-tree'
Plug 'machakann/vim-sandwich'

call plug#end()

" vimtex
let g:vimtex_compiler_progname = 'nvr'
let g:tex_flavor  = 'latex'
let g:tex_conceal = ''
let g:vimtex_fold_manual = 1
let g:vimtex_latexmk_continuous = 1
let g:vimtex_view_method = 'skim'

let mapleader="\<Space>" 

" NCM2
augroup NCM2
  autocmd!
  " enable ncm2 for all buffers
  autocmd BufEnter * call ncm2#enable_for_buffer()
  " :help Ncm2PopupOpen for more information
  set completeopt=noinsert,menuone,noselect
  " uncomment this block if you use vimtex for LaTex
  autocmd Filetype tex call ncm2#register_source({
            \ 'name': 'vimtex',
            \ 'priority': 8,
            \ 'scope': ['tex'],
            \ 'mark': 'tex',
            \ 'word_pattern': '\w+',
            \ 'complete_pattern': g:vimtex#re#ncm2,
            \ 'on_complete': ['ncm2#on_complete#omni', 'vimtex#complete#omnifunc'],
            \ })
augroup END

" Tab to select autocomplete, Shift-Tab to reverse
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

" Enter will always newline
inoremap <expr> <CR> (pumvisible() ? "\<c-y>\<cr>" : "\<CR>")

" Ignore hidden files 
let g:dirvish_mode = ':silent keeppatterns g@\v/\.[^\/]+/?$@d _'

" Enable going down in case text is wrapped
nnoremap j gj
nnoremap k gk
nnoremap q :

" esc 
inoremap jj <ESC>
nnoremap <leader>h :noh<CR>

" unbind ex mode
map Q <Nop>

set nu
set ts=4
set shiftwidth=4
set expandtab
set softtabstop=4
set autoindent
set showmatch
set hlsearch
set shortmess+=c
set ignorecase
set smartcase
set mouse+=a
set title
set clipboard=unnamed
set laststatus=0
set hidden
set nocompatible
set scrolloff=3
filetype plugin on
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o

" Markdown code blocks
au BufNewFile,BufReadPost *.md set filetype=markdown
let g:markdown_fenced_languages = ['html', 'python', 'bash=sh']
let g:vimwiki_list = [{'path': '~/vimwiki/',
                     \ 'syntax': 'markdown', 'ext': '.md'}]
let g:vimwiki_global_ext = 0

let g:slime_target = "tmux"
" tmux:
let g:slime_default_config = {"socket_name": "default", "target_pane": "2"}
let g:slime_python_ipython = 1
let g:slime_dont_ask_default = 1

" wrap markdown at 80 char
au BufRead,BufNewFile *.md setlocal textwidth=80

" Set colorscheme
colorscheme ron
hi Operator ctermfg=yellow
hi PmenuSel ctermfg=lightgrey
hi Pmenu ctermbg=lightcyan
